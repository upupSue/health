//
//  WCHomeSwitchCardSportsCollectionViewCell.m
//  WeightCare
//
//  Created by KentonYu on 16/7/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeSwitchCardSportsCollectionViewCell.h"
#import "VWWaterView.h"
#import "LocalDBManager.h"
@interface WCHomeSwitchCardSportsCollectionViewCell(){
    NSInteger targetWaste;
    int targetPersent;
}
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *persentLabel;

@property (strong ,nonatomic)NSDictionary *sportDic;
@property (strong ,nonatomic)NSMutableArray *sportArr;



@end



@implementation WCHomeSwitchCardSportsCollectionViewCell




- (void)awakeFromNib {
    [super awakeFromNib];
    [self setArray];
    targetPersent = 0;
    for(int i = 0; i<_sportArr.count; i++){
        targetPersent += [_sportArr[i][@"progress"] floatValue]*100;
    }
    if (_sportArr.count == 0) {
        targetPersent = 0;
    }
    else{
        targetPersent = targetPersent/_sportArr.count;
    }
    
    self.dateLabel.text = [NSUserDefaults valueWithKey:@"numberOfDay"];
    self.persentLabel.text = [NSString stringWithFormat:@"%d%%",targetPersent];
    VWWaterView *waterView = [[VWWaterView alloc]initWithFrame:CGRectMake(-2, 10, 140, 140)];
    waterView.sportPersnet = (CGFloat)targetPersent/100;
    [NSUserDefaults saveValue:[NSString stringWithFormat:@"%d",targetPersent] forKey:@"homeSport"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, 10, 140, 140)];
    imageView.image = [UIImage imageNamed:@"sportCardView"];
    [self.circleView addSubview:imageView];
    
    [self.circleView addSubview:waterView];
    
    self.layer.cornerRadius = 10.f;
    self.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setArray{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    _sportArr = [[NSMutableArray alloc] init];
    NSArray *arry = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <arry.count; i++) {
        if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
            
            _sportDic = @{
                          @"progress":[NSNumber numberWithFloat:[arry[i][@"sComplete"] floatValue]/[arry[i][@"sTarget"] floatValue]]
                          ,
                          };
            targetWaste = [arry[i][@"sTarget"] integerValue]*[arry[i][@"arrSport"][0][@"sConsume"] integerValue];

            
            [_sportArr addObject:_sportDic];
        }
    }
}




@end
