//
//  PhotoViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"本地相册";
    [self setUpSubViews];
}

- (void)setUpSubViews {
    UIView *topBtnView = [[UIView alloc] init];
    topBtnView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topBtnView];
    __weak typeof(self) weakSelf = self;
    [topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50.f);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(NAVBARHEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH - 100.f);
    }];
    NSArray *btnTitleArr = @[@"视频",@"图片"];
    CGFloat btnWidth = (SCREEN_WIDTH - 100) / 2;
    NSLog(@"topBtnView.width = %f", topBtnView.width);
    CGFloat btnHeight = 50.f;
    CGFloat btnY = 0;
    CGFloat btnX;
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i + 100;
        btnX = i * btnWidth;
        button.frame = LRect(btnX, btnY, btnWidth, btnHeight);
        [button setTitleFont:15.f];
        [button setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:LColor(59, 135, 251) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:)];
        [topBtnView addSubview:button];
        if (i == 0) {
            _selectedBtn = button;
            _selectedBtn.selected = YES;
        }
    }
    
    UIScrollView *photoScrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f)];
    photoScrollView.contentSize = LSize(2 * SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:photoScrollView];
    
    NSLog(@"");
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f)];
    
    
}

- (void)buttonClicked:(UIButton *)button {
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    NSLog(@"button.tag = %ld", (long)button.tag);
    if (button.tag == 100) {
        NSLog(@"点击了视频按钮");
    } else {
        NSLog(@"点击了相册按钮");
    }
}




@end
