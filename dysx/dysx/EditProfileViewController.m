//
//  EditProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/18.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) UIView *nickNameView;

@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *phoneNumTF;

@property (nonatomic, strong) UITextField *verifyCodeTF;

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
    [SaveButton addTarget:self action:@selector(btnClick)];
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
    self.title = @"验证手机号";
    _phoneView = [[UIView alloc] init];
    UILabel *currentNumLabel = [[UILabel alloc] initWithFrame:LRect(40.f, HeightStatusBar + 100.f, 100.f, 20.f)];
    currentNumLabel.text = @"当前手机号";
    currentNumLabel.font = [UIFont systemFontOfSize:13.f];
    [self.view addSubview:currentNumLabel];
    _phoneNumTF = [[UITextField alloc] init];
    _phoneNumTF.delegate = self;
    _phoneNumTF.placeholder = @"输入当前绑定手机号..";
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
    _verifyCodeTF = [[UITextField alloc] init];
    _verifyCodeTF.delegate = self;
    _verifyCodeTF.placeholder = @"输入验证码..";
    [self.view addSubview:_verifyCodeTF];
    [_verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verifyCodeLabel.mas_left);
        make.top.equalTo(verifyCodeLabel.mas_bottom).offset(5.f);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(30.f);
    }];
    UIButton *getVerifyCodeBtn = [[UIButton alloc] init];
    [getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeBtnClicked)];
    [self.view addSubview:getVerifyCodeBtn];
    [getVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
    }];
    UILabel *verifyCodeCountLabel = [[UILabel alloc] init];
    
}


- (void)getVerifyCodeBtnClicked {
    
}


- (void)btnClick {
    
    if (![_nickNameTF.text isEqualToString:@""]) {
        [_nickNameTF resignFirstResponder];
        [self sendNotification];
        NSLog(@"text内容不为空");
        NSLog(@"点击保存_textField。text = %@", _nickNameTF.text);
    } else {
        NSLog(@"text内容为空");
    }
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

#pragma mark -  UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    _nickName = textField.text;
    NSLog(@"textField.text = %@", textField.text);
    return YES;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self isInuputRuleNoBlank:string] || [string isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
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
