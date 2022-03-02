//
//  LFCarViewController.m
//  dysx
//
//  Created by chengbo on 2022/2/26.
//

#import "LFCarViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

#define DefaultLocationTimeout  2
#define DefaultReGeocodeTimeout 2

@interface LFCarViewController () <MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapRoute *route;
/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;
/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;
@property (nonatomic, strong) MAPointAnnotation *currentAnnotation;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
@property (nonatomic, strong) MAPinAnnotationView *annotationView;
@property (nonatomic, assign) CGFloat annotationViewAngle;
/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, assign) BOOL headingCalibration;
@property (nonatomic, strong) CLHeading *heading;

@end

@implementation LFCarViewController

- (void)viewDidLoad {
    _headingCalibration = NO;
    [super viewDidLoad];
    self.title = @"找车";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupSubviews];
    [self addDefaultAnnotations];
    
    
    [self initCompleteBlock];
    [self configLocationManager];
    [self requestLocation];
    NSLog(@"222222222222222222222lat:%f;lon:%f;222222222222222222222222", _startCoordinate.latitude, _startCoordinate.longitude);
//    [self getOriginalAndDestination];

    [self initSearchAPI];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self startHeadingLocation];
    
    if ([AMapLocationManager headingAvailable] == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持方向功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)configLocationManager {
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    
    [self.locationManager setDistanceFilter:10.0];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
}


- (void)initCompleteBlock
{
    __weak LFCarViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
            
            //存在虚拟定位的风险的定位结果
            __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
            //存在外接的辅助定位设备
            __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
            
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加 22.597551;lon:113.873812
            NSLog(@"111111111111111111111111lat:%f;lon:%f;111111111111111111111111111", location.coordinate.latitude, location.coordinate.longitude);
            weakSelf.startCoordinate = location.coordinate;
            weakSelf.destinationCoordinate = CLLocationCoordinate2DMake(22.598490, 113.875132);
            if (location) {
                [weakSelf searchRoutePlanningWalk];
            }
        }
        
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
//        if (regeocode)
//        {
//            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
//            [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
//        }
//        else
//        {
//            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
//            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
//        }
//
        LFCarViewController *strongSelf = weakSelf;
        [strongSelf addAnnotationToMapView:annotation];
    };
}


- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:17.0 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}


- (void)requestLocation {
    [self.mapView removeAnnotations:self.mapView.annotations];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    if ([AMapLocationManager headingAvailable] == YES)
    {
        [self.locationManager startUpdatingHeading];
    }
}


-(BOOL)amapLocationManagerShouldDisplayHeadingCalibration:(AMapLocationManager *)manager
{
   return _headingCalibration;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
   if (_annotationView != nil)
   {
       CGFloat angle = newHeading.trueHeading*M_PI/180.0f + M_PI - _annotationViewAngle;
       NSLog(@"################### heading : %f - %f", newHeading.trueHeading, newHeading.magneticHeading);
       _annotationViewAngle = newHeading.trueHeading*M_PI/180.0f + M_PI;
       _heading = newHeading;
       _annotationView.transform =  CGAffineTransformRotate(_annotationView.transform ,angle);
   }
}


- (void)startHeadingLocation
{
    //开始进行连续定位
    [self.locationManager startUpdatingLocation];
    
    if ([AMapLocationManager headingAvailable] == YES)
    {
        [self.locationManager startUpdatingHeading];
    }
}



#pragma mark - Initialization
- (void)setupSubviews {
    [self.view addSubview:self.segmentCtrl];
    [self.view addSubview:self.mapView];
}


- (UISegmentedControl *)segmentCtrl {
    if (!_segmentCtrl) {
        NSArray *itemArr = @[@"GPS找车", @"视频找车"];
        _segmentCtrl = [[UISegmentedControl alloc] initWithItems:itemArr];
        _segmentCtrl.frame = LRect(0, NAVBARHEIGHT, SCREEN_WIDTH - 100.f, 50.f);
        _segmentCtrl.centerX = SCREEN_WIDTH / 2;
        _segmentCtrl.selectedSegmentIndex = 0;
        [_segmentCtrl addTarget:self action:@selector(segmentedControlClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtrl;
}


- (MAMapView *)mapView {
    if (!_mapView) {
        self.mapView = [[MAMapView alloc] initWithFrame:LRect(0, _segmentCtrl.y + _segmentCtrl.height, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - _segmentCtrl.height)];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.mapView.delegate = self;
    }
    return _mapView;
}


- (void)initSearchAPI {
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}


/* 添加默认标注 */
- (void)addDefaultAnnotations
{
    /* 起始位置标注 */
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    self.startAnnotation = startAnnotation;
    /* 终点位置标注 */
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    self.destinationAnnotation = destinationAnnotation;
    /* 将标注添加到地图上 */
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
}


- (void)searchRoutePlanningWalk {
    _startAnnotation.coordinate = _startCoordinate;
    _destinationAnnotation.coordinate = _destinationCoordinate;
    AMapWalkingRouteSearchRequest *walkNavi = [[AMapWalkingRouteSearchRequest alloc] init];
    /* 出发点 */
    walkNavi.origin = [AMapGeoPoint locationWithLatitude:_startCoordinate.latitude longitude:_startCoordinate.longitude];
    /* 目的地 */
    walkNavi.destination = [AMapGeoPoint locationWithLatitude:_destinationCoordinate.latitude longitude:_destinationCoordinate.longitude];
    [self.search AMapWalkingRouteSearch:walkNavi];
}


/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
//    [self updateCourseUI];
//    [self updateDetailUI];
    
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
}


/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    MANaviAnnotationType type = MANaviAnnotationTypeWalking;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}


- (void)updateTotal
{
    self.totalCourse = self.route.paths.count;
}


- (void)segmentedControlClicked:(UISegmentedControl *)control {
    
}



- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDashType = kMALineDashTypeSquare;
        polylineRenderer.strokeColor = [UIColor redColor];

        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];

        polylineRenderer.lineWidth = 8;

        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }

        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];

        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];

        return polylineRenderer;
    }

    return nil;
}



#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

/*
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f, reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);

    //获取到定位信息，更新annotation
    if (self.currentAnnotation == nil)
    {
        self.currentAnnotation = [[MAPointAnnotation alloc] init];
        [self.currentAnnotation setCoordinate:location.coordinate];
        [self.mapView addAnnotation:self.currentAnnotation];
    }

    [self.currentAnnotation setCoordinate:location.coordinate];
//    [self.mapView setCenterCoordinate:location.coordinate];

}
*/

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = _annotationView;
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout   = NO;
            annotationView.animatesDrop     = NO;
            annotationView.draggable        = NO;
            annotationView.image            = [UIImage imageNamed:@"icon_location"];
            _annotationView = annotationView;
            _annotationViewAngle = 0;
        }
        
        return annotationView;
    }
    
    return nil;
}


/*
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";

        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }

        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;

        if ([annotation isKindOfClass:[MANaviAnnotation class]])
        {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeRailway:
                    poiAnnotationView.image = [UIImage imageNamed:@"railway_station"];
                    break;

                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                    break;

                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"car"];
                    break;

                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"man"];
                    break;

                default:
                    break;
            }
        }
        else
        {
//             // 起点.
//            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
//            {
//                poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
//            }
//           //  终点.
//            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
//            {
//                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
//            }
//
//        }
//
//        return poiAnnotationView;
    }

    return nil;
}

*/

#pragma mark - AMapSearchDelegate
//- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
//{
//    NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
//}



@end
