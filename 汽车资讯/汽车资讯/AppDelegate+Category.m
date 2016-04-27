//
//  AppDelegate+Category.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "AppDelegate+Category.h"
#import <AFNetworkActivityIndicatorManager.h>
@implementation AppDelegate (Category)

- (void)initializeWithApplication:(UIApplication *)application{
    //  注册DDLog 取代 NSLog
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //    电池条显示网络活动
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //    检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        DDLogVerbose(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.onLine = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                self.onLine = NO;
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}




@end
