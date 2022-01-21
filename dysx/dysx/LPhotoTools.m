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

@end
