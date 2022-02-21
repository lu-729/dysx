//
//  CBTabBarController.m
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import "CBTabBarController.h"
#import "CBTabBar.h"
#import "MainViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"

@interface CBTabBarController () <CBTabBarDelegate>

//选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *tabBarView;

@end

@implementation CBTabBarController


- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //将'主页'和'我的'两个视图控制器对应的导航控制器添加到tabbar控制器中
    MainViewController *mainVC = [[MainViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    UINavigationController *mineNav = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    self.viewControllers = @[mainNav, mineNav];
    
    self.tabBar.hidden = YES;
    CGRect rect = self.tabBar.bounds;
    
    CBTabBar *tabBar = [[CBTabBar alloc] initWithFrame:self.tabBar.bounds];
    NSLog(@"--------tabbarHeiht = %f", self.tabBar.bounds.size.height);
    tabBar.delegate = self;
    tabBar.backgroundColor = [UIColor whiteColor];
//    CGRect frame = tabBar.frame;
    tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - (49.f + 34.f), SCREEN_WIDTH, 49.f + 34.f);
    [self.view addSubview:tabBar];
}



- (void)tabBar:(CBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;

}

@end
