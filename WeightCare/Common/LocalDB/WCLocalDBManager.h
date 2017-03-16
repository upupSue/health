//
//  LocalDBManager.h
//  WeightCare
//
//  Created by KentonYu on 16/03/11.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLocalDBManager : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)shareManager;

/**
 *  重置数据库
 */
- (BOOL)updateSqliteFile;

/**
 *  添加首页卡片管理
 *
 *  @param type 管理类型
 *
 *  @return 添加结果
 */
- (BOOL)addHomeCardManage:(WCHomeCardManagerEnum)type;

/**
 *  删除首页卡片
 *
 *  @param type 管理类型
 *
 *  @return 删除结果
 */
- (BOOL)deleteHomeCardManage:(WCHomeCardManagerEnum)type;

/**
 *  查询首页已有卡片
 *
 *  @return 卡片类型数组（WCHomeCardManagerEnum）
 */
- (NSArray<NSNumber *> * _Nullable)searchCardManage;

/**
 *  验证卡片是否已经显示
 *
 *  @param type 卡片类型
 *
 *  @return
 */
- (BOOL)validateCardManageUsed:(WCHomeCardManagerEnum)type;



NS_ASSUME_NONNULL_END

@end
