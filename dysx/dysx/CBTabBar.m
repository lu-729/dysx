//
//  CBTabBar.m
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import "CBTabBar.h"
#import "CBTabBarButton.h"

@interface CBTabBar ()

@property (nonatomic, strong) CBTabBarButton *selectedBtn;

@end

@implementation CBTabBar


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addBarButton];
    }
    return self;
}


- (void)addBarButton {
    NSArray *titleArr = @[@"首页",@"",@"我的"];
    NSString *title;
    NSString *imgName;
    NSString *selectedImgName;
    for (int i=0; i<3; i++) {
        CBTabBarButton *btn = [[CBTabBarButton alloc] init];
        CGFloat btnW = self.frame.size.width / 3;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        CGFloat btnH = self.frame.size.height;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        if (i != 1) {
            imgName = [NSString stringWithFormat:@"TabBar%d", i+1];
            selectedImgName = [NSString stringWithFormat:@"TabBar%dSel", i+1];
            title = titleArr[i];
        } else {
            imgName = @"摄影机图标_点击前";
            selectedImgName = @"摄影机图标_点击后";
        }
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.tag = i;
        if (i != 1) {
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:11.f];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //使图片和文字水平居中显示
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height,-btn.imageView.frame.size.width, 0.0,0.0)];
            //图片距离右边框距离减少图片的宽度，其它不边
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0, 0.0, -btn.titleLabel.bounds.size.width)];

        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            [self btnClick:btn];
        }
        
    }
}

- (void)btnClick:(UIButton *)button {
    if (button.tag != 1) {
        [self.delegate tabBar:self selectedFrom:_selectedBtn.tag to:button.tag];
        _selectedBtn.selected = NO;
        button.selected = YES;
        _selectedBtn = (CBTabBarButton *)button;
    } else {
        
    }
}


- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UIButton *btn = [[UIButton alloc] init];
    /*
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    */
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.subviews.count == 1) {
        [self btnAction:btn];
    }
}

//按钮点击事件
- (void)btnAction:(UIButton *)button {
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = (CBTabBarButton *)button;
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}

//设置按钮frame
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    NSUInteger count = self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        UIButton *btn = self.subviews[i];
//        btn.tag = i;
//        CGFloat y = 0;
//        CGFloat x = i * (self.bounds.size.width / count);
//        CGFloat width = self.bounds.size.width / count;
//        CGFloat height = self.bounds.size.height;
//        btn.frame = CGRectMake(x, y, width, height);
//    }
//}



@end
