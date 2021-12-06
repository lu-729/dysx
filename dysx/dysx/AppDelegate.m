//
//  AppDelegate.m
//  dysx
//
//  Created by wangyu on 2021/12/6.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口、显示窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor redColor];
    [_window makeKeyAndVisible];

    //设置窗口根视图控制器为TabBarController
    MainViewController *mainVC = [[MainViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
//    mainVC.view.backgroundColor = [UIColor greenColor];
//    mineVC.view.backgroundColor = [UIColor yellowColor];
    UINavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    UINavigationController *mineNav = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = @[mainNav, mineNav];
    _window.rootViewController = tabBarVC;
    
//    //初始化ALi SDK
//    IMSIotSmartConfig *config = [IMSIotSmartConfig new];
//    config.regionType = REGION_ALL;
//    [IMSIotSmart sharedInstance].config = config;
//    //设置安全图片,如果不设置，默认使用
//    [[IMSIotSmart sharedInstance] setAuthCode:@"china_production"];
//    [[IMSIotSmart sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
//    [[IMSIotSmart sharedInstance] configProductScope:PRODUCT_SCOPE_PUBLISHED];

    
    return YES;
}


@end
