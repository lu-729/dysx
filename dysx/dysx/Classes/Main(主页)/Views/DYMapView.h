//
//  DYMapView.h
//  dysx
//
//  Created by chengbo on 2022/3/8.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DYMapViewDelegate <NSObject>

- (void)currentLocation;
- (void)carLocation;
- (void)zoomInMapView;
- (void)zoomOutMapView;


@end

@interface DYMapView : MAMapView

@property (nonatomic, weak) id<DYMapViewDelegate> dyDelegate;



@end

NS_ASSUME_NONNULL_END
