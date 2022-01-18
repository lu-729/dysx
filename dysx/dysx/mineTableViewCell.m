//
//  mineTableViewCell.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "mineTableViewCell.h"

@implementation mineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).mas_offset(10.f);
//    }];
//    self.imageView.frame = LRect(10.f, 0, 30.f, 30.f);
//    self.imageView.size = LSize(40.f, 30.f);
    
//    self.textLabel.frame = LRect(59.f, 0, 266.f, 50.f);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(40.f);
        make.width.mas_equalTo(44.f);
        make.height.mas_equalTo(34.f);
        make.left.equalTo(weakSelf.mas_left).mas_offset(5.f);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imageView.mas_right).mas_offset(5.f);
        make.height.mas_equalTo(50.f);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-5.f);
    }];
    
    CGFloat left = self.textLabel.frame.origin.x;
    NSLog(@"left = %f", left);
    self.separatorInset = UIEdgeInsetsMake(0, 54.f, 0, 0);
    
//    rame = (79 0; 256 50)
//    frame = (79 49.6667; 271 0.333333)
//    UITableViewCellContentView
//    _UITableViewCellSeparatorView
}

// 配置cell高亮状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = LColor(242.f, 242.f, 247.f);
    } else {
        // 增加延迟消失动画效果，提升用户体验
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundColor = [UIColor whiteColor];
        } completion:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.contentView.backgroundColor = [UIColor lightGrayColor];
//    } else {
//        self.contentView.backgroundColor = [UIColor whiteColor];
//    }
}

@end
