//
//  HotspotManager.m
//  dysx
//
//  Created by chengbo on 2022/3/9.
//

#import "HotspotManager.h"
#import <NetworkExtension/NetworkExtension.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation HotspotManager

+ (void)connectWifiWithSSID:(NSString *)ssid
                   password:(NSString *)pwd {
    if (@available(iOS 11.0, *)) {
        NEHotspotConfiguration *hotspotConfig = [[NEHotspotConfiguration alloc]
                                                 initWithSSID:ssid
                                                 passphrase:pwd
                                                 isWEP:NO];
        [[NEHotspotConfigurationManager sharedManager] applyConfiguration:hotspotConfig
                                                        completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                //判断是否链接成功
                if ([[self getCurrentWifi] isEqualToString:ssid]) {
                    NSLog(@"已连接手机热点 %@", ssid);
                }
            } else {
                NSLog(@"其他情况");
            }
        }];
    }
    
}


+ (NSString *)getCurrentWifi {
    NSString *ssid = nil;
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    for (NSString *ifsName in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifsName);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}

@end
