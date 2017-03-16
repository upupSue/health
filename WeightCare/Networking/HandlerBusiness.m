//
//  HandlerBusiness.m
//  Orchid
//
//  Created by BG on 16/9/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "HandlerBusiness.h"
#import "YYModel.h"
#import "sys/utsname.h"


static NSString * const BaseRealURLString = @"http://122.226.100.102:8018/dmt/"; //开发地址
static HandlerBusiness *_sharedReal = nil;
static dispatch_once_t onceTokenReal;


//登录注册
NSString *const ApiCodeLogin= @"Login";

//一键上传
NSString *const ApiCodeRecordHealth= @"RecordHealth";

@implementation HandlerBusiness

/**
 *  正式接口
 */
+(void)HealthRealServiceWithApicode:(NSString*)apicode Parameters:(NSDictionary*)parameters Success:(SuccessBlock)success Failed:(FailedBlock)failed Complete:(CompleteBlock)complete;
{
    dispatch_once(&onceTokenReal, ^{
        _sharedReal = [[HandlerBusiness alloc] initWithBaseURL:[NSURL URLWithString:BaseRealURLString]];
        _sharedReal.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedReal.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];

    });
    
    if (parameters==nil) {
        parameters = @{};
    }
    NSMutableDictionary * afterHandleDic = [parameters mutableCopy];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:apicode forKey:@"apicode"];
    [dic setObject:afterHandleDic forKey:@"args"];
    [dic setObject:@"dmt" forKey:@"token"];
    [dic setObject:@"" forKey:@"deviceinfo"];
    [_sharedReal POST:@"api" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(complete != nil){
            complete();
        }
        if([responseObject[@"retcode"] integerValue]==1)
        {
            NSString *modelStr = [HandlerBusiness mapModel][apicode];
            if (modelStr!=nil && ![modelStr isEqualToString:@""]) {
                Class cla = NSClassFromString(modelStr);
                if (!cla) {
                    NSLog(@"找不到对应模型类，%@", modelStr);
                }
                success([cla yy_modelWithJSON:responseObject[@"data"]],responseObject[@"msg"]);
            }
            else{
                success(responseObject[@"data"],responseObject[@"msg"]);
            }
            
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if(complete != nil){
            complete();
        }
        failed([@-9999 integerValue] , @{@"prompt":@"网络错误",@"error":@"网络错误或接口调用失败"});
    }];
}


/**
 *  接口apicode和Model映射关系
 *
 *  @return 映射字典
 */
+(NSDictionary *)mapModel
{
    
    return @{
             ApiCodeLogin : @"",
             ApiCodeRecordHealth : @"",
//             ApiCodeGetBiddingList:@"GetBiddingListModel",

             };
}


+(NSString *)ERRORMSG:(NSInteger)code;
{
    switch (code) {
        case -1:
            return @"系统错误，请稍后重试";
            break;
        case -2:
            return @"网络连接失败，请检查网络";
            break;
        case -3:
            return @"系统错误，请稍后重试";
            break;
        case -4:
            return @"系统错误，请稍后重试";
            break;
        default:
            return @"系统错误，请稍后重试";
            break;
    }
}
@end
