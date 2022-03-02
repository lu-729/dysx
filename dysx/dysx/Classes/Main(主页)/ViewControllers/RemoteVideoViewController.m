//
//  RemoteVideoViewController.m
//  dysx
//
//  Created by chengbo on 2022/3/1.
//

#import "RemoteVideoViewController.h"

@interface RemoteVideoViewController ()

@end

@implementation RemoteVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"远程视频";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

- (void)setupSubViews {
    UIView *videoBgView = [[UIView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, 250.f)];
    videoBgView.backgroundColor = [UIColor blackColor];
    videoBgView.center = LPoint(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0 - 60.f);
    [self.view addSubview:videoBgView];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    testBtn.frame = LRect(0, 0, 100.f, 40.f);
    testBtn.backgroundColor = [UIColor systemGrayColor];
    testBtn.center = LPoint(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - 250.f);
    [testBtn setTitle:@"调试" forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(testBtnAction)];
    [self.view addSubview:testBtn];
}

- (void)testBtnAction {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text = @"网络未通";
    UIView *view = [[UIView alloc] initWithFrame:LRect(0, 0, 50, 50)];
    [hud setCustomView:view];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    hud.minShowTime = 0.75f;
    [hud hideAnimated:YES];
}



@end
