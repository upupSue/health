//
//  LocalDBManager.h
//
//  Created by BG on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDBManager : NSObject

+ (instancetype)sharedManager;

-(NSArray *)readUserIfo:(NSString *)userNo;
- (BOOL)setUserName:(NSString *)name userId:(NSString *)uno;
- (BOOL)setUserSex:(BOOL)sex userId:(NSString *)uno;
- (BOOL)setUserBirth:(NSString *)birth userId:(NSString *)uno;
- (BOOL)setUserHeight:(NSString *)height userId:(NSString *)uno;
- (BOOL)setUserStartWeight:(NSString *)sWeight userId:(NSString *)uno;
- (BOOL)setUserTargetWeight:(NSString *)tWeight userId:(NSString *)uno;

-(NSArray *)readUserid:(NSString *)userNo;
- (BOOL)setUserEmail:(NSString *)Email userId:(NSString *)uno;
- (BOOL)setUserPhone:(NSString *)Phone userId:(NSString *)uno;


-(NSArray *)getWeight:(NSString *)userNo;
- (BOOL)insertUserWeight:(float)weight date:(NSString *)date userId:(int)uno;

- (NSArray *)getEverydaySport:(NSString *)userNo;
- (BOOL)insertTodaySport:(int)sNo date:(NSString *)date sTarget:(float)sTarget sComplete:(float)sComplete userId:(int)uNo;
- (BOOL)updateTodaySport:(int)sNo sTarget:(float)sTarget sComplete:(float)sComplete colomn:(int)scNo;
- (BOOL)deleteTodaySport:(int)scNo;
- (BOOL)deleteSports:(NSString *)date;

-(NSArray *)getEverydayFood:(NSString *)userNo;
- (BOOL)insertTodayFood:(int)fNo date:(NSString *)date time:(int)time fAmount:(float)fAmount userId:(int)uNo;
- (BOOL)updateTodayFood:(int)fNo time:(int)time fAmount:(float)fAmount colomn:(int)fcNo;
- (BOOL)deleteTodayFood:(int)fcNo;
- (BOOL)deleteFoods:(NSString *)date;

-(NSArray *)readSportPlan;
-(NSArray *)readFoodPlan;

-(NSArray *)readProductType:(NSString *)userNo;
-(NSArray *)readProductDetail:(int)pNo;
- (BOOL)insertCart:(int)pNo pType:(int)pType pNum:(int)pNum userId:(int)uNo;

@end
