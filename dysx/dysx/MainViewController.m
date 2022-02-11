//
//  MainViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MainViewController.h"
#import "LNavigationBar.h"

@interface MainViewController () {
    
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout	= UIRectEdgeNone;
//    [self.navigationController setNavigationBarHidden:YES];
//    self.l_navgationBar = [LNavigationBar navWithTitle:@"首页"];
    [self createNavBarLeftButtonItem];
}


- (void)createNavBarLeftButtonItem {
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (messageBtn) {
        messageBtn.frame = LRect(0, 0, SCREEN_WIDTH / 5.0, 44.f);
        [messageBtn setTitle:@"消息" forState:UIControlStateNormal];
//        [messageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        messageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        messageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [messageBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30.f, 0, 0)];
        [messageBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
        if (leftItem) {
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

- (void)messageBtnAction {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
