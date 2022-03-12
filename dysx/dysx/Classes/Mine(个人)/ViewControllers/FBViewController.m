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
@property (nonatomic, strong) LTextField *usrContactTF;
@property (nonatomic, strong) UIButton *commmitBtn;
@property (nonatomic, strong) UITextView *usrInputTV;

@end

@implementation FBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"用户反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubViews];
}


- (void)setupSubViews {
    _commmitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_commmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_commmitBtn setTitleColor:[UIColor grayColor]];
    _commmitBtn.userInteractionEnabled = NO;
    [_commmitBtn addTarget:self action:@selector(commmitBtnAction)];
    _commmitBtn.frame = LRect(SCREEN_WIDTH - SCREEN_WIDTH / 5.0, 0, SCREEN_WIDTH / 5.0, 44.f);
//        [messageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _commmitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    _commmitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_commmitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30.f, 0, 0)];
//    [commmitBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_commmitBtn];
    if (rightItem) {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
    scrollView.backgroundColor = LColor(242.f, 242.f, 247.f);
    [self.view addSubview:scrollView];
    _usrInputTV = [[UITextView alloc] initWithFrame:LRect(20.f, 20.f, SCREEN_WIDTH - 40.f, 130.f)];
    _usrInputTV.delegate = self;
    _usrInputTV.textContainerInset = UIEdgeInsetsMake(8, 6, 0, 0);
    _usrInputTV.backgroundColor = [UIColor whiteColor];
    _usrInputTV.layer.cornerRadius = 5.f;
    _usrInputTV.layer.masksToBounds = YES;
    _usrInputTV.font = [UIFont systemFontOfSize:15.f];
    [scrollView addSubview:_usrInputTV];
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"请输入反馈内容";
    _placeHolderLabel.font = [UIFont systemFontOfSize:15.f];
    _placeHolderLabel.textColor = LColor(205.f, 205.f, 206.f);
    [_usrInputTV addSubview:_placeHolderLabel];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_usrInputTV.mas_left).offset(10.f);
        make.top.equalTo(_usrInputTV.mas_top).offset(2.5f);
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
        make.right.equalTo(_usrInputTV.mas_right);
        make.top.equalTo(_usrInputTV.mas_bottom);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
    }];
    _usrContactTF = [[LTextField alloc] init];
    _usrContactTF.backgroundColor = [UIColor whiteColor];
    _usrContactTF.placeholder = @"请输入联系方式..";
    _usrContactTF.font = [UIFont systemFontOfSize:15.f];
    _usrContactTF.layer.cornerRadius = 5.f;
    _usrContactTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usrContactTF.delegate = self;
    [_usrContactTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [scrollView addSubview:_usrContactTF];
    [_usrContactTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(_usrInputTV.mas_right);
        make.top.equalTo(_charTipLabel.mas_bottom).offset(10.f);
        make.height.mas_equalTo(55.f);
    }];
}


- (void)textFieldDidChanged:(UITextField *)textField {
    if (_usrInputTV.text.length > 0 && textField.text.length > 0) {
        self.commmitBtn.userInteractionEnabled = YES;
        [self.commmitBtn setTitleColor:[UIColor systemBlueColor]];
    } else {
        [_commmitBtn setTitleColor:[UIColor grayColor]];
        _commmitBtn.userInteractionEnabled = NO;
    }
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
    _usrInputTV = textView;
    if (_usrInputTV.text.length > 0 && _usrContactTF.text.length > 0) {
        self.commmitBtn.userInteractionEnabled = YES;
        [self.commmitBtn setTitleColor:[UIColor systemBlueColor]];
    } else {
        [_commmitBtn setTitleColor:[UIColor grayColor]];
        _commmitBtn.userInteractionEnabled = NO;
    }
    if([_usrInputTV.text length] == 0){
        _placeHolderLabel.text = @"请输入反馈内容..";
    } else {
        _placeHolderLabel.text = @"";//这里给空
//        if (![_usrInputTV.text isEqual: @""] && ![_usrContactTF.text isEqual:@""]) {
//            NSLog(@"TV11111111111111111111111_usrInputTV.text = %@ , _usrContactTF.text = %@",_usrInputTV.text,_usrContactTF.text);
//            [_commmitBtn setTitleColor:[UIColor systemBlueColor]];
//            _commmitBtn.userInteractionEnabled = YES;
//        } else {
//            NSLog(@"TV000000000000000000000000_usrInputTV.text = %@ , _usrContactTF.text = %@",_usrInputTV.text,_usrContactTF.text);
//            [_commmitBtn setTitleColor:[UIColor grayColor]];
//            _commmitBtn.userInteractionEnabled = NO;
//        }
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
//    NSLog(@"existTextNum = %ld, _retainCharNumber = %ld", existTextNum, _retainCharNumber);
    _charTipLabel.text = [NSString stringWithFormat:@"剩余%ld字符", _retainCharNumber];
}





@end
