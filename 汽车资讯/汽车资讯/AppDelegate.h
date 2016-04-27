//
//  AppDelegate.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/22.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态

@end

