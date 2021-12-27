//
//  CBTabBar.m
//  dysx
//
//  Created by chengbo on 2021/12/27.
//

#import "CBTabBar.h"

@interface CBTabBar ()

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation CBTabBar

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
    
}

//按钮点击事件
- (void)btnAction:(UIButton *)button {
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}

//设置按钮frame
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        CGFloat y = 0;
        CGFloat x = i * (self.bounds.size.width / count);
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
    }
}



@end
