//
//  PhotoCollectionViewCell.m
//  dysx
//
//  Created by chengbo on 2022/2/11.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"调用了initWithFrame方法");
        [self createSubviews];
    }
    return self;
}


- (void)createSubviews {
//    _markImgView = [[UIImageView alloc] initWithImage:<#(nullable UIImage *)#> highlightedImage:<#(nullable UIImage *)#>];
    _markImgView.hidden = YES;
    [self addSubview:self.imgView];
    [self addSubview:self.timeLabel];
    [_imgView addSubview:_markImgView];
}



- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor systemGrayColor];
    }
    return _imgView;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor darkGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _timeLabel;
}





- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat scale = 9.0 / 16;
    CGFloat imgviewWidth = self.width * scale;
    __weak typeof(self) weakSelf = self;
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo (weakSelf.mas_top);
        make.width.equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(imgviewWidth);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(_imgView.mas_bottom);
        make.width.equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(20.f);
    }];
    [_markImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imgView.mas_right);
        make.bottom.equalTo(_imgView.mas_bottom);
        make.width.mas_equalTo(30.f);
        make.height.mas_equalTo(30.f);
    }];
}

@end
