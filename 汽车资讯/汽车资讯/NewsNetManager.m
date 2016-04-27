//
//  NewsNetManager.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "NewsNetManager.h"
@implementation NewsNetManager
+ (id)getNewsListType:(NewsListType)type lastTime:(NSString *)time page:(NSInteger)page completionHandle:(void (^)(NewsModel *, NSError *))completionHandle{

    NSString *path = nil;
    switch (type) {
        case NewsListTypeJiShu:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt102-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeYouJi:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt100-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeDaoGou:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt60-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypePingCe:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt3-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeWenHua:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt97-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeXinWen:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt1-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeZuiXin:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeYongChe:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt82-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeHangQing:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c110100-nt2-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeGaiZhuang:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt107-p%@-s30-l%@.json", @(page), time];
            break;
        default:
            break;
    }
    
    return [self GET:path parameters:nil compleHandle:^(id responseObj, NSError *error) {
        completionHandle([NewsModel mj_objectWithKeyValues:responseObj], error);
    }];
}

@end
