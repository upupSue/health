//
//  WCHealthDataManager.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDataManager.h"
@import HealthKit;

static WCHealthDataManager *instance;

typedef NS_ENUM(NSUInteger, WCHealthDataManagerBloodPressure) {
    WCHealthDataManagerBloodPressureSystolic,  // 收缩压
    WCHealthDataManagerBloodPressureDiastolic  // 舒张压
};

@interface WCHealthDataManager ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@property (nonatomic, strong) NSDate *now;
@property (nonatomic, strong) NSDate *todayStart;
@property (nonatomic, strong) NSDate *todayEnd;

@end

@implementation WCHealthDataManager

+ (BOOL)isHealthDataAvailable {
    return [HKHealthStore isHealthDataAvailable];
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCHealthDataManager alloc] init];
    });
    return instance;
}

- (BOOL)registerUseHealthKit {
    // 注册使用 HealthKit
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *readDataTypes =  [instance dateTypesToRead];
        NSSet *writeDataTypes = [instance dateTypesToWrite];
        __block BOOL flag;
        [instance.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                flag = YES;
            }
        }];
        return flag;
    }
    return NO;
}


#pragma mark - 步数

/**
 *  查询今日步数
 *
 *  @param complete 回调
 */
- (void)queryTodayStepCount:(void (^)(NSNumber *stepCount, BOOL succeed))complete {
    [self queryStepCount:self.todayStart endDate:self.todayEnd complete:^(NSArray<NSNumber *> *stepCountArray, BOOL succeed) {
        if (!succeed) {
            complete(0, NO);
        } else {
            complete(stepCountArray[0], YES);
        }
    }];
}

/**
 *  查询步数
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryStepCount:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> *stepCountArray, BOOL succeed))complete {
    
    //我们只取了IHealth里的步数 在WCHomeModel里我们调用了两中方法： 取一周步数 和 取一天步数。两种是一样的
    
    //先设定我们要取得数据的类型（因为IHealth里有好多种数据）HKQuantityTypeIdentifierStepCount就是步数类
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //设置起始时间和结束时间，就是方法里的两个入参
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    //然后用 stepType predicate 两个参数取步数
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if (!results || !results.count) {
            complete(nil, NO);
            return;
        }
        
        NSMutableArray *stepCountArray = [[NSMutableArray alloc] initWithCapacity:results.count];
        
        for(HKQuantitySample *stepSample in results) {
            HKQuantity *step = [stepSample quantity];
            [stepCountArray addObject:@([step doubleValueForUnit:[HKUnit countUnit]])];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete([stepCountArray copy], YES);
        });
        
    }];
    
    [instance.healthStore executeQuery:query];
}


#pragma mark - 心率

/**
 *  查询今日心率
 *
 *  @param complete 回调
 */
- (void)queryTodayHeartRate:(void (^)(NSNumber *rate, BOOL succeed))complete {
    [self queryHeartRate:self.todayStart endDate:self.todayEnd complete:^(NSArray<NSNumber *> *rateArray, BOOL succeed) {
        if(rateArray.count != 0){
            if (succeed) {
                complete(rateArray[0], succeed);
            } else {
                complete(@0, succeed);
            }

        }
    }];
}

/**
 *  查询心率
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryHeartRate:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> *rateArray, BOOL succeed))complete {
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:type predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if (!results) {
            complete(nil, NO);
            return;
        }
        
        NSMutableArray<NSNumber *> *rateArray = [[NSMutableArray alloc] initWithCapacity:results.count];
        
        for(HKQuantitySample *sample in results) {
            
            HKQuantity *item = [sample quantity];
            HKUnit *countPerSec = [HKUnit unitFromString:[NSString stringWithFormat:@"count/s"]];
            [rateArray addObject:@([item doubleValueForUnit:countPerSec])];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete([rateArray copy], YES);
        });
    }];
    
    [instance.healthStore executeQuery:query];
}


#pragma mark - 血压

/**
 *  查询今日血压
 *
 *  @param complete 回调 systolic:收缩压；diastolic:舒张压
 */
- (void)queryTodayBloodPressure:(void (^)(NSNumber *systolic, NSNumber *diastolic, BOOL succeed))complete {
    [self queryBloodPressure:self.todayStart endDate:self.todayEnd complete:^(NSArray<NSNumber *> *systolicArray, NSArray<NSNumber *> *diastolicArray, BOOL succeed) {
        if (succeed) {
            complete(systolicArray[0], diastolicArray[0], succeed);
        } else {
            complete(nil, nil, succeed);
        }
        
        
    }];
}

/**
 *  查询血压
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  回调
 */
- (void)queryBloodPressure:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> *systolicArray, NSArray<NSNumber *> *diastolicArray, BOOL succeed))complete {
  
    // 查询收缩压
    [self querySystolicBloodPressure:startDate endDate:endDate complete:^(NSArray<NSNumber *> *systolicArray, BOOL succeed) {
        
        if (!succeed) {
            complete(nil, nil, NO);
            return ;
        }
        // 查询舒张压
        [self querySystolicBloodPressure:startDate endDate:endDate complete:^(NSArray<NSNumber *> *diastolicArray, BOOL succeed) {
            if (!succeed) {
                complete(nil, nil, NO);
                return ;
            }
            
            complete(systolicArray, diastolicArray, YES);
            
        } type:WCHealthDataManagerBloodPressureDiastolic];
        
    } type:WCHealthDataManagerBloodPressureSystolic];
    
}


#pragma mark - Pravite

/**
 *  读取Health数据
 *
 *  @return
 */
- (NSSet *)dateTypesToRead {
    
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:stepType, distanceType, nil];
    
}

/**
 *  写Health数据
 *
 *  @return
 */
- (NSSet *)dateTypesToWrite {
    
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:stepType, distanceType, nil];
}

- (void)querySystolicBloodPressure:(NSDate *)startDate endDate:(NSDate *)endDate complete:(void (^)(NSArray<NSNumber *> *array, BOOL succeed)) complete type:(WCHealthDataManagerBloodPressure) type {
    
    HKQuantityType *quantityType;
    switch (type) {
        case WCHealthDataManagerBloodPressureSystolic: {
            quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
            break;
        }
        case WCHealthDataManagerBloodPressureDiastolic: {
            quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
            break;
        }
    }
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
       
        if (!results) {
            complete(nil, NO);
            return ;
        }
        
        NSMutableArray<NSNumber *> *array  = [NSMutableArray new];
        for(HKQuantitySample *sample in results) {
            HKQuantity *item = [sample quantity];
            [array addObject:@([item doubleValueForUnit:[HKUnit countUnit]])];
        }
        
        complete([array copy], YES);
    }];
    
    [instance.healthStore executeQuery:query];
}


#pragma mark - Getter

- (HKHealthStore *)healthStore {
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}

- (NSDate *)now {
    _now = [NSDate date];
    return _now;
}

- (NSDate *)todayStart {
    _todayStart = [NSDate dateWithString:[NSString stringWithFormat:@"%ld/%ld/%ld 00:01", (long)self.now.year, (long)self.now.month, (long)self.now.day] format:@"yyyy/MM/dd HH:mm"];
    return _todayStart;
}

- (NSDate *)todayEnd {
    _todayEnd = [NSDate dateWithString:[NSString stringWithFormat:@"%ld/%ld/%ld 23:59", (long)self.now.year, (long)self.now.month, (long)self.now.day] format:@"yyyy/MM/dd HH:mm"];
    return _todayEnd;
}


@end
