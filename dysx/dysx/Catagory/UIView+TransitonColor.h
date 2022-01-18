//
//  UIView+TransitonColor.h
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TransitonColor)

//添加渐变色
- (void)addTransitionColor:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)addTransitionColorLeftToRight:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)addTransitionColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
