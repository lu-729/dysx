//
//  BaseNavigationController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [backButton sizeToFit];
//        // 这句代码放在sizeToFit后面
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//        self.navigationItem.backBarButtonItem = item;
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}


- (void)backBtnClicked {
    [self popViewControllerAnimated:YES];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}


@end
