//
//  CBTabBarController.m
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import "CBTabBarController.h"
#import "CBTabBarButton.h"
#import "CBTabBar.h"

@interface CBTabBarController () <CBTabBarDelegate>

//选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation CBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tabBar removeFromSuperview];
    CGRect rect = self.tabBar.bounds;
    
    CBTabBar *tabBar = [[CBTabBar alloc] init];
    tabBar.delegate = self;
    tabBar.frame = rect;
    [self.tabBar addSubview:tabBar];
    //添加按钮
    for (int i=0; i<self.viewControllers.count; i++) {
        
    }
}



@end
