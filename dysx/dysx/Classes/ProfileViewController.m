//
//  ProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *detailDataArr;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"编辑资料";
    _dataArr = @[@"昵称", @"手机号"];
//    _detailDataArr = @[@"骄阳似火", @"13971500541"];
    _detailDataArr = [NSMutableArray arrayWithObjects:@"骄阳似火", @"13971500541", nil];
    [self setUpSubViews];
    
    [self receiveNotificaiotn];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self receiveNotificaiotn];
}

- (void)receiveNotificaiotn {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(notificationAction:) name:@"nameChangeNotification" object:nil];
}

- (void)notificationAction:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"nameChangeNotification"]) {
        NSLog(@"收到昵称修改通知, notification = %@", notification);
        NSDictionary *dict = notification.userInfo;
        _detailDataArr[0] = [dict objectForKey:@"nickName"];
        [_tableView reloadData];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setUpSubViews {
    if (@available(iOS 13.0, *)) {
        _tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStyleInsetGrouped];
    } else {
        _tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIView *ImgSuperView = [[UIView alloc] init];
    ImgSuperView.frame = LRect(0, 0, SCREEN_WIDTH, 135.f);
    ImgSuperView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = ImgSuperView;
    //
    UIImageView *usrImgView = [[UIImageView alloc] init];
    usrImgView.size = LSize(60.f, 60.f);
    usrImgView.backgroundColor = [UIColor greenColor];
    usrImgView.center = LPoint(ImgSuperView.width / 2, ImgSuperView.height / 2);
    usrImgView.layer.cornerRadius = usrImgView.width /2;
    [usrImgView.layer setMasksToBounds:YES];
    [ImgSuperView addSubview:usrImgView];
    
    /*
    UIView *ImgSuperView = [[UIView alloc] init];
    ImgSuperView.frame = LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, 135.f);
    ImgSuperView.backgroundColor = [UIColor redColor];
    [self.view addSubview:ImgSuperView];
    //
    UIImageView *usrImgView = [[UIImageView alloc] init];
    usrImgView.size = LSize(60.f, 60.f);
    usrImgView.backgroundColor = [UIColor greenColor];
    usrImgView.center = LPoint(ImgSuperView.width / 2, ImgSuperView.height / 2);
    usrImgView.layer.cornerRadius = usrImgView.width /2;
    [usrImgView.layer setMasksToBounds:YES];
    [ImgSuperView addSubview:usrImgView];
     */
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] init];
    editVC.flag = indexPath.row + 100;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusrCellID = @"ProfileViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusrCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusrCellID];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.detailTextLabel.text = _detailDataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 135.f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
