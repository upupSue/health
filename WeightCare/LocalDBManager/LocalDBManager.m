//
//  LocalDBManager.m
//
//  Created by BG on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "LocalDBManager.h"
#import "FMDatabase.h"

@implementation LocalDBManager

static LocalDBManager* localDBManager = nil;
static FMDatabase * db;

+(LocalDBManager*)sharedManager
{
    if (localDBManager == nil) {
        localDBManager = [[LocalDBManager alloc] init];
        
        NSString* dbBundlePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"health.sqlite" ];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbDocPath = [documentDirectory stringByAppendingPathComponent:@"health.sqlite"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        //如果Documents数据库文件初始不存在，则需要从Bundle里copy一份
        //Bundle数据库是只读的，而Documents下是可读写的
        if (![manager fileExistsAtPath:dbDocPath]) {
            if ([manager copyItemAtPath:dbBundlePath toPath:dbDocPath error:nil]) {
                NSLog(@"db copy ok...");
            }
            else
            {
                NSLog(@"db copy error...");
            }
        }
        db = [FMDatabase databaseWithPath:dbDocPath] ;
        
    }
    return localDBManager;
}





//个人信息的读取与更改
-(NSArray *)readUserIfo:(NSString *)userNo{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from User where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * uNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"uNo"]];
            NSString * uName = [rs stringForColumn:@"uName"];
            NSString * uImg = [rs stringForColumn:@"uImg"];
            NSString * uSix = [NSString stringWithFormat:@"%d",[rs intForColumn:@"uSix"]];
            NSString * uDate = [rs stringForColumn:@"uDate"];
            NSString * uHeight = [NSString stringWithFormat:@"%.1f",[rs doubleForColumn:@"uHeight"]];
            NSString * tWeight = [NSString stringWithFormat:@"%.1f",[rs doubleForColumn:@"tWeight"]];
            NSString * sWeight = [NSString stringWithFormat:@"%.1f",[rs doubleForColumn:@"sWeight"]];
            NSString * uWaistline = [NSString stringWithFormat:@"%.1f",[rs doubleForColumn:@"uWaistline"]];

            NSDictionary *dic = @{
                                  @"uNo" : uNo,
                                  @"uName" : uName,
                                  @"uImg" : uImg,
                                  @"uSix": uSix,
                                  @"uDate":uDate,
                                  @"uHeight" : uHeight,
                                  @"tWeight": tWeight,
                                  @"sWeight":sWeight,
                                  @"uWaistline":uWaistline,
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}
- (BOOL)setUserName:(NSString *)name userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET uName=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,name,uno];
    [db close];
    return flag;
}
- (BOOL)setUserSex:(BOOL)sex userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET uSix=%d WHERE uNo=?",sex];
    BOOL flag = [db executeUpdate:updateSql,uno];
    [db close];
    return flag;
}
- (BOOL)setUserBirth:(NSString *)birth userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET uDate=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,birth,uno];
    [db close];
    return flag;
}
- (BOOL)setUserHeight:(NSString *)height userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET uHeight=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,height,uno];
    [db close];
    return flag;
}
- (BOOL)setUserStartWeight:(NSString *)sWeight userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET sWeight=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,sWeight,uno];
    [db close];
    return flag;
}
- (BOOL)setUserTargetWeight:(NSString *)tWeight userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE User SET tWeight=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,tWeight,uno];
    [db close];
    return flag;
}






//个人邮箱手机等信息的读取与更改
-(NSArray *)readUserid:(NSString *)userNo{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from Userid where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * uNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"uNo"]];
            NSString * uPassword = [rs stringForColumn:@"uPassword"];
            NSString * uEmail = [rs stringForColumn:@"uEmail"];
            NSString * uPhone = [rs stringForColumn:@"uPhone"];
            
            NSDictionary *dic = @{
                                  @"uNo" : uNo,
                                  @"uPassword" : uPassword,
                                  @"uEmail" : uEmail,
                                  @"uPhone": uPhone
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}
- (BOOL)setUserEmail:(NSString *)Email userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE Userid SET uEmail=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,Email,uno];
    [db close];
    return flag;
}
- (BOOL)setUserPhone:(NSString *)Phone userId:(NSString *)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE Userid SET uPhone=? WHERE uNo=?"];
    BOOL flag = [db executeUpdate:updateSql,Phone,uno];
    [db close];
    return flag;
}




