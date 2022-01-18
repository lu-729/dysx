//
//  UIButton+Category.h
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Category)

/** 文字*/
@property (nonatomic, copy) NSString * title;
/** 图片，传图片或者图片名 */
@property (nonatomic, strong) id image;
/** 高亮图片，传图片或者图片名 */
@property (nonatomic, strong) id highlightImage;
/** 选中图片，传图片或者图片名 */
@property (nonatomic, strong) id selectImage;
/** 文字颜色 */
@property (nonatomic, strong) UIColor * titleColor;
/** 选中文字颜色 */
@property (nonatomic, strong) UIColor * selectTitleColor;

@property (nonatomic , assign) CGFloat titleFont;

/**
 *  添加监听
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 *  倒计时
 *
 *  @param timeLine            timeLine 共计时间（单位：秒）
 *  @param title               正常文字
 *  @param subTitle            倒计时的文字（传入时间之后的文字，例如：“s后重新获取”）
 *  @param titleColor          正常的文字颜色
 *  @param countDownTitleColor 倒计时文字颜色
 *  @param mColor              正常的背景颜色
 *  @param color               倒计时背景颜色
 */
- (void)countDownWithTime:(NSInteger)timeLine
                    title:(NSString *)title
           countDownTitle:(NSString *)subTitle
               titleColor:(UIColor *)titleColor
      countDownTitleColor:(UIColor *)countDownTitleColor
          backgroundColor:(UIColor *)mColor
            disabledColor:(UIColor *)color;
- (void)countDownWithTime:(NSInteger)timeLine
              title:(NSString *)title
     countDownTitle:(NSString *)subTitle
         titleColor:(UIColor *)titleColor borderColor:(UIColor *)borderColor
countDownTitleColor:(UIColor *)countDownTitleColor
    backgroundColor:(UIColor *)mColor
      disabledColor:(UIColor *)color disableBorderColor:(UIColor *)mborderColor;

/// 快速创建button
+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                backgroundColor:(UIColor *)bgColor
                           font:(CGFloat)fontSize
                          image:(id)image
                          frame:(CGRect)frame;

/// 快速创建button,带监听
+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                backgroundColor:(UIColor *)bgColor
                           font:(CGFloat)fontSize
                          image:(id)image
                         target:(id)target
                         action:(SEL)action
                          frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
