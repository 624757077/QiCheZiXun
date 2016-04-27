//
//  NSObject+Common.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

//显示失败提示
- (void)showErrorMsg:(NSString *)msg;

//显示成功提示
- (void)showSuccessMsg:(NSString *)msg;

//显示忙
- (void)showProgress;

//隐藏提示
- (void)hideProgress;

@end