//体重信息获取与添加
-(NSArray *)getWeight:(NSString *)userNo{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from Weight where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * uNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"uNo"]];
            NSString * date = [rs stringForColumn:@"date"];
            NSString * wCurrent = [rs stringForColumn:@"wCurrent"];
            
            NSDictionary *dic = @{
                                  @"uNo" : uNo,
                                  @"date" : date,
                                  @"wCurrent" : wCurrent
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}
- (BOOL)insertUserWeight:(float)weight date:(NSString *)date userId:(int)uno{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"insert into Weight(date,wCurrent,uNo) values('%@',%.1f,%d)",date,weight,uno];
    BOOL flag = [db executeUpdate:updateSql];
    [db close];
    return flag;
}





//运动的读取更新插入和删除
- (NSArray *)getEverydaySport:(NSString *)userNo{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from SComplete where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * scNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"scNo"]];
            NSString * date = [rs stringForColumn:@"date"];
            NSString * sNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sNo"]];
            NSString * sTarget = [NSString stringWithFormat:@"%.f",[rs doubleForColumn:@"sTarget"]];
            NSString * sComplete = [NSString stringWithFormat:@"%.f",[rs doubleForColumn:@"sComplete"]];
            
            //获取对应运动信息
            NSString * sqlSport =[NSString stringWithFormat:@"select * from Sports where sNo = %@",sNo];
            FMResultSet * rsSport = [db executeQuery:sqlSport];
            NSMutableArray *arrSport = [NSMutableArray array];
            while ([rsSport next]) {
                NSString * sName = [rsSport stringForColumn:@"sName"];
                NSString * sConsume = [rsSport stringForColumn:@"sConsume"];
                NSString * sImg = [rsSport stringForColumn:@"sImg"];
                NSString * sUnit = [rsSport stringForColumn:@"sUnit"];
                [arrSport addObject:@{@"sName" : sName,
                                      @"sConsume" : sConsume,
                                      @"sImg" : sImg,
                                      @"sUnit" : sUnit
                                     }];
            }

            NSDictionary *dic = @{
                                  @"scNo" : scNo,
                                  @"date" : date,
                                  @"sNo" : sNo,
                                  @"sTarget" : sTarget,
                                  @"sComplete" : sComplete,
                                  @"arrSport" : arrSport
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}
- (BOOL)insertTodaySport:(int)sNo date:(NSString *)date sTarget:(float)sTarget sComplete:(float)sComplete userId:(int)uNo{
    if (![db open]) {
        return NO;
    }
    NSString *insertSql = [NSString stringWithFormat:@"insert into SComplete(date,sTarget,sComplete,sNo,uNo) values('%@',%.1f,%.1f,%d,%d)",date,sTarget,sComplete,sNo,uNo];
    BOOL flag = [db executeUpdate:insertSql];
    [db close];
    return flag;
}
- (BOOL)updateTodaySport:(int)sNo sTarget:(float)sTarget sComplete:(float)sComplete colomn:(int)scNo{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE SComplete SET sNo=%d,sTarget=%.1f,sComplete=%.1f WHERE scNo=%d",sNo,sTarget,sComplete,scNo];
    BOOL flag = [db executeUpdate:updateSql];
    [db close];
    return flag;
}
- (BOOL)deleteTodaySport:(int)scNo{
    if (![db open]) {
        return NO;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"delete from SComplete where scNo = %d",scNo];
    BOOL flag = [db executeUpdate:deleteSql];
    [db close];
    return flag;
}
- (BOOL)deleteSports:(NSString *)date{
    if (![db open]) {
        return NO;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"delete from SComplete where date = '%@'",date];
    BOOL flag = [db executeUpdate:deleteSql];
    [db close];
    return flag;
}



