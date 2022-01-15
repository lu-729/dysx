//
//  LTabBarController.m
//  dysx
//
//  Created by chengbo on 2022/1/14.
//

#import "LTabBarController.h"
#import "MainViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"
#import "LTabBar.h"

@interface LTabBarController ()

@property(nonatomic,strong)NSMutableArray *btnArr;

@end

@implementation LTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *mainVC = [[MainViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setChildVC:mainVC title:@"主页" imageName:@"TabBar1" selectedImageName:@"TabBar1Sel"];
    [self setChildVC:mineVC title:@"我的" imageName:@"TabBar3" selectedImageName:@"TabBar3Sel"];
    
    LTabbar *customTabBar = [[LTabbar alloc] init];
//    [self setValue:customTabBar forKey:@"tabBar"];
}


- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title imageName:(NSString *) image selectedImageName:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    childVC.navigationItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [self addChildViewController:childVC];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (NSMutableArray *)btnArr {
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}




@end
