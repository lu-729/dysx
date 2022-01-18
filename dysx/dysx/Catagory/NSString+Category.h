//
//  NSString+Category.h
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

/**
 *  将长数字以3位用逗号隔开表示（例如：18000 -> 18,000）
 *
 *  @param numberString 数字字符串 （例如：@"124234")
 *
 *  @return 以3位用逗号隔开的数字符串（例如：124,234）
 */
+ (NSString *)formatNumber:(NSString *)numberString;
- (NSString *)formatNumber;

/** md5加密 */
- (NSString *)MD5String;
+ (NSString *)MD5String:(NSString *)string;

/** 移除html标签 */
+ (NSString *)removeHTML:(NSString *)html;
+ (NSString *)removeHTML2:(NSString *)html;

/** 验证email */
+ (BOOL)validateEmail:(NSString *)email;
- (BOOL)validateEmail;

/** 手机号码验证 */
+ (BOOL)validateMobile:(NSString *)mobile;
- (BOOL)validateMobile;

/** 字符串是否包含特殊字符 */
- (BOOL)isIncludeSpecialCharact;

/** (由英文、数字和下划线构成，6-18位，首字母只能是英文和数字) */
+ (BOOL)validatePassword:(NSString *)passWord;
- (BOOL)validatePassword;

/**
 * 判断是否为相同的纯数字
 */
- (BOOL)isSameDigit;
/**
 * 判断是否为连续的数字,6位及6位以上的连续数字
 */
- (BOOL)isOrderDigit;

/// 将int类型转成NSString
FOUNDATION_EXTERN NSString * stringWithInt(int number);
/// 将NSInteger类型转成NSString
FOUNDATION_EXTERN NSString * stringWithInteger(NSInteger number);
/// 将double类型转成NSString，默认2位小数
FOUNDATION_EXTERN NSString * stringWithDouble(double number);
/// 将double类型转成NSString并带上小数位数
FOUNDATION_EXTERN NSString * stringWithDoubleAndDecimalCount(double number, unsigned int count);
///  字符串排序
FOUNDATION_EXTERN NSComparisonResult compareStrings(NSString * string1, NSString * string2, void *context);

///  从汉语到拼音
- (NSString *)fromChineseToPinyin;

/**
 *  计算文字尺寸
 *
 *  @param aString     文字
 *  @param fontSize    文字大小
 *  @param stringWidth 所在控件的宽度
 *
 *  @return 文字尺寸
 */
+ (CGSize)getStringRect:(NSString*)aString fontSize:(CGFloat)fontSize width:(int)stringWidth;

/**
 *  计算文字尺寸
 *
 *  @param fontSize    文字大小
 *  @param stringWidth 所在控件的宽度
 *
 *  @return 文字尺寸
 */
- (CGSize)getStringRectWithfontSize:(CGFloat)fontSize width:(int)stringWidth;

+ (void)setLabellineSpacing:(UILabel *)label aString:(NSString *)content setLineSpacing:(CGFloat)LineSpacing;

/**
 *  根据字符串长度计算label的尺寸
 *
 *  @param text     要计算的字符串
 *  @param fontSize 字体大小
 *  @param maxSize  label允许的最大尺寸
 *
 *  @return label的尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
