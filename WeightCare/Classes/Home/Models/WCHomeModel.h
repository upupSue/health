//
//  WCHomeModel.h
//  WeightCare
//
//  Created by KentonYu on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCHomeModel : NSObject

/**
 *  查询已有的管理卡片的信息
 *
 *  @return keys: cardType
 */
- (NSArray<NSDictionary *> *)homeSwitchCardDataSource;

/**
 *  验证卡片是否已经存在
 *
 *  @param type 卡片类型
 *
 *  @return
 */
- (BOOL)validateHomeSwitchCardUsed:(WCHomeCardManagerEnum)type;

/**
 *  添加管理卡片
 *
 *  @param type 卡片类型
 *
 *  @return
 */
- (BOOL)addHomeSwitchCard:(WCHomeCardManagerEnum)type;

/**
 *  查询今天的步数
 *
 *  @param complete 回调
 */
- (void)queryTodayStepCountFromHealthKit:(void(^)(NSAttributedString *attrStr))complete;

/**
 *  查询一周的步数
 *
 *  @param complete 回调 keys: date 日期数组 ； stepCount 步数数组
 */
- (void)queryThisWeekStepCountFromHealthKit:(void(^)(NSDictionary *result))complete;

/**
 *  查询今天的心率
 *
 *  @param complete 回调
 */
- (void)queryHeartRateFromHealthKit:(void (^)(NSNumber *))complete;


@end
