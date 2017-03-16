//
//  WCHomeCardFoodSubViewController.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeCardFoodSubViewController : UIViewController

//今日还可摄入卡路里
@property (nonatomic, assign)NSInteger todayRemainTake;
//天数
@property (nonatomic, assign)int dates;
//预算卡路里
@property (nonatomic, assign)NSInteger budgetCalories;
//摄入卡路里
@property (nonatomic, assign)NSInteger takeInCalories;
//消耗卡路里
@property (nonatomic, assign)NSInteger wasteCalories;

@end
