//
//  MineViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MineViewController.h"
#import "CustomTools.h"
#import "mineTableViewCell.h"
#import "ServiceViewController.h"
#import "PhotoViewController.h"
#import "ProfileViewController.h"
#import "HelpViewController.h"
#import "QAViewController.h"
#import "FBViewController.h"
#import "SetViewController.h"
#import "LPhotoTools.h"

#define lStatusBarHeiht [CustomTools getStatusBarHeight]

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UILabel *nickNameLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = MAIN_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    _dataArr = @[@[@"增值服务"], @[@"本地相册", @"编辑资料", @"紧急求助", @"常见问题", @"用户反馈"], @[@"设置"]];
    
    [self setupSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameChange:) name:@"nameChangeNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)nickNameChange:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"nameChangeNotification"]) {
        NSDictionary *dict = notification.userInfo;
        _nickNameLabel.text = dict[@"nickName"];
    }
}


- (void)setupSubViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132.f)];
    topView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:topView];
    UIView *usrInfoSuperView = [[UIView alloc] initWithFrame:LRect(0, lStatusBarHeiht, topView.width, topView.height - lStatusBarHeiht)];
//    usrInfoSuperView.backgroundColor = [UIColor greenColor];
    [topView addSubview:usrInfoSuperView];
    //创建用户头像视图
    UIImageView *usrImgView = [[UIImageView alloc] init];
    usrImgView.frame = LRect(20.f, 0, 60.f, 60.f);
    usrImgView.centerY = usrInfoSuperView.height / 2;
    usrImgView.backgroundColor = [UIColor redColor];
    usrImgView.layer.cornerRadius = usrImgView.width /2;
    [usrImgView.layer setMasksToBounds:YES];
    [usrInfoSuperView addSubview:usrImgView];
    //创建用户账号手机号标签
    UILabel *usrLabel = [[UILabel alloc] init];
//    usrLabel.backgroundColor = [UIColor blueColor];
    usrLabel.text= @"骄阳似火";
//    usrLabel.font = [UIFont systemFontOfSize:22.f];
    usrLabel.font = [UIFont boldSystemFontOfSize:22.f];
    usrLabel.textColor = [UIColor whiteColor];
    [usrInfoSuperView addSubview:usrLabel];
    _nickNameLabel = usrLabel;
    [usrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usrImgView.mas_right).offset(15);
        make.centerY.equalTo(usrImgView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    UITableView *mineTableView = [[UITableView alloc] initWithFrame:LRect(0, topView.height, SCREEN_WIDTH, SCREEN_HEIGHT - topView.height - self.tabBarController.tabBar.height) style:UITableViewStyleInsetGrouped];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    mineTableView.showsVerticalScrollIndicator = NO;
//    mineTableView.scrollEnabled = NO;
//    mineTableView.separatorInset = UIEdgeInsetsMake(0, 50.f, 0, 0);
//    mineTableView.backgroundColor = [UIColor purpleColor];
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
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 5;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseCellId = @"UITableViewCell";
    mineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (!cell) {
        cell = [[mineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _dataArr[0][indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = _dataArr[1][indexPath.row];
    } else {
        cell.textLabel.text = _dataArr[2][indexPath.row];
    }
    cell.imageView.image = [UIImage imageNamed:@"TabBar1"];
//    cell.imageView.x = cell.imageView.x - 10.f;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    CGFloat left = cell.textLabel.origin.x;
    
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            BOOL isCanVisitPhoto = [LPhotoTools isCanVisitPhotoLibrary];
//            if (isCanVisitPhoto) {
//
//            }
//        }
        UIViewController *vc = nil;
        switch (indexPath.row) {
            case 0:vc = [[PhotoViewController alloc] init];break;
            case 1:vc = [[ProfileViewController alloc] init];break;
            case 2:vc = [[HelpViewController alloc] init];break;
            case 3:vc = [[QAViewController alloc] init];break;
            case 4:vc = [[FBViewController alloc] init];break;
            default:break;
        }
        if (indexPath.row == 0) {
            if ([LPhotoTools isCanVisitPhotoLibrary] == YES) {
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
            }
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
       
        self.tabBarController.tabBar.hidden = YES;
//        self.hidesBottomBarWhenPushed = YES;
    } else {
        
    }
}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10.f;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
