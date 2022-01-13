//
//  CBTabBarController.m
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import "CBTabBarController.h"
#import "CBTabBar.h"

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
    
//    [self.tabBar removeFromSuperview];
    self.tabBar.hidden = YES;
    CGRect rect = self.tabBar.bounds;
    
    CBTabBar *tabBar = [[CBTabBar alloc] initWithFrame:self.tabBar.bounds];
    NSLog(@"--------tabbarHeiht = %f", self.tabBar.bounds.size.height);
    tabBar.delegate = self;
    tabBar.backgroundColor = MAIN_COLOR;
//    CGRect frame = tabBar.frame;
    tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - (49.f + 34.f), SCREEN_WIDTH, 49.f + 34.f);
    [self.view addSubview:tabBar];
}

- (void)tabBar:(CBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

@end
