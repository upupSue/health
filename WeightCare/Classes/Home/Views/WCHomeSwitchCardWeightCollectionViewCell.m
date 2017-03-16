//
//  WCHomeSwitchCardWeightCollectionViewCell.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeSwitchCardWeightCollectionViewCell.h"
#import "LocalDBManager.h"

@interface WCHomeSwitchCardWeightCollectionViewCell (){
    NSArray *arry;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *startWeightLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewLeading;

@property (strong ,nonatomic)NSDictionary *weightDic;
@property (strong ,nonatomic)NSMutableArray *weightArr;
@property (strong ,nonatomic)NSMutableArray *dateArr;

@end

@implementation WCHomeSwitchCardWeightCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadData];
    
    self.layer.cornerRadius  = 10.f;
    self.layer.masksToBounds = YES;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@", @([NSDate date].month), @([NSDate date].day)];
}

- (void)loadData{
    //设置Label的参数
    arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    float currectWeight = [[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
    
    self.startWeight = [arry[arry.count-1][@"sWeight"] floatValue];
    self.currentWeight = currectWeight;
    self.targetWeight = [arry[arry.count-1][@"tWeight"] floatValue];
    
    _weightArr = [[NSMutableArray alloc] init];
    _dateArr = [[NSMutableArray alloc] init];
    NSArray *dateArry = [[LocalDBManager sharedManager] getWeight:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <dateArry.count; i++) {
        _weightDic = @{
                       @"date":dateArry[i][@"date"],
                       @"wCurrent":dateArry[i][@"wCurrent"]
                       ,
                       };
        [_weightArr addObject:_weightDic[@"wCurrent"]];
        [_dateArr addObject:_weightDic[@"date"]];
    }
}


- (void)setCurrentWeight:(CGFloat)currentWeight {
    _currentWeight = currentWeight;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f/kg", self.currentWeight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:40.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length - 3)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:18.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(attrStr.length - 3, 3)];
    self.weightLabel.attributedText = attrStr;
}

- (void)setStartWeight:(CGFloat)startWeight {
    _startWeight = startWeight;
}

- (void)setTargetWeight:(CGFloat)targetWeight {
    _targetWeight = targetWeight;
}

- (void)layoutSubviews {

    // 体重差值
    CGFloat a = fabs(self.startWeight - self.targetWeight);
    
    // 减掉的重量所占比例
    CGFloat rate = 0;

    // 当前体重大于初始体重
    if (self.currentWeight > self.startWeight) {
        self.startWeight = self.currentWeight;
    } else if (self.currentWeight < self.targetWeight){
        // 当前体重小于目标体重
        rate = 1;
    } else {
        // 正常范围内
        rate = (self.startWeight - self.currentWeight) / a;
    }
    
    self.redViewLeading.constant = - rate * self.redView.width;
    [UIView animateWithDuration:1.5f animations:^{
        [self.redView layoutIfNeeded];
    }];
    

    NSMutableAttributedString *targetWeightAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"目标体重\n%.1f/kg", _targetWeight]];
    [targetWeightAttrStr addAttributes:@{
                             NSForegroundColorAttributeName : GRAY_COLOR,
                             NSFontAttributeName : [UIFont systemFontOfSize:12]
                             } range:NSMakeRange(0, targetWeightAttrStr.length)];
    [targetWeightAttrStr addAttributes:@{
                             NSForegroundColorAttributeName : RED_COLOR,
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24]
                             } range:NSMakeRange(4, targetWeightAttrStr.length - 7)];
    self.targetWeightLabel.attributedText = targetWeightAttrStr;
    
    NSMutableAttributedString *startWeightAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"初始体重\n%.1f/kg", _startWeight]];
    [startWeightAttrStr addAttributes:@{
                             NSForegroundColorAttributeName : GRAY_COLOR,
                             NSFontAttributeName : [UIFont systemFontOfSize:12]
                             } range:NSMakeRange(0, startWeightAttrStr.length)];
    [startWeightAttrStr addAttributes:@{
                             NSForegroundColorAttributeName : RED_COLOR,
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24]
                             } range:NSMakeRange(4, startWeightAttrStr.length - 7)];
    self.startWeightLabel.attributedText = startWeightAttrStr;

    [super layoutSubviews];
    
    self.grayView.layer.cornerRadius  = self.grayView.height / 2.f;
    self.grayView.layer.masksToBounds = YES;
    self.grayView.layer.borderColor   = RGBA(227, 227, 227, 1).CGColor;
    self.grayView.layer.borderWidth   = 8.f;
    self.redView.layer.cornerRadius   = self.redView.height / 2.f;
    self.redView.layer.masksToBounds  = YES;
}


@end
