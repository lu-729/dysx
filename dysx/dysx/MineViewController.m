//
//  MineViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MineViewController.h"
#import "CustomTools.h"

#define lStatusBarHeiht [CustomTools getStatusBarHeight]

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

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
    usrInfoSuperView.backgroundColor = [UIColor greenColor];
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
    usrLabel.font = [UIFont systemFontOfSize:24.f];
    [usrInfoSuperView addSubview:usrLabel];
    [usrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usrImgView.mas_right).offset(15);
        make.centerY.equalTo(usrImgView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    UITableView *mineTableView = [[UITableView alloc] initWithFrame:LRect(0, 200, SCREEN_WIDTH, 500)];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    mineTableView.backgroundColor = [UIColor purpleColor];
//    [mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(topView.mas_bottom);
//        make.bottom.equalTo(self.tabBarController.tabBar.mas_top);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.left.equalTo(topView.mas_left);
//    }];
    [self.view addSubview:mineTableView];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseCellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseCellId];
    }
    return nil;
}

#pragma mark - UITableViewDelegate Methods



//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
