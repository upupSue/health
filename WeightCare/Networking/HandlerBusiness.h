//
//  HandlerBusiness.h
//  Orchid
//
//  Created by BG on 16/9/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


extern NSString *const ApiCodePostBiddingInfo;

extern NSString *const ApiCodeLogin;

extern NSString *const ApiCodeRecordHealth;

@interface HandlerBusiness : AFHTTPSessionManager
/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)();

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id data , id msg);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(NSInteger code ,id errorMsg);

/**
 *  正式接口
 */
+(void)HealthRealServiceWithApicode:(NSString*)apicode Parameters:(NSDictionary*)parameters Success:(SuccessBlock)success Failed:(FailedBlock)failed Complete:(CompleteBlock)complete;



+(NSString *)ERRORMSG:(NSInteger)code;
@end
