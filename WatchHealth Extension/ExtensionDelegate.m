//
//  ExtensionDelegate.m
//  WatchHealth Extension
//
//  Created by Friday on 16/7/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    //返回 WCSession 的单例
    WCSession* session = [WCSession defaultSession];
    //设置一个 delegate 并启动
    session.delegate = self;
    [session activateSession];
}
//TODO: WCSessionDelegate  自行修改获取到的数据 ---------------------------
//从后台接收到消息
-(void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
        [[NSUserDefaults standardUserDefaults] setObject:applicationContext forKey:@"HealthyInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];//直接同步到文件里，来避免数据的丢失
}
//从前台接收到消息
-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message {
    [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"HealthyInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-----------------------------------------------------
- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

@end
