//
//  EditProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/18.
//

#import "EditProfileViewController.h"
#import "NSString+Category.h"
#import "MBProgressHUD.h"

@interface EditProfileViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) UIView *nickNameView;

@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *phoneNumTF;
@property (nonatomic, copy) NSString *phoneNumStr;

@property (nonatomic, strong) UITextField *verifyCodeTF;
@property (nonatomic, strong) UIButton *getVerifyCodeBtn;
@property (nonatomic, strong) UILabel *timeCountLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation EditProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 通过上个控制器传入的flag值显示对应子视图
    if (_flag == 100) {
        [self setUpNickNameViews];
    } else {
        [self setUpPhoneNumViews];
    }
}

#pragma mark - NickNameChange

- (void)setUpNickNameViews {
    self.title = @"修改昵称";
    _nickNameView = [[UIView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
//    nickNameView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_nickNameView];
    _nickNameTF = [[UITextField alloc] initWithFrame:LRect(0, 80.f, 250.f, 30.f)];
    _nickNameTF.delegate = self;
    _nickNameTF.textAlignment = NSTextAlignmentCenter;
    _nickNameTF.centerX = _nickNameView.centerX;
    _nickNameTF.placeholder = @"输入昵称..";
    [_nickNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_nickNameView addSubview:_nickNameTF];
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [_nickNameView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickNameTF.mas_left);
        make.height.mas_equalTo(0.5f);
        make.width.equalTo(_nickNameTF.mas_width);
        make.top.equalTo(_nickNameTF.mas_bottom);
    }];
    UILabel *tipLabel = [[UILabel alloc] init];
//    tipLabel.backgroundColor = [UIColor greenColor];
    [_nickNameView addSubview:tipLabel];
    tipLabel.text = @"支持中文、英文、数字，最长12个字符";
    tipLabel.font = [UIFont systemFontOfSize:12.f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(separateLine.mas_left);
        make.top.equalTo(separateLine.mas_bottom);
        make.width.equalTo(separateLine.mas_width);
        make.height.mas_equalTo(30.f);
    }];
    
    UIButton *SaveButton = [[UIButton alloc] init];
    SaveButton.backgroundColor = [UIColor blueColor];
    SaveButton.layer.cornerRadius = 5.f;
    [SaveButton.layer setMasksToBounds:YES];
    [SaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [SaveButton addTarget:self action:@selector(nameSaveBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [SaveButton addTarget:self action:@selector(nameSaveBtnAction)];
    [_nickNameView addSubview:SaveButton];
    
    __weak typeof(self) weakSelf = self;
    [SaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.width.mas_equalTo(240.f);
        make.height.mas_equalTo(45.f);
    }];
}


#pragma mark - PhoneNumberChange

- (void)setUpPhoneNumViews {
    self.title = @"更换手机号";
    _phoneView = [[UIView alloc] init];
    UILabel *currentNumLabel = [[UILabel alloc] initWithFrame:LRect(40.f, HeightStatusBar + 100.f, 100.f, 20.f)];
    currentNumLabel.text = @"手机号";
    currentNumLabel.font = [UIFont systemFontOfSize:13.f];
    [self.view addSubview:currentNumLabel];
    _phoneNumTF = [[UITextField alloc] init];
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTF.delegate = self;
    _phoneNumTF.placeholder = @"输入新手机号..";
    [self.view addSubview:_phoneNumTF];
    __weak typeof(self) weakSelf = self;
    [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentNumLabel.mas_left);
        make.top.equalTo(currentNumLabel.mas_bottom).offset(5.f);
//        make.right.equalTo(weakSelf.view.mas_right).offset(40.f);
        make.width.mas_equalTo(SCREEN_WIDTH - 80.f);
        make.height.mas_equalTo(30.f);
    }];
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumTF.mas_left);
        make.height.mas_equalTo(0.5f);
        make.width.equalTo(_phoneNumTF.mas_width);
        make.top.equalTo(_phoneNumTF.mas_bottom);
    }];
    UILabel *verifyCodeLabel = [[UILabel alloc] init];
    verifyCodeLabel.text = @"验证码";
    verifyCodeLabel.font = [UIFont systemFontOfSize:13.f];
    [self.view addSubview:verifyCodeLabel];
    [verifyCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(separateLine.mas_left);
        make.top.equalTo(separateLine.mas_bottom).offset(10.f);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(20.f);
    }];
    _getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _getVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeBtnClicked)];
    [self.view addSubview:_getVerifyCodeBtn];
    [_getVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(separateLine.mas_right);
        make.top.equalTo(verifyCodeLabel.mas_bottom).offset(5.f);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
    }];
    _verifyCodeTF = [[UITextField alloc] init];
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTF.delegate = self;
    _verifyCodeTF.placeholder = @"输入验证码..";
    [self.view addSubview:_verifyCodeTF];
    [_verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verifyCodeLabel.mas_left);
        make.top.equalTo(verifyCodeLabel.mas_bottom).offset(5.f);
        make.right.equalTo(_getVerifyCodeBtn.mas_left);
        make.height.mas_equalTo(30.f);
    }];
    
    UIView *separateLineT = [[UIView alloc] init];
    separateLineT.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:separateLineT];
    [separateLineT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verifyCodeTF.mas_left);
        make.height.mas_equalTo(0.5f);
        make.width.equalTo(separateLine.mas_width);
        make.top.equalTo(_verifyCodeTF.mas_bottom);
    }];
    _timeCountLabel = [[UILabel alloc] init];
    _timeCountLabel.text = @"45秒后重新发送";
    _timeCountLabel.hidden = YES;
    _timeCountLabel.textAlignment = NSTextAlignmentCenter;
    _timeCountLabel.font = [UIFont systemFontOfSize:13.f];
    _timeCountLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_timeCountLabel];
    [_timeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(separateLine.mas_right);
        make.bottom.equalTo(separateLineT.mas_top).offset(-2.f);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
    }];
    UIButton *confirmModifyBtn = [[UIButton alloc] init];
    confirmModifyBtn.backgroundColor = [UIColor blueColor];
    [confirmModifyBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [confirmModifyBtn addTarget:self action:@selector(confirmModifyBtnClicked)];
    [self.view addSubview:confirmModifyBtn];
    [confirmModifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separateLineT.mas_bottom).offset(100.f);
        make.left.mas_equalTo((SCREEN_WIDTH - 120) / 2);
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(40.f);
    }];
    
}


