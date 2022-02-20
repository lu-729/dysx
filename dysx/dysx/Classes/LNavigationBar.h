//
//  LNavigarionBar.h
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNavigationBar : UIView

///  标题Label,通过类方法传入title初始化, 只读
@property (nonatomic,   weak, readonly) UILabel * titleLabel;
///  自定义view，通过类方法初始化, 只读
@property (nonatomic,   weak, readonly) UIView * customView;
///  右侧按钮集合，通过类方传入rightItems法初始化，只读
@property (nonatomic,   copy, readonly) NSArray<UIButton *> *rightButtons;
///  右侧按钮
@property (nonatomic,   weak) UIButton * rightButton;
///  返回按钮
@property (nonatomic,   weak) UIButton * leftButton;
///  分隔线
@property (nonatomic,   weak) UIView * diveder;

@property (nonatomic,   copy) void (^rightBtnAction)(NSInteger index);

///  设置成白色主题
- (void)setupToWhiteTheme;

///  只有标题
///
///  @param title 标题
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title;

///  只有标题和返回键
///
///  @param title      标题
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                  backAction:(void(^)(void))backAction;


/// 标题 + 右边item(图片或文字都行)（没有返回按钮）
/// @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                   rightItem:(NSString *)rightItem
                 rightAction:(void(^)(void))action;


///  标题 + 右边item(图片或文字都行) + 返回按钮
///
///  @param title      标题
///  @param rightItem  右侧图片/文字
///  @param action     右侧点击事件
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                   rightItem:(NSString *)rightItem
                 rightAction:(void(^)(void))action
                  backAction:(void(^)(void))backAction;

///  标题 + 右边item(图片或文字都行) + 返回按钮
///
///  @param customView 自定义view
///  @param rightItem  右侧图片/文字
///  @param action     右侧点击事件
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithCustomView:(UIView *)customView
                        rightItem:(NSString *)rightItem
                      rightAction:(void(^)(void))action
                       backAction:(void(^)(void))backAction;

///  标题 + 右边items(图片或文字都行) + 返回按钮
///
///  @param title      标题
///  @param rightItems 右侧图片/文字
///  @param action     右侧点击事件
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                  rightItems:(NSArray<NSString *> *)rightItems
                 rightAction:(void(^)(NSInteger index))action
                  backAction:(void(^)(void))backAction;

//////////孟遥新增

/**
 自定义左右按钮
 */
+ (instancetype)navWithTitle:(NSString *)title
                     lefItem:(id)leftItem
                  leftAction:(void(^)(void))leftAction
                   rightItem:(NSString *)rightItem
                 rightAction:(void(^)(void))rightAction;

//////////新增
/**
自定义视图自定义尺寸
*/
+ (instancetype)navWithCustomView:(UIView *)customView
                            frame:(CGRect)frame
                       backAction:(void(^)(void))backAction;

/// 删除分隔线
- (void)removeDivider;

@end

@interface UIViewController (NavigatiionBar)

@property (nonatomic, strong) LNavigationBar * l_navgationBar;

@end

NS_ASSUME_NONNULL_END
