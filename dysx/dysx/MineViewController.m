//
//  MineViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MineViewController.h"
#import "CustomTools.h"

#define lStatusBarHeiht [CustomTools getStatusBarHeight]

@interface MineViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = MAIN_COLOR;
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBarHidden = YES;
    [self setupSubViews];
    
}


- (void)setupSubViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132.f)];
    topView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:topView];
    UIView *usrInfoSuperView = [[UIView alloc] initWithFrame:LRect(0, lStatusBarHeiht, topView.width, topView.height - lStatusBarHeiht)];
    usrInfoSuperView.backgroundColor = [UIColor yellowColor];
    [topView addSubview:usrInfoSuperView];
    //创建用户头像视图
    UIImageView *usrImgView = [[UIImageView alloc] init];
    usrImgView.frame = LRect(10.f, 0, 60.f, 60.f);
    usrImgView.centerY = usrInfoSuperView.height / 2;
    usrImgView.backgroundColor = [UIColor redColor];
    usrImgView.layer.cornerRadius = usrImgView.width /2;
    [usrImgView.layer setMasksToBounds:YES];
    [usrInfoSuperView addSubview:usrImgView];
    //创建用户账号手机号标签
    UILabel *usrLabel = [[UILabel alloc] init];
    usrLabel.backgroundColor = [UIColor blueColor];
    usrLabel.text= @"13971500541";
    usrLabel.font = [UIFont systemFontOfSize:20.f];
    [usrInfoSuperView addSubview:usrLabel];
    [usrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usrImgView.mas_right).offset(15);
        make.centerY.equalTo(usrImgView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    /*
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.y = lStatusBarHeiht;
    NSLog(@"lStatusBarHeiht = %f", lStatusBarHeiht);
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
     
     */
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
