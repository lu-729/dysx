//
//  ProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "LPhotoTools.h"
#import <Photos/Photos.h>

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *detailDataArr;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *usrImgV;

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
    _detailDataArr = [NSMutableArray arrayWithObjects:@"骄阳似火", @"139****0541", nil];
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

- (UIImageView *)usrImgV {
    if (!_usrImgV) {
        _usrImgV = [[UIImageView alloc] init];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults dataForKey:@"userImage"];
        UIImage *usrImg = [UIImage imageWithData:data];
        if (usrImg) {
            _usrImgV.image = usrImg;
        } else {
            _usrImgV.image = [UIImage imageNamed:@"weixin_log"];
        }
        
        _usrImgV.frame = LRect(0, 0, 70.f, 70.f);
    //    usrImgView.backgroundColor = [UIColor greenColor];
        _usrImgV.layer.masksToBounds = YES;
        _usrImgV.layer.cornerRadius = _usrImgV.width /2;
        _usrImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
        [_usrImgV addGestureRecognizer:tapGR];
        [_usrImgV addGestureRecognizer:tapGR];
        [_usrImgV.layer setMasksToBounds:YES];
    }
    return _usrImgV;
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
    ImgSuperView.backgroundColor = MAIN_COLOR;
    _tableView.tableHeaderView = ImgSuperView;
    [ImgSuperView addSubview:self.usrImgV];
    _usrImgV.center = LPoint(ImgSuperView.width / 2, ImgSuperView.height / 2);
}


- (void)tapGRAction:(UITapGestureRecognizer *)gesture {
    NSLog(@"点击了头像");
    [self initImagePicker];
    [self requestAuthorizationPhotoLibrary];
    
}


- (void)initImagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
}


- (void)requestAuthorizationPhotoLibrary {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
               //操作图片
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self chooseImage];
                });
            } else {
                   //注，这里一定要回归的主线程操作UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"相册权限未设置,请开启相册权限" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:cancelAction];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            }
    }];
}


-(void)chooseImage {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            }
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        
        [actionSheet addAction:cameraAction];
        [actionSheet addAction:photoAction];
        [actionSheet addAction:cancelAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        self.usrImgV.image = image;
    NSDictionary *dict = @{@"usrImg":image};
    if (image) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileViewControllerUsrImgChanged" object:nil userInfo:dict];
        NSData *data;
        if (UIImagePNGRepresentation(image)) {
            data = UIImagePNGRepresentation(image);
        } else {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:data forKey:@"userImage"];
        [userDefaults synchronize];
    }
    
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
    self.hidesBottomBarWhenPushed = YES;
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






@end
