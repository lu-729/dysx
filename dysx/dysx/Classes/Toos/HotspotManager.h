//
//  HotspotManager.h
//  dysx
//
//  Created by chengbo on 2022/3/9.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface HotspotManager : NSObject

+ (void)connectWifiWithSSID:(NSString *)ssid password:(NSString *)pwd;


@end

NS_ASSUME_NONNULL_END
