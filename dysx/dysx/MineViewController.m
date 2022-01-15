//
//  MineViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MineViewController.h"

@interface MineViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAIN_COLOR;
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
    [self setupSubViews];
}


- (void)setupSubViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 100.f);
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132.f)];
    topView.backgroundColor = MAIN_COLOR;
    [_scrollView addSubview:topView];
    UIImageView *usrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 100.f, 50.f, 50.f)];
    UIView *usrNickName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100.f, 50.f)];
//    usrNickName.backgroundColor = MAIN_COLOR;
    [_scrollView addSubview:usrNickName];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
