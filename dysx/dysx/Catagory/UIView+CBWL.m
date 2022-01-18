//
//  UIView+CBWL.m
//  dysx
//
//  Created by chengbo on 2021/12/28.
//

#import "UIView+CBWL.h"

@implementation UIView (CBWL)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)halfWidth {
    return CGRectGetWidth(self.frame) * 0.5;
}

- (CGFloat)halfHeight {
    return CGRectGetHeight(self.frame) * 0.5;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius rounding:(UIRectCorner)rounding {
    
}

- (void)setBorderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.borderWidth = bWidth;
    self.borderColor = bColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.cornerRadius = cornerRadius;
    [self setBorderWidth:bWidth borderColor:bColor];
}


@end

#pragma mark - UILabel (Extension)
@implementation UILabel (YND)

+ (instancetype)labelWithText:(NSString *)text font:(CGFloat)fontSize textColor:(UIColor *)color frame:(CGRect)frame {
    UILabel * label = [[self alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    if (text) label.text = text;
    if (color) label.textColor = color;
    return label;
}
@end

#pragma mark - UIImageView
@implementation UIImageView (YND)

+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    //    NSAssert(image != nil, @"图片不能为空");
    UIImageView * imageView = [[self alloc] initWithFrame:frame];
    [imageView setImage:image];
    return imageView;
}

+ (instancetype)imageViewWithUrl:(NSURL *)url frame:(CGRect)frame {
    
    return [self imageViewWithUrl:url placeHolder:nil frame:frame];
}

+ (instancetype)imageViewWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder frame:(CGRect)frame {
    
    UIImageView * imageView = [[self alloc] initWithFrame:frame];
  //  [imageView sd_setImageWithURL:url placeholderImage:placeHolder];
    return imageView;
}

@end

#pragma mark - UIScrollView
@implementation UIScrollView (YND)

+ (instancetype)defaultScrollView {
    return [self scrollViewWithBgColor:nil frame:LRect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
}

+ (instancetype)scrollViewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame {
    UIScrollView * scrollView = [[self alloc] initWithFrame:frame];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (bgColor) {
        scrollView.backgroundColor = bgColor;
    } else {
        scrollView.backgroundColor = [UIColor clearColor];
    }
    return scrollView;
}

@end
