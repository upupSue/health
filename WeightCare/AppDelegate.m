//
//  AppDelegate.m
//  WeightCare
//
//  Created by KentonYu on 16/7/8.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "AppDelegate.h"
#import "WCBaseTabBarController.h"
#import "WCHealthDataManager.h"
#import "WCLocalDBManager.h"
#import "WCTouchIDViewController.h"
#import "WCLogInViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate (){
    BMKMapManager* _mapManager;
}

@property (nonatomic, assign) BOOL canEvaluatePolicy;// 是否支持 TouchID

@end



@implementation AppDelegate

#pragma mark - 程序开始
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*****************  CocoaLumberjack DDLog ******************/
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    /******************  IQKeyboardManager *********************/
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    /********************  本地数据库初始化 ***********************/
     [WCLocalDBManager shareManager];
    // 每次进来都重置数据库
    [[WCLocalDBManager shareManager] updateSqliteFile];
    
    /******************** 是否支持 TouchID **********************/
    
    self.canEvaluatePolicy = [WCTouchIDViewController canEvaluatePolicy];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"X3e3316zl55m353Ukbd4qmxlMc7WaLmV"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    /*********************** 初始化配置 ***************************/
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //登陆一次之后
    if([NSUserDefaults boolValueWithKey:@"isLogIn"]){
        // 支持 TouchID
        if (self.canEvaluatePolicy) {
            WCTouchIDViewController *vc = [WCTouchIDViewController new];
            vc.push = YES;
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            [NSUserDefaults saveValue:@NO forKey:@"TouchIDVerify"];
           
        }
        // 不支持 TouchID，直接进入首页
        else {
            WCBaseTabBarController *vc = [WCBaseTabBarController new];
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
        }
    }
    //未登陆过
    else{
        WCLogInViewController *vc = [[WCLogInViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc]                                         initWithRootViewController:vc];

        [NSUserDefaults saveBoolValue:YES withKey:@"isLogIn"];
    }
    
    //设置系统允许请求通知
    //就是向系统请求可以发送通知
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types==UIUserNotificationTypeNone) {
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];

    }


    //导航栏通用设置
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:BLUE_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init] ];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"WCPSSMarrow-thin-left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, -500) forBarMetrics:UIBarMetricsDefault];
    
    //设置为主窗口并显示出来
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 进入后台时设置为需要 TouchID 验证
    [NSUserDefaults saveValue:@YES forKey:@"TouchIDVerify"];
}

#pragma mark - 程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

#pragma mark - 程序暂行
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

#pragma mark - 程序重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 不支持 TouchID 就不显示 TouchID 验证界面
    if (self.canEvaluatePolicy) {
        if ([[NSUserDefaults valueWithKey:@"TouchIDVerify"] boolValue]) {
            //发送通知将object这个参数设置为了nil，接收一切通知。
            [[NSNotificationCenter defaultCenter] postNotificationName:wcPresentTouchIDViewControllerNotificationName object:nil];
        }
    }
    //使app上icon上的小红点消失
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark - 程序意外暂行
- (void)applicationWillTerminate:(UIApplication *)application {

}



#pragma mark - 百度地图服务授权、网络验证代理方法
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}
#pragma mark - 百度地图返回授权验证错误
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
