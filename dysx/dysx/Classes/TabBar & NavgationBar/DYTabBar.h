//
//  DYTabBar.h
//  Test_LV
//
//  Created by chengbo on 2022/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DYTabBar;
@protocol DYTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(DYTabBar *)tabBar;

@end


@interface DYTabBar : UITabBar

@property (nonatomic, weak) id<DYTabBarDelegate> myDelegate;

@end

NS_ASSUME_NONNULL_END
