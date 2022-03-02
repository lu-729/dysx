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
#import "DeviceTableViewCell.h"
#import "RemoteVideoViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
    
@property (nonatomic, strong) UITableView *deviceTableView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout	= UIRectEdgeNone;
//    [self.navigationController setNavigationBarHidden:YES];
//    self.l_navgationBar = [LNavigationBar navWithTitle:@"首页"];
    [self createNavBarLeftButtonItem];
    [self setupSubviews];
//    [self initTableView];
}


- (void)viewWillDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = NO;
}


- (void)initTableView {
    if (!_deviceTableView) {
        _deviceTableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStyleInsetGrouped];
        _deviceTableView.delegate = self;
        _deviceTableView.dataSource = self;
        [self.view addSubview:_deviceTableView];
    }
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
    UIView *bgView = [[UIView alloc] initWithFrame:LRect(10.f, NAVBARHEIGHT + 20.f, SCREEN_WIDTH - 20.f, 180.f)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.cornerRadius = 5.f;
    [self.view addSubview:bgView];
    UIImageView *deviceImg = [[UIImageView alloc] initWithFrame:LRect(5.f, 5.f, bgView.width - 10.f, 125.f)];
    deviceImg.backgroundColor = [UIColor darkGrayColor];
    [bgView addSubview:deviceImg];
    CGFloat btnWidth = (bgView.width - 20.f) / 3;
    CGFloat btnHeight = 40.f;
    CGFloat btnY = 135.f;
    CGFloat btnX;
    NSArray *titleArr = @[@"远程视频", @"本地连接", @"找车"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor systemGrayColor]];
        button.frame = LRect(5 + (btnWidth + 5) * i, btnY, btnWidth, btnHeight);
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
    
}


- (void)buttonAction:(UIButton *)button {
    self.hidesBottomBarWhenPushed = YES;
    if (button.tag == 0) {
        RemoteVideoViewController *rVideoVC = [[RemoteVideoViewController alloc] init];
        [self.navigationController pushViewController:rVideoVC animated:YES];
    } else if (button.tag == 1) {
        
    } else if (button.tag == 2) {
        FoundCarViewController *foundCarVC = [[FoundCarViewController alloc] init];
        LFCarViewController *lFCarVC = [[LFCarViewController alloc] init];
    //    [self.navigationController pushViewController:foundCarVC animated:YES];
        [self.navigationController pushViewController:lFCarVC animated:YES];
    }
}


#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseCellId = @"DeviceTableViewCell";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (!cell) {
        cell = [[DeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId];
    }
    return cell;
}



@end
