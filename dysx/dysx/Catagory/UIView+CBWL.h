//
//  UIView+CBWL.h
//  dysx
//
//  Created by chengbo on 2021/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CBWL)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly) CGFloat halfWidth;//宽的一半
@property (nonatomic, assign, readonly) CGFloat halfHeight;//高的一半
@property (nonatomic, assign) CGFloat maxX;//最大x
@property (nonatomic, assign) CGFloat maxY;//最大y
@property (nonatomic, assign) CGPoint maxOrigin;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;//圆角
@property (nonatomic, strong) IBInspectable UIColor *borderColor;//边框颜色
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;//边框宽度

- (void)setCornerRadius:(CGFloat)cornerRadius rounding:(UIRectCorner)rounding;
- (void)setBorderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor;
- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor;
/* 创建view并初始化背景色和frame */
+ (instancetype)viewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame;
/*  找到view的控制器：返回view所加载在的控制器 */
- (UIViewController *)cb_viewController;


@end

NS_ASSUME_NONNULL_END
