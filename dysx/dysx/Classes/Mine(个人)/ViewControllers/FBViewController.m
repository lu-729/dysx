//
//  FBViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "FBViewController.h"
#import "LTextField.h"
#import "MBProgressHUD.h"

@interface FBViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *charTipLabel;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, assign) NSInteger retainCharNumber;

@end

@implementation FBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"用户反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpSubViews];
}


- (void)setUpSubViews {
    
    UIButton *commmitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [commmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commmitBtn addTarget:self action:@selector(commmitBtnAction)];
    commmitBtn.frame = LRect(SCREEN_WIDTH - SCREEN_WIDTH / 5.0, 0, SCREEN_WIDTH / 5.0, 44.f);
//        [messageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commmitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    commmitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [commmitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30.f, 0, 0)];
//    [commmitBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:commmitBtn];
    if (rightItem) {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
    scrollView.backgroundColor = LColor(242.f, 242.f, 247.f);
    [self.view addSubview:scrollView];
    
    UITextView *usrInputTV = [[UITextView alloc] initWithFrame:LRect(20.f, 20.f, SCREEN_WIDTH - 40.f, 130.f)];
    usrInputTV.delegate = self;
    usrInputTV.textContainerInset = UIEdgeInsetsMake(8, 6, 0, 0);
    usrInputTV.backgroundColor = [UIColor whiteColor];
    usrInputTV.layer.cornerRadius = 5.f;
    usrInputTV.layer.masksToBounds = YES;
    usrInputTV.font = [UIFont systemFontOfSize:15.f];
    [scrollView addSubview:usrInputTV];
    
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"请输入反馈内容";
    _placeHolderLabel.font = [UIFont systemFontOfSize:15.f];
    _placeHolderLabel.textColor = LColor(205.f, 205.f, 206.f);
    [usrInputTV addSubview:_placeHolderLabel];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usrInputTV.mas_left).offset(10.f);
        make.top.equalTo(usrInputTV.mas_top).offset(2.5f);
        make.width.mas_equalTo(180.f);
        make.height.mas_equalTo(30.f);
    }];
    
    _charTipLabel = [[UILabel alloc] init];
    _charTipLabel.text = @"剩余150字符";
    _charTipLabel.font = [UIFont systemFontOfSize:13.f];
    _charTipLabel.textAlignment = NSTextAlignmentRight;
    _charTipLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_charTipLabel];
    [_charTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(usrInputTV.mas_right);
        make.top.equalTo(usrInputTV.mas_bottom);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
    }];
    
    LTextField *usrContactTF = [[LTextField alloc] init];
    usrContactTF.backgroundColor = [UIColor whiteColor];
    usrContactTF.placeholder = @"请输入联系方式..";
    usrContactTF.font = [UIFont systemFontOfSize:15.f];
    usrContactTF.layer.cornerRadius = 5.f;
    usrContactTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    usrContactTF.delegate = self;
    [scrollView addSubview:usrContactTF];
    [usrContactTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(usrInputTV.mas_right);
        make.top.equalTo(_charTipLabel.mas_bottom).offset(10.f);
        make.height.mas_equalTo(55.f);
    }];
}


- (void)commmitBtnAction {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text = @"提交成功";
    UIView *view = [[UIView alloc] initWithFrame:LRect(0, 0, 50, 50)];
    [hud setCustomView:view];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    hud.minShowTime = 1.f;
    [hud hideAnimated:YES];
}


#pragma mark - UITextFieldDeleate Method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) {
        return YES;
    }
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 20) {
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate Method

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    if([textView.text length] == 0){
        _placeHolderLabel.text = @"请输入反馈内容..";
    } else {
        _placeHolderLabel.text = @"";//这里给空
    }
    NSString *textContent = textView.text;
    NSInteger existTextNum = textContent.length;
    if (existTextNum >= 150) {
        textView.text = [textContent substringToIndex:150];
    }
    _retainCharNumber = 150 - existTextNum;
    if (_retainCharNumber < 0) {
        _retainCharNumber = 0;
    }
    NSLog(@"existTextNum = %ld, _retainCharNumber = %ld", existTextNum, _retainCharNumber);
    _charTipLabel.text = [NSString stringWithFormat:@"剩余%ld字符", _retainCharNumber];
}





@end