//食物的读取更新插入和删除
-(NSArray *)getEverydayFood:(NSString *)userNo {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from FAmount where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * fcNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"fcNo"]];
            NSString * date = [rs stringForColumn:@"date"];
            NSString * time = [NSString stringWithFormat:@"%d",[rs intForColumn:@"time"]];
            NSString * fNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"fNo"]];
            NSString * fAmount = [NSString stringWithFormat:@"%.f",[rs doubleForColumn:@"fAmount"]];
        
            //获取对应运动信息
            NSString * sqlFood =[NSString stringWithFormat:@"select * from Foods where fNo = %@",fNo];
            FMResultSet * rsFood = [db executeQuery:sqlFood];
            NSMutableArray *arrFood = [NSMutableArray array];
            while ([rsFood next]) {
                NSString * fNo = [NSString stringWithFormat:@"%d",[rsFood intForColumn:@"fNo"]];
                NSString * fName = [rsFood stringForColumn:@"fName"];
                NSString * fIntake = [NSString stringWithFormat:@"%.2f",[rsFood doubleForColumn:@"fIntake"]];
                NSString * fImg = [rsFood stringForColumn:@"fImg"];
                NSString * fUnit = [rsFood stringForColumn:@"fUnit"];
                [arrFood addObject:@{
                                     @"fNo" : fNo,
                                     @"fName" : fName,
                                     @"fIntake" : fIntake,
                                     @"fImg": fImg,
                                     @"fUnit":fUnit,
                                      }];
            }
            
            NSDictionary *dic = @{
                                  @"fcNo" : fcNo,
                                  @"date" : date,
                                  @"time" : time,
                                  @"fNo" : fNo,
                                  @"fAmount" : fAmount,
                                  @"arrFood" : arrFood
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}
- (BOOL)insertTodayFood:(int)fNo date:(NSString *)date time:(int)time fAmount:(float)fAmount userId:(int)uNo{
    if (![db open]) {
        return NO;
    }
    NSString *insertSql = [NSString stringWithFormat:@"insert into FAmount(date,time,fNo,fAmount,uNo) values('%@',%d,%d,%.1f,%d)",date,time,fNo,fAmount,uNo];
    BOOL flag = [db executeUpdate:insertSql];
    [db close];
    return flag;
}
- (BOOL)updateTodayFood:(int)fNo time:(int)time fAmount:(float)fAmount colomn:(int)fcNo{
    if (![db open]) {
        return NO;
    }
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE FAmount SET fNo=%d,time=%d,fAmount=%.1f WHERE fcNo=%d",fNo,time,fAmount,fcNo];
    BOOL flag = [db executeUpdate:updateSql];
    [db close];
    return flag;
}
- (BOOL)deleteTodayFood:(int)fcNo{
    if (![db open]) {
        return NO;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"delete from FAmount where fcNo = %d",fcNo];
    BOOL flag = [db executeUpdate:deleteSql];
    [db close];
    return flag;
}
- (BOOL)deleteFoods:(NSString *)date{
    if (![db open]) {
        return NO;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"delete from FAmount where date = '%@'",date];
    BOOL flag = [db executeUpdate:deleteSql];
    [db close];
    return flag;
}



//运动方案
-(NSArray *)readSportPlan{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from Splan"];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * sNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sNo"]];
            NSString * sTarget = [NSString stringWithFormat:@"%.1f",[rs doubleForColumn:@"sTarget"]];
            //获取对应运动信息
            NSString * sqlSport =[NSString stringWithFormat:@"select * from Sports where sNo = %@",sNo];
            FMResultSet * rsSport = [db executeQuery:sqlSport];
            NSMutableArray *arrSport = [NSMutableArray array];
            while ([rsSport next]) {
                NSString * sName = [rsSport stringForColumn:@"sName"];
                NSString * sConsume = [rsSport stringForColumn:@"sConsume"];
                NSString * pImg = [rsSport stringForColumn:@"pImg"];
                NSString * sUnit = [rsSport stringForColumn:@"sUnit"];
                [arrSport addObject:@{@"sName" : sName,
                                      @"sConsume" : sConsume,
                                      @"pImg" : pImg,
                                      @"sUnit" : sUnit
                                      }];
            }
            NSDictionary *dic = @{
                                  @"sNo" : sNo,
                                  @"sTarget" : sTarget,
                                  @"arrSport" : arrSport
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}




//饮食方案
-(NSArray *)readFoodPlan{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from Fplan"];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * time = [NSString stringWithFormat:@"%d",[rs intForColumn:@"time"]];
            NSString * fNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"fNo"]];
            NSString * fAmount = [NSString stringWithFormat:@"%.f",[rs doubleForColumn:@"fAmount"]];
            //获取对应运动信息
            NSString * sqlFood =[NSString stringWithFormat:@"select * from Foods where fNo = %@",fNo];
            FMResultSet * rsFood = [db executeQuery:sqlFood];
            NSMutableArray *arrFood = [NSMutableArray array];
            while ([rsFood next]) {
                NSString * fNo = [NSString stringWithFormat:@"%d",[rsFood intForColumn:@"fNo"]];
                NSString * fName = [rsFood stringForColumn:@"fName"];
                NSString * fIntake = [NSString stringWithFormat:@"%.2f",[rsFood doubleForColumn:@"fIntake"]];
                NSString * fImg = [rsFood stringForColumn:@"fImg"];
                NSString * fUnit = [rsFood stringForColumn:@"fUnit"];
                [arrFood addObject:@{
                                     @"fNo" : fNo,
                                     @"fName" : fName,
                                     @"fIntake" : fIntake,
                                     @"fImg": fImg,
                                     @"fUnit":fUnit,
                                     }];
            }
            NSDictionary *dic = @{
                                  @"time" : time,
                                  @"fNo" : fNo,
                                  @"fAmount" : fAmount,
                                  @"arrFood" : arrFood
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}

