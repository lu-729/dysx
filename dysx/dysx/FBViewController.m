//
//  FBViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "FBViewController.h"

@interface FBViewController ()

@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"用户反馈";
    [self setUpSubViews];
}

- (void)setUpSubViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
    scrollView.backgroundColor = LColor(242.f, 242.f, 247.f);
    [self.view addSubview:scrollView];
    UITextField *usrInputTF = [[UITextField alloc] initWithFrame:LRect(10.f, 20.f, SCREEN_WIDTH - 20.f, 130.f)];
    usrInputTF.backgroundColor = [UIColor redColor];
    [scrollView addSubview:usrInputTF];
}


@end
