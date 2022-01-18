//
//  EditProfileViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/18.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) UIView *nickNameView;

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
    _flag = 0;
    if (_flag == 0) {
        [self setUpNickNameViews];
    } else {
        [self setUpPhoneNumViews];
    }
    
}

- (void)setUpNickNameViews {
    _nickNameView = [[UIView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
//    nickNameView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_nickNameView];
    _textField = [[UITextField alloc] initWithFrame:LRect(0, 80.f, 250.f, 30.f)];
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.centerX = _nickNameView.centerX;
    _textField.placeholder = @"输入昵称..";
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_nickNameView addSubview:_textField];
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [_nickNameView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textField.mas_left);
        make.height.mas_equalTo(0.5f);
        make.width.equalTo(_textField.mas_width);
        make.top.equalTo(_textField.mas_bottom);
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

- (void)btnClick {
    
    if (![_nickName isEqualToString:@""]) {
        [_textField resignFirstResponder];
        [self sendNotification];
        NSLog(@"text内容不为空");
    } else {
        
    }
}

// 昵称上传后端成功后发送通知,通知其他页面更改昵称
- (void)sendNotification {
    
    NSString *nameChangenotification = @"nameChangeNotification";
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:nameChangenotification object:self userInfo:nil];
    
}

- (void)setUpPhoneNumViews {
    
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
