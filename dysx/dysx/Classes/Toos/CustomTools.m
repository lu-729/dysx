//
//  CustomTools.m
//  dysx
//
//  Created by chengbo on 2022/1/15.
//

#import "CustomTools.h"

@implementation CustomTools

+ (CGFloat)getStatusBarHeight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

@end
