//
//  WCHealthDataManager.h
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCHealthDataManager : NSObject

+ (BOOL)isHealthDataAvailable;

+ (instancetype)shareManager;

- (BOOL)registerUseHealthKit;


/**
 *  查询今日步数
 *
 *  @param complete 回调
 */
- (void)queryTodayStepCount:(void (^)(NSNumber * _Nullable stepCount, BOOL succeed))complete;

/**
 *  查询步数
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryStepCount:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> * _Nullable stepCountArray, BOOL succeed))complete;

/**
 *  查询今日心率
 *
 *  @param complete 回调
 */
- (void)queryTodayHeartRate:(void (^)(NSNumber *rate, BOOL succeed))complete;

/**
 *  查询心率
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryHeartRate:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)( NSArray<NSNumber *> * _Nullable  rateArray, BOOL succeed))complete;

/**
 *  查询今日血压
 *
 *  @param complete 回调 systolic:收缩压；diastolic:舒张压
 */
- (void)queryTodayBloodPressure:(void (^)(NSNumber * _Nullable systolic, NSNumber * _Nullable diastolic, BOOL succeed))complete;

/**
 *  查询血压
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryBloodPressure:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> * _Nullable systolicArray, NSArray<NSNumber *> * _Nullable diastolicArray, BOOL succeed))complete;

@end

NS_ASSUME_NONNULL_END
