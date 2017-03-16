//
//  DTMacro.h
//  Pods
//
//  Created by KentonYu on 16/6/28.
//
//

#import "CocoaLumberjack.h"

#ifndef DTMacro_h
#define DTMacro_h

#define SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define SYSTEM_BUILD   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define APP_DISPLAYNAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_VERSION         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define ICON_IMAGE      [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] \
                                 valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] \
                                 lastObject]]

#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a) / 1.0)]
#define RGB(r, g, b) RGBA(r, g , b, 1.0);

#define SCREEN_WIDTH  (( \
    ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \
    ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) \
    ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (( \
    ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \
    ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) \
    ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define STATUS_BAR_HEIGHT 20.f
#define NAVGATIONBAR_HEIGHT 64.f
#define TABBAR_HEIGHT 49.f

#define IS_IPHONE4 (SCREEN_HEIGHT == 480)
#define IS_IPHONE5 (SCREEN_HEIGHT == 568)
#define IS_IPHONE6 (SCREEN_HEIGHT == 667)
#define IS_IPHONE6P (SCREEN_HEIGHT == 960)

// 绘制 1px 线 当线宽为奇数时，绘制位置的偏移量的 x y 分别减去 SINGLE_LINE_ADJUST_OFFSET
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

/*****************  CocoaLumberjack  DDLog   ***************/

#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
static int ddLogLevel = DDLogLevelVerbose;
#pragma clang diagnostic pop
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

/*****************  CocoaLumberjack DDLog ******************/





#endif /* DTMacro_h */
