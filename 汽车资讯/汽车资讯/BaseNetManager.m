//
//  BaseNetManager.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "BaseNetManager.h"
//声明一个静态变量
static AFHTTPSessionManager *manager = nil;

@implementation BaseNetManager

+(AFHTTPSessionManager *)sharedManager
{
    static dispatch_once_t onceToKan;
    dispatch_once(&onceToKan,^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"text/plain", nil];
    });
    return manager;
    
}

+(id)GET:(NSString *)path parameters:(NSDictionary *)parames compleHandle:(void (^)(id, NSError *))complete
{
    NSLog(@"%@",path);
    return [[self sharedManager] GET:path parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,error);
    }];
    
}

+(id)POST:(NSString *)path parameters:(NSDictionary *)parames compleHandle:(void (^)(id, NSError *))complete
{
    NSLog(@"%@",path);
    return [[self sharedManager] POST:path parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,error);
    }];
}


@end

