//
//  NewsNetManager.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "BaseNetManager.h"
#import "NewsModel.h"

typedef NS_ENUM(NSUInteger, NewsListType) {
    NewsListTypeZuiXin,  //最新
    NewsListTypeXinWen,     //新闻
    NewsListTypePingCe,     //评测
    NewsListTypeDaoGou,     //导购
    NewsListTypeHangQing,   //行情
    NewsListTypeYongChe,    //用车
    NewsListTypeJiShu,      //技术
    NewsListTypeWenHua,     //文化
    NewsListTypeGaiZhuang,  //改装
    NewsListTypeYouJi,      //游记
};

@interface NewsNetManager : BaseNetManager
//通过type来区分 请求的地址
+ (id)getNewsListType:(NewsListType)type lastTime:(NSString *)time page:(NSInteger)page completionHandle:(void(^)(NewsModel *model, NSError *error))completionHandle;


@end
