//
//  WCThemeConstant.h
//  WeightCare
//
//  Created by KentonYu on 16/7/11.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#ifndef WCThemeConstant_h
#define WCThemeConstant_h

#define BG_COLOR          RGBA(236, 236, 236, 1)
#define BASE_COLOR        RGBA(248, 248, 248, 1)
#define GRAY_COLOR        RGBA(213, 213, 213, 1)
#define LIGHTGRAY_COLOR   RGBA(236, 236, 236, 1)
#define BLUE_COLOR        RGBA(80, 176, 255, 1)
#define DEEPBLUE_COLOR    RGBA(101, 176, 213, 1)
#define RED_COLOR         RGBA(255, 109, 109, 1)
#define YEELOW_COLOR      RGBA(255, 176, 0, 1)
#define GREEN_COLOR       RGBA(10, 230, 163, 1)
#define WHITE_COLOR       RGBA(255, 255, 255, 1)
#define DEEPGRAY_COLOR    RGBA(163, 163, 163, 1)
#define ALERT_TITLE @"Health"
#define ALERT_TIME 1.5
#define NUM_FONT_NAME @"Haettenschweiler"
#define PINGFANG @"HelveticaNeue"

#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define SystemBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])

#endif /* WCThemeConstant_h */
