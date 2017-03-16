//
//  WCHomeModel.m
//  WeightCare
//
//  Created by KentonYu on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeModel.h"
#import "WCLocalDBManager.h"
#import "WCHealthDataManager.h"

@implementation WCHomeModel

- (NSArray<NSDictionary *> *)homeSwitchCardDataSource {
    NSArray<NSNumber *> *typeNumber = [[WCLocalDBManager shareManager] searchCardManage];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:typeNumber.count];
    
    [typeNumber enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WCHomeCardManagerEnum cardType = (WCHomeCardManagerEnum)[obj integerValue];
        NSDictionary *dic;
        switch (cardType) {
            case WCHomeCardManagerEnumSport: {
                dic = @{
                        @"cardType":@(cardType)
                        };
                break;
            }
            case WCHomeCardManagerEnumFood: {
                dic = @{
                        @"cardType":@(cardType)
                        };
                break;
            }
            case WCHomeCardManagerEnumWeight: {
                dic = @{
                        @"cardType":@(cardType)
                        };
                break;
            }
            case WCHomeCardManagerEnumAdd: {
                dic = @{
                        @"cardType":@(cardType)
                        };
                break;
            }
        }
        [resultArray addObject:dic];
    }];
    
    // 如果卡片还没有全部显示，则最后加上添加卡片
    if (resultArray.count < 3) {
        [resultArray addObject:@{
                                 @"cardType":@(WCHomeCardManagerEnumAdd)
                                 }];
    }
    
    return [resultArray copy];
}

- (BOOL)validateHomeSwitchCardUsed:(WCHomeCardManagerEnum)type {
    return [[WCLocalDBManager shareManager] validateCardManageUsed:type];
}

- (BOOL)addHomeSwitchCard:(WCHomeCardManagerEnum)type {
    return [[WCLocalDBManager shareManager] addHomeCardManage:type];
}

- (void)queryHeartRateFromHealthKit:(void (^)(NSNumber *))complete {
    // 查询心率

    [[WCHealthDataManager shareManager] queryTodayHeartRate:^(NSNumber *rate, BOOL succeed){
        if(!succeed){
            rate = 0;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete([rate copy]);
            }
        });
    }];
}

- (void)queryTodayStepCountFromHealthKit:(void (^)(NSAttributedString *))complete {
    // 查询步数
    [[WCHealthDataManager shareManager] queryTodayStepCount:^(NSNumber * stepCount, BOOL succeed) {
        NSString *stepCountStr;
        if (succeed) {
            stepCountStr = [NSString stringWithFormat:@"今日步数：%@/步", stepCount];
        } else {
            stepCountStr = @"今日步数：0/步";
        }
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:stepCountStr];
        [attrStr addAttributes:@{
                                 NSForegroundColorAttributeName : RGBA(148, 148, 148, 1),
                                 NSFontAttributeName:[UIFont systemFontOfSize:12]
                                 } range:NSMakeRange(0, attrStr.length)];
        
        [attrStr addAttributes:@{
                                 NSForegroundColorAttributeName : BLUE_COLOR,
                                 NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30]
                                 } range:NSMakeRange(5, attrStr.length - 5 - 2)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete([attrStr copy]);
            }
        });
        
    }];
}

- (void)queryThisWeekStepCountFromHealthKit:(void(^)(NSDictionary *result))complete {
    __block void(^completeBlock)(NSDictionary *result) = complete;
    
    // 当前日期
    NSDate *todayDate = [NSDate date];
    NSString *todayStr = [NSString stringWithFormat:@"%@ 23:59", [todayDate stringWithFormat:@"yyyy/MM/dd"]];
    todayDate = [NSDate dateWithString:todayStr format:@"yyyy/MM/dd HH:mm"];
    
    // 计算七天前的日期
    NSDate *startDate = [[todayDate dateByAddingWeeks:-1] dateByAddingDays:1];
    NSString *startStr = [NSString stringWithFormat:@"%@ 00:00", [startDate stringWithFormat:@"yyyy/MM/dd"]];
    startDate = [NSDate dateWithString:startStr format:@"yyyy/MM/dd HH:mm"];
    
    NSDate *tempDate = startDate;
    NSMutableArray *dateArray = [[NSMutableArray alloc] initWithCapacity:7];
    for (NSInteger i = 7; i > 0; i--) {
        [dateArray addObject:[tempDate stringWithFormat:@"MM/dd"]];
        tempDate = [tempDate dateByAddingDays:1];
    }
    //设置好startDate 和 todayDate 就可以获取IHealth里的数据
    [[WCHealthDataManager shareManager] queryStepCount:startDate endDate:todayDate complete:^(NSArray<NSNumber *> * _Nullable stepCountArray, BOOL succeed) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:2];
        [result setValue:stepCountArray forKey:@"stepCount"];
        [result setValue:[dateArray copy] forKey:@"date"];
        
        
        if (completeBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock([result copy]);
                completeBlock = nil;
            });
        }
        
    }];
}

@end
