//
//  helpView.m
//  dysx
//
//  Created by chengbo on 2022/1/19.
//

#import "HelpView.h"

@interface HelpView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@end

@implementation HelpView


- (instancetype)initWithName:(NSString *)name number:(NSString *)number {
    self = [super init];
    if (self) {
        [self setUpSubViews:name number:number];
    }
    return self;
}

- (void)setUpSubViews:(NSString *)name number:(NSString *)number {
    _label = [[UILabel alloc] init];
    _label.text = name;
    _label.font = [UIFont systemFontOfSize:15.f];
    _label.textColor = [UIColor lightGrayColor];
    [self addSubview:_label];
    _button = [[UIButton alloc] init];
    [_button setTitleFont:15.f];
    [_button setTitleColor:[UIColor blueColor]];
    [_button setTitleColor:LColor(59, 135, 251)];
    [_button setTitle:number forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick:)];
    [self addSubview:_button];
}

- (void)buttonClick:(UIButton *)button {
    NSLog(@"button.title = %@", button.titleLabel.text);
    NSString *numberStr = [NSString stringWithFormat:@"tel://%@", button.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberStr]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberStr] options:nil completionHandler:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.width / 2;
    __weak typeof(self) weakSelf = self;
    
    if ([_label.text isEqualToString:@"太平洋保险"]) {
        CGFloat labelWidth = width + 10.f;
        CGFloat buttonWidth = width - 10.f;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.mas_equalTo(labelWidth);
        }];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_label.mas_right);
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.mas_equalTo(buttonWidth);
        }];
    } else {
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.mas_equalTo(width);
        }];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_label.mas_right);
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.mas_equalTo(width);
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
