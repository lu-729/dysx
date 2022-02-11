//
//  UIViewController+LModal.m
//  dysx
//
//  Created by chengbo on 2022/2/10.
//

#import "UIViewController+LModal.h"
#import <objc/runtime.h>

@implementation UIViewController (LModal)


/// 加载视图控制器时对模态方法进行混淆替换
+ (void)load {
    [super load];
    SEL originalSel = @selector(presentViewController:animated:completion:);
    SEL overrideSel = @selector(override_presentViewController:animated:completion:);
    Method originalMethod = class_getInstanceMethod([self class], originalSel);
    Method overrideMethod = class_getInstanceMethod([self class], overrideSel);
    method_exchangeImplementations(originalMethod, overrideMethod);
}

#pragma mark - Swizzling Method

- (void)override_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(ios 13.0, *)) {
        if (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self override_presentViewController:viewControllerToPresent animated:flag completion:completion];
}



@end
