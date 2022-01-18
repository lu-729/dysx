//
//  UIColor+HexColor.h
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
