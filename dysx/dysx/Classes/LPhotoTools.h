//
//  LPhotoTools.h
//  dysx
//
//  Created by chengbo on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPhotoTools : NSObject

+ (BOOL)isCanVisitPhotoLibrary;
+ (void)getUsrPhotoAuthorizationStatus;

@end

NS_ASSUME_NONNULL_END
