//
//  DeviceTableViewCell.m
//  dysx
//
//  Created by chengbo on 2022/2/27.
//

#import "DeviceTableViewCell.h"

@interface DeviceTableViewCell ()

@property (nonatomic, strong) UIImageView *deviceImg;
@property (nonatomic, strong) UIButton *remoteLinkBtn;
@property (nonatomic, strong) UIButton *localLinkBtn;
@property (nonatomic, strong) UIButton *setup;

@end

@implementation DeviceTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"调用了initWithFrame方法");
        [self createSubviews];
    }
    return self;
}


- (void)createSubviews {
    if (!_deviceImg) {
        _deviceImg = [[UIImageView alloc] init];
        _deviceImg.backgroundColor = [UIColor blueColor];
        [self addSubview:_deviceImg];
    }
    if (!_remoteLinkBtn) {
        _remoteLinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remoteLinkBtn setTitleColor:[UIColor systemGrayColor]];
        _remoteLinkBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_remoteLinkBtn addTarget:self action:@selector(buttonAction:)];
        [self addSubview:_remoteLinkBtn];
    }
    if (!_localLinkBtn) {
        _localLinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_localLinkBtn setTitleColor:[UIColor systemGrayColor]];
        _localLinkBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_localLinkBtn addTarget:self action:@selector(buttonAction:)];
        [self addSubview:_localLinkBtn];
    }
    if (!_setup) {
        _setup = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setup setTitleColor:[UIColor systemGrayColor]];
        _setup.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_setup addTarget:self action:@selector(buttonAction:)];
        [self addSubview:_setup];
    }
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}


- (void)buttonAction:(UIButton *)button {
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
