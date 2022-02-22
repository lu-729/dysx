//
//  FoundCarViewController.m
//  dysx
//
//  Created by chengbo on 2022/2/22.
//

#import "FoundCarViewController.h"
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>

@interface FoundCarViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic) MKCoordinateRegion region;

@end

@implementation FoundCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 申请用户授权定位功能
    [self.locManager requestWhenInUseAuthorization];
    [self setupSubviews];
}


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


- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:LRect(0, _segmentCtrl.y + _segmentCtrl.height, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - _segmentCtrl.height)];
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
    }
    return _mapView;
}


- (CLLocationManager *)locManager {
    if (!_locManager) {
        _locManager = [[CLLocationManager alloc] init];
        _locManager.activityType = CLActivityTypeFitness;
        _locManager.delegate = self;
    }
    return _locManager;
}


- (void)segmentedControlClicked:(UISegmentedControl *)segmentedControl {
    NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
    if (selectedIndex == 0) {
        
    }
}


#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //获取当前位置
    CLLocation *currrentLocation = locations.lastObject;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currrentLocation.coordinate;
    point.title = @"当前位置";
    //地址解析
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currrentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = placemarks.lastObject;
        point.subtitle = place.name;
    }];
    //添加大头针
    [_mapView addAnnotation:point];
    //将地图的显示区域变小
    MKCoordinateRegion regin = MKCoordinateRegionMakeWithDistance(currrentLocation.coordinate, 800.f, 800.f);
    [_mapView setRegion:regin animated:YES];
}


#pragma mark - MKMapViewDelegate Methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }
    pin.pinTintColor = [MKPinAnnotationView purplePinColor];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    return pin;
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.span = mapView.region.span;
    region.center = centerCoordinate;
    _region = region;
}



@end
