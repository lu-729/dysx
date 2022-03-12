//
//  DYMapView.m
//  dysx
//
//  Created by chengbo on 2022/3/8.
//

#import "DYMapView.h"

@interface DYMapView ()

@property (nonatomic, strong) UIButton *currentLocBtn;
@property (nonatomic, strong) UIButton *carLocBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *zoomInBtn;
@property (nonatomic, strong) UIButton *zoomOutBtn;

@end

@implementation DYMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews {
    [self addSubview:self.carLocBtn];
    [self addSubview:self.currentLocBtn];
    [self addSubview:self.bgView];
}


- (UIButton *)currentLocBtn {
    if (!_currentLocBtn) {
        _currentLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _currentLocBtn.backgroundColor = [UIColor whiteColor];
        [_currentLocBtn setImage:[UIImage imageNamed:@"dangqianweizhi"]];
        [_currentLocBtn addTarget:self action:@selector(currentLocBtnClicked)];
    }
    return _currentLocBtn;
}


- (UIButton *)carLocBtn {
    if (!_carLocBtn) {
        _carLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _carLocBtn.backgroundColor = [UIColor whiteColor];
        [_carLocBtn setImage:[UIImage imageNamed:@"car"]];
        [_carLocBtn addTarget:self action:@selector(carLocBtnClicked)];
    }
    return _carLocBtn;
}


- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        [_bgView addSubview:self.zoomInBtn];
        [_bgView addSubview:self.zoomOutBtn];
    }
    return _bgView;
}


- (UIButton *)zoomInBtn {
    if (!_zoomInBtn) {
        _zoomInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zoomInBtn setImage:[UIImage imageNamed:@"default_navi_zoomin_normal"]];
        [_zoomInBtn addTarget:self action:@selector(zoomInBtnClicked)];
    }
    return _zoomInBtn;
}


- (UIButton *)zoomOutBtn {
    if (!_zoomOutBtn) {
        _zoomOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zoomOutBtn setImage:[UIImage imageNamed:@"default_navi_zoomout_normal"]];
        [_zoomOutBtn addTarget:self action:@selector(zoomOutBtnClicked)];
    }
    return _zoomOutBtn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
//    __weak typeof(self) weakSelf = self;
    CGFloat width= 40.f;
    [_carLocBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.bottom.mas_equalTo(-34.f);
        make.height.width.mas_equalTo(width);
    }];
    [_currentLocBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.bottom.equalTo(_carLocBtn.mas_top).offset(-10.f);
        make.width.height.mas_equalTo(width);
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.f);
        make.bottom.equalTo(_carLocBtn.mas_bottom);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(2*width);
    }];
    [_zoomInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(width);
    }];
    [_zoomOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.height.mas_equalTo(width);
    }];
}


- (void)currentLocBtnClicked {
    NSLog(@"111111111111");
    
}


- (void)carLocBtnClicked {
    
}


- (void)zoomInBtnClicked {
    if ([self.dyDelegate respondsToSelector:@selector(zoomInMapView)]) {
        [self.dyDelegate zoomInMapView];
    }
}


- (void)zoomOutBtnClicked {
    if ([self.dyDelegate respondsToSelector:@selector(zoomInMapView)]) {
        [self.dyDelegate zoomOutMapView];
    }
}


@end
