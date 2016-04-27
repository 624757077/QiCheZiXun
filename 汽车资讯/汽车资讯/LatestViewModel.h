//
//  LatestViewModel.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsNetManager.h"

@interface LatestViewModel : BaseViewModel

- (id)initWithNewsListType:(NewsListType)type;
@property(nonatomic) NewsListType type;

@property(nonatomic) NSInteger rowNumber;
//分页加载
@property(nonatomic,strong) NSMutableArray *dataArr;
//头部滚动栏，图片数组
@property(nonatomic,strong) NSArray *headImageURLs;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;
- (NSString *)commentNumberForRow:(NSInteger)row;
- (NSNumber *)IDForRow:(NSInteger)row;

@property(nonatomic,strong) NSString *updateTime;
@property(nonatomic) NSInteger page;

//刷新
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
//加载更多
- (void)getMoreDataCompleteHandle:(void(^)(NSError *error))complete;

@end