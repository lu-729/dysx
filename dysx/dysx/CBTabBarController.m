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
    tabBar.backgroundColor = MAIN_COLOR;
    [self.tabBar addSubview:tabBar];
    //添加按钮
    for (int i=0; i<self.viewControllers.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *selectedImageName =  [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        [tabBar addButtonWithImage:image selectedImage:selectedImage];
    }
}

- (void)tabBar:(CBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

@end