- (void)confirmModifyBtnClicked {
    
}


- (void)getVerifyCodeBtnClicked {
    NSLog(@"获取短信验证码");
    _phoneNumStr = _phoneNumTF.text;
    if ([_phoneNumStr isPhoneNum]) {
        [_phoneNumTF resignFirstResponder];
        _timeCountLabel.hidden = NO;
        _getVerifyCodeBtn.hidden = YES;
        [self tipHud:@"短信已发送"];
        [self openCountdown];
    } else {
        [self tipHud:@"请输入有效号码"];
    }
}


- (void)tipHud:(NSString *)str {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text = str;
    UIView *view = [[UIView alloc] initWithFrame:LRect(0, 0, 50, 45)];
    [hud setCustomView:view];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    hud.minShowTime = 0.8f;
    [hud hideAnimated:YES];
}
    

-(void)openCountdown{

     

        __block NSInteger time = 44;
    __weak typeof(self) weakSelf = self;
     

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

     

        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

     

        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);

        dispatch_source_set_event_handler(_timer, ^{

             if(time <= 0){

             dispatch_source_cancel(_timer);

             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 weakSelf.timeCountLabel.hidden = YES;
                 weakSelf.getVerifyCodeBtn.hidden = NO;
//                    [self.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
//
//                    [self.authCodeBtn setTitleColor:[UIColor colorFromHexCode:@"FB8557"]
//
//                    forState:UIControlStateNormal];
//
//                     self.authCodeBtn.userInteractionEnabled = YES;

                });

            }else{

             int seconds = time % 45;

             dispatch_async(dispatch_get_main_queue(), ^{

//                    [self.authCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
//
//
//                    [self.authCodeBtn setTitleColor:[UIColor colorFromHexCode:@"979797"]
//
//    forState:UIControlStateNormal];
//
//            self.authCodeBtn.userInteractionEnabled = NO;
                 weakSelf.timeCountLabel.text = [NSString stringWithFormat:@"%.2ds 重新发送", seconds];

                });

                time--;
            }

        });

        dispatch_resume(_timer);

    }


- (void)nameSaveBtnAction {
    
    if (![_nickNameTF.text isEqualToString:@""]) {
        [_nickNameTF resignFirstResponder];
        [self sendNotification];
        NSString *nickName = _nickNameTF.text;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:nickName forKey:@"nickName"];
        [userDefaults synchronize];
        NSLog(@"点击保存_textField。text = %@", _nickNameTF.text);
    } else {
        NSLog(@"text内容为空");
    }
}

- (void)tipHud {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text = @"";
    UIView *view = [[UIView alloc] initWithFrame:LRect(0, 0, 50, 50)];
    [hud setCustomView:view];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    hud.minShowTime = 1.f;
    [hud hideAnimated:YES];
}


// 昵称上传后端成功后发送通知,通知其他页面更改昵称
- (void)sendNotification {
    NSDictionary *dict = @{@"nickName":_nickNameTF.text};
    NSString *nameChangenotification = @"nameChangeNotification";
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:nameChangenotification object:self userInfo:dict];
    [self.navigationController popViewControllerAnimated:YES];
}



/*****************   监听文本框输入，限制输入文本长度  *********************/
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.nickNameTF) {
        NSInteger maxLength = 12;
        NSString *toBeString = textField.text;
        NSString *lang = [UIApplication sharedApplication].textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            //如果使用的中文输入法
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (toBeString.length > maxLength) {
                    textField.text = [toBeString substringToIndex:maxLength];
                }
            } else {
                
            }
        } else {
            if (toBeString.length > maxLength) {
                textField.text = [toBeString substringToIndex:maxLength];
            }
        }
    } else if (textField == _phoneNumTF) {
        
    } else {
        
    }
    
}




/// 对中文、字母、数字进行正则判断（不包括空格）
/// @param str 传入要判断的字符串
- (BOOL)isInuputRuleNoBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


/// 对中文、字母、数字进行正则判断（包括空格）
/// @param str 要判断的字符串
- (BOOL)isInputRuleWithBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"self.view点击事件");
    [self.view endEditing:YES];
}


#pragma mark -  UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    _nickName = textField.text;
    NSLog(@"textField.text = %@", textField.text);
    return YES;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([self isInuputRuleNoBlank:string] || [string isEqualToString:@""]) {
//        return YES;
//    } else {
//        return NO;
//    }
    
    if (string.length == 0) {
        return YES;
    }
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 11) {
        return NO;
    }
    return YES;
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
