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
        [self createSubViews];
    }
    return self;
}


- (void)createSubViews {
    UIImageView *markImgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    [self addSubview:self.timeLabel];
    [_imgView addSubview:markImgView];
}


- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _timeLabel;
}



@end
