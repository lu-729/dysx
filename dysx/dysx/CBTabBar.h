//
//  CBTabBar.h
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CBTabBar;

@protocol CBTabBarDelegate <NSObject>

- (void)tabBar:(CBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface CBTabBar : UIView

@property (nonatomic, weak) id<CBTabBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
