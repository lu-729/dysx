//
//  ProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"编辑资料";
    [self setUpSubViews];
}

- (void)setUpSubViews {
    UITableView *tableView = nil;
    if (@available(iOS 13.0, *)) {
        tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStyleInsetGrouped];
    } else {
        tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStyleGrouped];
    }
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
    UIView *ImgSuperView = [[UIView alloc] init];
    ImgSuperView.frame = LRect(0, 0, SCREEN_WIDTH, 135.f);
    ImgSuperView.backgroundColor = [UIColor redColor];
    tableView.tableHeaderView = ImgSuperView;
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
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusrCellID = @"ProfileViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusrCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusrCellID];
    }
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 135.f;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
