//
//  WCHomeSwitchCardFoodCollectionViewCell.m
//  WeightCare
//
//  Created by KentonYu on 16/7/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeSwitchCardFoodCollectionViewCell.h"
#import "VWWWaterView.h"
#import "LocalDBManager.h"
@interface WCHomeSwitchCardFoodCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *totalDayLabel;
@property (weak, nonatomic) IBOutlet UIView *bgCircleView;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong ,nonatomic)NSDictionary *foodDic;
@property (strong ,nonatomic)NSMutableArray *foodArr;



@end

@implementation WCHomeSwitchCardFoodCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setTableViewCellDatasource];
    int takeInCalories = 0;
    if(_foodArr.count!=0){
        for(int i = 0; i<_foodArr.count; i++){
            takeInCalories += [_foodArr[i][@"calorie"] integerValue];
        }
        
        _todayRemainTake = _budgetCalories - takeInCalories + [[NSUserDefaults valueWithKey:@"currentWaste"] integerValue];
    }
    

    
    VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    if(_budgetCalories == 0){
        waterView.hotPresent = 0.6;
    }
    else{
        waterView.hotPresent = (CGFloat)_todayRemainTake/_budgetCalories;
        [NSUserDefaults saveValue:[NSString stringWithFormat:@"%ld",_todayRemainTake/_budgetCalories*100] forKey:@"homeFood"];
    }
    
    self.dateLabel.text = [NSUserDefaults valueWithKey:@"numberOfDay"];
    self.bgCircleView.backgroundColor = [UIColor clearColor];
    [self.bgCircleView addSubview:waterView];
    
    self.bgCircleView.layer.cornerRadius = 65.f;
    self.bgCircleView.layer.masksToBounds = YES;
    self.layer.cornerRadius  = 10.f;
    self.layer.masksToBounds = YES;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"今日还可摄入\n%.1ld\n大卡", (long)_todayRemainTake]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment   = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 8.f;
    [attrStr addAttributes:@{
                             NSForegroundColorAttributeName : [UIColor whiteColor],
                             NSFontAttributeName : [UIFont systemFontOfSize:12.f],
                             NSParagraphStyleAttributeName : paragraphStyle
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f]
                             } range:NSMakeRange(6, attrStr.length - 8)];
    _hotLabel.attributedText = attrStr;
    [self.bgCircleView addSubview:_hotLabel];

    
}

- (void)setTableViewCellDatasource{
    
    NSArray *arryUser = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    if ([arryUser[arryUser.count-1][@"tWeight"]  isEqualToString:@"男"]) {
        _budgetCalories = 67 + 13.73*[arryUser[arryUser.count-1][@"tWeight"] floatValue]+5*[arryUser[arryUser.count-1][@"uHeight"] floatValue] - 6.9*21;
    }
    else{
        _budgetCalories = 661 + 9.6*[arryUser[arryUser.count-1][@"tWeight"] floatValue]+1.72*[arryUser[arryUser.count-1][@"uHeight"] floatValue] - 4.7*21;
    }
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    _foodArr = [[NSMutableArray alloc] init];
    
    NSArray *arry = [[LocalDBManager sharedManager] getEverydayFood:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <arry.count; i++) {
        if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
            
            _foodDic = @{
                         @"calorie":[NSNumber numberWithInteger:[arry[i][@"fAmount"] integerValue]*[arry[i][@"arrFood"][0][@"fIntake"] integerValue]],
                         };
            
            [_foodArr addObject:_foodDic];
        }
    }
}

//- (void)layoutSubviews {
//    

//    CGFloat rate = (self.totalHot - self.takedHot) / self.totalHot;
//    rate = rate < 0 ? 0 : rate ;
//    rate = rate > 1 ? 1 : rate;
//    
//    self.yellowCircleViewTop.constant = rate * self.yellowCircleView.height;
//    [UIView animateWithDuration:1.5f animations:^{
//        [self.yellowCircleView layoutIfNeeded];
//    }];
//    
//    [super layoutSubviews];
//    
//    self.bgCircleView.layer.cornerRadius  = self.bgCircleView.width / 2.0f;
//    self.bgCircleView.layer.masksToBounds = YES;
//    self.bgCircleView.layer.borderWidth = 8.f;
//    self.bgCircleView.layer.borderColor = RGBA(227, 227, 227, 1).CGColor;
//}

@end
