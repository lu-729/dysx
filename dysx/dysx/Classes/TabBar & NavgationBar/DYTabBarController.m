//
//  DYTabBarController.m
//  Test_LV
//
//  Created by chengbo on 2022/3/10.
//

#import "DYTabBarController.h"
#import "DYTabBar.h"
#import "MainViewController.h"
#import "MineViewController.h"
#import "ScanViewController.h"

@interface DYTabBarController () <DYTabBarDelegate>

@property (nonatomic, strong) NSArray *vcTitleArray;
@property (nonatomic, strong) NSArray *vcItemArray;

@end

@implementation DYTabBarController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self addAllChildViewController];
    
    DYTabBar *tabBar = [[DYTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    // 设置tabBar的代理
    tabBar.myDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - Private Methods
// 初始化所有的子控制器
- (void)addAllChildViewController {
    MainViewController *mainVC = [[MainViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
//    [self setTabBarChildVC:mainVC title:self.vcTitleArray[0] imageName:self.vcItemArray[0] selectedImageName:nil];
//    [self setTabBarChildVC:mineVC title:self.vcTitleArray[1] imageName:self.vcItemArray[1] selectedImageName:nil];
    
    
    
    [self setChildVC:mainVC title:@"主页" imageName:@"TabBar1" selectedImageName:@"TabBar1Sel"];
    [self setChildVC:mineVC title:@"我的" imageName:@"TabBar3" selectedImageName:@"TabBar3Sel"];

    
//    for (NSInteger i = 0; i < self.vcTitleArray.count; i++) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.title = self.vcTitleArray[i];
//        vc.tabBarItem.image = [[UIImage imageNamed:self.vcItemArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Sel", self.vcItemArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor systemBlueColor]} forState:UIControlStateSelected];
//
//
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        nav.tabBarItem.title = self.vcTitleArray[i];
//        nav.navigationBar.translucent = NO;
//        nav.navigationBar.shadowImage = [[UIImage alloc] init];
//        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        [nav.navigationBar setTintColor:[UIColor whiteColor]];
//        [nav.navigationBar setBarTintColor:[UIColor systemBlueColor]];
//        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//        [self addChildViewController:nav];
//    }
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


#pragma DBHTabBarDelegate
/**
 *  点击了加号按钮
 */
- (void)tabBarDidClickPlusButton:(DYTabBar *)tabBar {
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    
    [self presentViewController:scanVC animated:YES completion:nil];
}

#pragma mark - Getters And Setters
- (NSArray *)vcTitleArray {
    if (!_vcTitleArray) {
        _vcTitleArray = @[@"首页", @"个人"];
    }
    return _vcTitleArray;
}
- (NSArray *)vcItemArray {
    if (!_vcItemArray) {
        _vcItemArray = @[@"TabBar1", @"TabBar3"];
    }
    return _vcItemArray;
}



@end
