//
//  BaseNavigationController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.backgroundColor = [UIColor greenColor];
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    [self setNavigationBarHidden:NO animated:YES];
}

@end
