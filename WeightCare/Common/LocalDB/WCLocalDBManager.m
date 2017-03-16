//
//  LocalDBManager.h
//  WeightCare
//
//  Created by KentonYu on 16/03/11.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCLocalDBManager.h"
#import "FMDatabase.h"
#import "YYModel.h"

static NSString *const WCSQLDBName = @"WeightCare.db";

static FMDatabase *db;
static WCLocalDBManager *instance;

@implementation WCLocalDBManager

+ (instancetype)shareManager {
    return [[self alloc] init];
}

/**
 *  单例
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        [instance p_copyDBFromBundle:NO];
    });
    return instance;
}

/**
 *  删除旧数据库，创建新的数据库
 */
- (BOOL)updateSqliteFile {
    return [instance p_copyDBFromBundle:YES];
}


#pragma mark - Business

- (BOOL)addHomeCardManage:(WCHomeCardManagerEnum)type {
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE tbHomeCardManage SET homeCardManagerEnable=%@ WHERE homeCardManagerType=%@",@(YES), @(type)];
    BOOL flag = [db executeUpdate:updateSql];
    [db close];
    return flag;
}

- (BOOL)deleteHomeCardManage:(WCHomeCardManagerEnum)type {
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE tbHomeCardManage SET homeCardManagerEnable=%@ WHERE homeCardManagerType=%@",@(NO), @(type)];
    BOOL flag = [db executeUpdate:updateSql];
    [db close];
    return flag;
}

- (NSArray<NSNumber *> *)searchCardManage {
    if (![db open]) {
        return nil;
    }
    
    NSString *selectSql = [NSString stringWithFormat:@"SELECT homeCardManagerType FROM tbHomeCardManage WHERE homeCardManagerEnable=%@", @(YES)];
    FMResultSet *result = [db executeQuery:selectSql];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([result next]) {
        [array addObject:@([result intForColumn:@"homeCardManagerType"])];
    }
    
    [db close];
    
    if (!array.count) {
        return nil;
    }
    return array;
}

- (BOOL)validateCardManageUsed:(WCHomeCardManagerEnum)type {
    if (![db open]) {
        return NO;
    }
    
    NSString *selectSql = [NSString stringWithFormat:@"SELECT homeCardManagerEnable FROM tbHomeCardManage WHERE homeCardManagerType=%@", @(type)];
    
    FMResultSet *set = [db executeQuery:selectSql];
    
    __block BOOL result = NO;
    while ([set next]) {
        result = [set boolForColumn:@"homeCardManagerEnable"];
    }
    
    return result;
}


#pragma mark Pravite

/**
 *  从 Bundle 中复制数据库
 *
 *  @param cover 是否覆盖
 *
 *  @return 结果
 */
- (BOOL)p_copyDBFromBundle:(BOOL)cover {
    NSString* dbBundlePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:WCSQLDBName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbDocPath = [documentDirectory stringByAppendingPathComponent:WCSQLDBName];
    DDLogDebug(@"%@",dbDocPath);
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error;
    // 数据库已存在
    if ([manager fileExistsAtPath:dbDocPath]) {
        if (!cover) {
            return YES;
        }
        if (![manager removeItemAtPath:dbDocPath error:&error]) {
            DDLogDebug(@"Unable to delete file: %@", [error localizedDescription]);
            return NO;
        }
    }
    // 复制数据库
    if ([manager copyItemAtPath:dbBundlePath toPath:dbDocPath error:nil]) {
        DDLogDebug(@"db copy ok...");
        db = [FMDatabase databaseWithPath:dbDocPath];
        return YES;
    } else {
        DDLogDebug(@"db copy error...");
        db = nil;
        return NO;
    }
}

@end
