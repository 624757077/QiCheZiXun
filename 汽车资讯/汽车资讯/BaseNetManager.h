//
//  BaseNetManager.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject
+GET:(NSString *)path parameters:(NSDictionary *)parames compleHandle:(void(^)(id responseObj,NSError *error))complete;

+POST:(NSString *)path parameters:(NSDictionary *)parames compleHandle:(void(^)(id responseObj,NSError *error))complete;

@end
