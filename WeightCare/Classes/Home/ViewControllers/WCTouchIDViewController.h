//
//  WCTouchIDViewController.h
//  WeightCare
//
//  Created by KentonYu on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCBaseViewController.h"

@interface WCTouchIDViewController : WCBaseViewController

/**
 *  是否是 push 进来的
 */
@property (nonatomic, assign) BOOL push;

/**
 *  是否支持 TouchID
 *
 *  @return BOOL
 */
+ (BOOL)canEvaluatePolicy;
+ (WCTouchIDViewController*)sharedManager;

@end
