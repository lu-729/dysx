//
//  LPhotoTools.m
//  dysx
//
//  Created by chengbo on 2022/1/21.
//

#import "LPhotoTools.h"
#import <Photos/Photos.h>

@implementation LPhotoTools


+ (BOOL)isCanVisitPhotoLibrary {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        return YES;
    }
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    
    __block BOOL isAblity = YES;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status != PHAuthorizationStatusAuthorized) {
                NSLog(@"未开启相册权限,请到设置中开启");
                isAblity = NO;
                dispatch_semaphore_signal(semaphore);
            }
        }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return isAblity;
}



- (void)savePhtotsWithImage:(UIImage *)image {
    // 获取当前的授权状态
    PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求授权
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(status == PHAuthorizationStatusDenied) {
                if (lastStatus == PHAuthorizationStatusNotDetermined) {
                    //说明，用户之前没有做决定，在弹出授权框中，选择了拒绝
//                    [[AppDelegate app] showErrorAndAutoHide:@"保存失败！"];
                    return;
                }
                // 说明，之前用户选择拒绝过，现在又点击保存按钮，说明想要使用该功能，需要提示用户打开授权
//                [[AppDelegate app] showErrorAndAutoHide:@"失败！请打开 设置-隐私-照片 来进行设置"];
                
            } else if(status == PHAuthorizationStatusAuthorized) {
                //保存图片---调用上面封装的方法
        
            } else if (status == PHAuthorizationStatusRestricted) {
//                [[AppDelegate app] showErrorAndAutoHide:@"系统原因，无法访问相册！"];
            }
        });
    }];
}

+ (void)getUsrPhotoAuthorizationStatus {
    PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"lastStatus = %ld", (long)lastStatus);
    if (lastStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"用户同意授权");
            } else {
                NSLog(@"用户拒绝授权");
            }
        }];
    }
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        if (status == PHAuthorizationStatusDenied) {
//            if (lastStatus == PHAuthorizationStatusNotDetermined) {
//
//            }
//        }
//    }];
}


@end