//商品列表
-(NSArray *)readProductType:(NSString *)userNo {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from PType where uNo = %@",userNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * pcNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pcNo"]];
            NSString * pType = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pType"]];
            NSString * pNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pNo"]];
            NSString * pNum = [NSString stringWithFormat:@"%.f",[rs doubleForColumn:@"pNum"]];
            //获取对应运动信息
            NSString * sqlPrd =[NSString stringWithFormat:@"select * from Product where pNo = %@",pNo];
            FMResultSet * rsPrd = [db executeQuery:sqlPrd];
            NSMutableArray *arrPrd = [NSMutableArray array];
            while ([rsPrd next]) {
                NSString * pName = [rsPrd stringForColumn:@"pName"];
                NSString * pPrice = [rsPrd stringForColumn:@"pPrice"];
                NSString * ppPrice = [rsPrd stringForColumn:@"ppPrice"];
                NSString * pLevelImg = [rsPrd stringForColumn:@"pLevelImg"];
                NSString * pPost = [rsPrd stringForColumn:@"pPost"];
                NSString * pAddress = [rsPrd stringForColumn:@"pAddress"];
                NSString * pMonthSell = [rsPrd stringForColumn:@"pMonthSell"];
                NSString * pDetailImg = [rsPrd stringForColumn:@"pDetailImg"];
                NSString * pHeadImg = [rsPrd stringForColumn:@"pHeadImg"];
                [arrPrd addObject:@{
                                     @"pName" : pName,
                                     @"pPrice" : pPrice,
                                     @"ppPrice" : ppPrice,
                                     @"pLevelImg": pLevelImg,
                                     @"pPost":pPost,
                                     @"pAddress" : pAddress,
                                     @"pMonthSell" : pMonthSell,
                                     @"pDetailImg": pDetailImg,
                                     @"pHeadImg":pHeadImg,
                                     }];
            }
            NSDictionary *dic = @{
                                  @"pcNo" : pcNo,
                                  @"pType" : pType,
                                  @"pNo" : pNo,
                                  @"pNum" : pNum,
                                  @"arrPrd" : arrPrd
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}

//商品详情
-(NSArray *)readProductDetail:(int)pNo {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([db open]) {
        NSString * sql =[NSString stringWithFormat:@"select * from Product where pNo = %d",pNo];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * pName = [rs stringForColumn:@"pName"];
            NSString * pPrice = [rs stringForColumn:@"pPrice"];
            NSString * ppPrice = [rs stringForColumn:@"ppPrice"];
            NSString * pLevelImg = [rs stringForColumn:@"pLevelImg"];
            NSString * pPost = [rs stringForColumn:@"pPost"];
            NSString * pAddress = [rs stringForColumn:@"pAddress"];
            NSString * pMonthSell = [rs stringForColumn:@"pMonthSell"];
            NSString * pDetailImg = [rs stringForColumn:@"pDetailImg"];
            NSString * pHeadImg = [rs stringForColumn:@"pHeadImg"];
            NSString * pNo = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pNo"]];

            NSDictionary *dic = @{
                                  @"pName" : pName,
                                  @"pPrice" : pPrice,
                                  @"ppPrice" : ppPrice,
                                  @"pLevelImg": pLevelImg,
                                  @"pPost":pPost,
                                  @"pAddress" : pAddress,
                                  @"pMonthSell" : pMonthSell,
                                  @"pDetailImg": pDetailImg,
                                  @"pHeadImg":pHeadImg,
                                  @"pNo":pNo,
                                  };
            [arr addObject:dic];
        }
        [db close];
        return arr;
    }
    return nil;
}

//加入购物车
- (BOOL)insertCart:(int)pNo pType:(int)pType pNum:(int)pNum userId:(int)uNo{
    if (![db open]) {
        return NO;
    }
    NSString *insertSql = [NSString stringWithFormat:@"insert into PType(pType,pNo,pNum,uNo) values(%d,%d,%d,%d)",pType,pNo,pNum,uNo];
    BOOL flag = [db executeUpdate:insertSql];
    [db close];
    return flag;
}

@end
