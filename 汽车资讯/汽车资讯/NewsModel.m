//
//  NewsModel.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


@end

@implementation NewsResultModel
+ (NSDictionary *)objectClassInArray{
    // key 需要填 属性, 表示某个数组属性中的元素对应的特殊解析类
    return @{@"focusimg":[NewsResultFocusimgModel class], @"anewslist":[NewsResultNewslistModel class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"anewslist": @"newslist"};
}

@end

@implementation NewsResultFocusimgModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id"};
}
@end

@implementation NewsResultHeadlineinfoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id"};
}
@end

@implementation NewsResultNewslistModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id", @"anewstype":@"newstype"};
}
@end

@implementation NewsResultHeadTopnewsinfoModel
@end
