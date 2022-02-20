//
//  LTabBar.m
//  dysx
//
//  Created by chengbo on 2022/1/14.
//

#import "LTabBar.h"
#import "LTabBarButton.h"
#import "LTabBarController.h"


@interface LTabbar()

@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) LTabBarButton *_selectedBarButton;

@end

@implementation LTabbar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBarButtons];
    }
    return self;
}

-(void) addBarButtons{
    UIButton *button = [[UIButton alloc] init];
//    UIImage *image = [self createImageWithColor:[UIColor redColor]];
//    [publishBtn setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"摄影机图标_点击前"] forState:UIControlStateNormal];
//    publishBtn.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    _publishBtn = button;
    [self addSubview:_publishBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _publishBtn.size = _publishBtn.currentBackgroundImage.size;
    _publishBtn.centerX = self.width / 2;
    _publishBtn.centerY = _publishBtn.height / 4;
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            if (j == 1) {
                j++;
            }
            view.width = self.width / 3.0;
            view.x = self.width * j / 3.0;
            j++;
            
        }
    }
    
}


// 点击发布
- (void) didClickPublishBtn:(UIButton *) sender {
//    NSLog(@"点击了发布");
    if (self.didClickPublishBtn) {
        self.didClickPublishBtn();
    }
}






@end

