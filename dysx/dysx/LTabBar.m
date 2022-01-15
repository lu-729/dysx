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
{
    LTabBarButton *_selectedBarButton;
}
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
  
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton *publishBtn = [[UIButton alloc] init];
//    UIImage *image = [self createImageWithColor:[UIColor redColor]];
//    [publishBtn setBackgroundImage:image forState:UIControlStateNormal];
    [publishBtn setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
//    publishBtn.backgroundColor = [UIColor redColor];
    [publishBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.adjustsImageWhenHighlighted = NO;
    publishBtn.size = publishBtn.currentBackgroundImage.size;
    publishBtn.centerX = self.width / 2;
    publishBtn.centerY = publishBtn.height / 4;
    [self addSubview:publishBtn];
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / 3.0;
            view.x = self.width * j / 3.0;
            j++;
            if (j == 1) {
                j++;
            }
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

