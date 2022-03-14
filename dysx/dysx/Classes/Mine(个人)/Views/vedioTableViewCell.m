//
//  vedioTableViewCell.m
//  dysx
//
//  Created by chengbo on 2022/3/14.
//

#import "vedioTableViewCell.h"

@implementation vedioTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.timeLabel];
}


- (UIImageView *)imageView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor yellowColor];
    }
    return _imgView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2022-3-16 22:22:22";
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _timeLabel;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
