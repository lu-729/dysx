//
//  MainViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MainViewController.h"
#import "LNavigationBar.h"
#import "ScanViewController.h"
#import "FoundCarViewController.h"
#import "LFCarViewController.h"

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
    [self setupSubviews];
}


- (void)viewWillDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = NO;
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
    
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:LRect(0, 0, 44.f, 44.f)];
    if (scanBtn) {
        [scanBtn setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
        [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(4.f, 4.f, 4.f, 0)];
        [scanBtn addTarget:self action:@selector(scanBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
        if (rightItem) {
            self.navigationItem.rightBarButtonItem = rightItem;
        }
    }
    
}


- (void)messageBtnAction {
    
}


- (void)scanBtnAction {
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

    
- (void)setupSubviews {
    UIButton *foundCarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [foundCarBtn setTitle:@"找车" forState:UIControlStateNormal];
    foundCarBtn.frame = LRect(0, 200.f, 100.f, 40.f);
    foundCarBtn.x = (SCREEN_WIDTH - 100.f) / 2;
    foundCarBtn.backgroundColor = [UIColor systemGrayColor];
    [foundCarBtn addTarget:self action:@selector(foundCarBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foundCarBtn];
}


- (void)foundCarBtnClicked {
    FoundCarViewController *foundCarVC = [[FoundCarViewController alloc] init];
    LFCarViewController *LFCarVC = [[LFCarViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:foundCarVC animated:YES];
    [self.navigationController pushViewController:LFCarVC animated:YES];
}


@end
