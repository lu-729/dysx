//
//  AppDelegate.m
//  dysx
//
//  Created by wangyu on 2021/12/6.
//

#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "DYTabBarController.h"
#import "LTabBarController.h"
#import "LPhotoTools.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

const static NSString *geoApiKey = @"199f789608381d8765dd2d6e46226b3b";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建并显示窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    //设置窗口根视图控制器为CBTabBarController
    DYTabBarController *lTabBarVC = [[DYTabBarController alloc] init];
    _window.rootViewController = lTabBarVC;
    
//    //初始化ALi SDK
//    IMSIotSmartConfig *config = [IMSIotSmartConfig new];
//    config.regionType = REGION_ALL;
//    [IMSIotSmart sharedInstance].config = config;
//    //设置安全图片,如果不设置，默认使用
//    [[IMSIotSmart sharedInstance] setAuthCode:@"china_production"];
//    [[IMSIotSmart sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
//    [[IMSIotSmart sharedInstance] configProductScope:PRODUCT_SCOPE_PUBLISHED];
    
    
    NSString *subVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSLog(@"------------------------subVersion : %@", subVersion);
    
//    UIWindow *_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _window.rootViewController = [[UIViewController alloc] init];
//    _window.windowLevel = UIWindowLevelAlert + 10000000.0;
//    [_window makeKeyAndVisible];
    
    
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提示" message:@"发现新版本。为保证各项功能正常使用，请您尽快更新。" preferredStyle:UIAlertControllerStyleAlert];
    //显示弹出框
    [_window.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id123456789?mt=8"]];
        //这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
        NSLog(@"点击现在升级按钮,跳转");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击下次再说按钮");  //如果不add这段Action，则弹窗中只有1个按钮，即强制用户更新
    }]];
     
     */
    
    NSLog(@"000000000000000%f", IOS_VERSION);
    
    
    /*
    NSString *subVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"id"] = @"123456789";// 你程序的apple ID号
    
    [mgr POST:@"http://itunes.apple.com/cn/lookup?id=123456789"
   parameters:dict
      headers:nil
     progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // App_URL http://itunes.apple.com/lookup
            NSArray *array = responseObject[@"results"];
            if (array.count != 0) {// 先判断返回的数据是否为空   没上架的时候是空的
                NSDictionary *dict = array[0];
     
                if ([dict[@"version"] floatValue] > [subVersion floatValue]) {
                    //如果有新版本 这里要注意下如果你版本号写得是1.1.1或者1.1.1.1这样的格式，就不能直接转floatValue，自己想办法比较判断。
                    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                    alertWindow.rootViewController = [[UIViewController alloc] init];
                    alertWindow.windowLevel = UIWindowLevelAlert + 1;
                    [alertWindow makeKeyAndVisible];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提示" message:@"发现新版本。为保证各项功能正常使用，请您尽快更新。" preferredStyle:UIAlertControllerStyleAlert];
                    //显示弹出框
                    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id123456789?mt=8"]];
                        //这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
                        NSLog(@"点击现在升级按钮,跳转");
                    }]];
                    		
                    [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSLog(@"点击下次再说按钮");  //如果不add这段Action，则弹窗中只有1个按钮，即强制用户更新
                    }]];
                }
           }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
     */
    

    [LPhotoTools getUsrPhotoAuthorizationStatus];
     
    // 配置高德地图ApiKey
    [self configureGeoApiKey];
    
    [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
     
    return YES;
}


//配置高德地图ApiKey
- (void)configureGeoApiKey {
    [AMapServices sharedServices].apiKey = (NSString *)geoApiKey;
}


@end
