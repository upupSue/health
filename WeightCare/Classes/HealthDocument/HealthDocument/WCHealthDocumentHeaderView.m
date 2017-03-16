//
//  WCHealthDocumentHeaderView.m
//  WeightCare
//
//  Created by BG on 16/9/4.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDocumentHeaderView.h"

@implementation WCHealthDocumentHeaderView

-(void)setCellsFrameWeight:(float)weight WeightExpect:(float)weightExpect WeightPast:(float)weightPast{
    _whiteContentView.layer.cornerRadius=10;

    _GrayWeightView.layer.cornerRadius=17;
    _blueWeightView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, (SCREEN_WIDTH-46)*(weight-weightExpect)/(weightPast-weightExpect), 28)];
    _blueWeightView.layer.cornerRadius=14;
    [_blueWeightView setBackgroundColor:BLUE_COLOR];
    [self.GrayWeightView addSubview:_blueWeightView];
}

- (void)setNumberOfBMILabel:(NSString *)numberOfBMILabel SetNumberOfTZLabel:(NSString *)numberOfTZLabel SetFitnessSituationLabel:(NSString *)fitnessSituationLabel SetLevelOfTZ:(NSString *)levelOfTZ SetDate:(NSString *)date SetsetLabel:(NSString *)setLabel SetWeightExcept:(NSString *)weightExcept SetWeightPast:(NSString *)weightPast SetWeight:(NSString *)weight{
    
    _numberOfBMILabel.text = numberOfBMILabel;
    _numberOfTZLabel.text = numberOfTZLabel;
    _fitnessSituationLabel.text = fitnessSituationLabel;
    _levelOfTZ.text = levelOfTZ;
    
    _weightExcept.text = weightExcept;
    _weightPast.text = weightPast;
    _date.text = [NSString stringWithFormat:@"I 第%@天 I",date];

    NSString *weightKg=[NSString stringWithFormat:@"%@/kg",weight];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:weightKg];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,weight.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(weight.length,3)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Haettenschweiler" size:30] range:NSMakeRange(0,weight.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang SC" size:12] range:NSMakeRange(weight.length,3)];
    _weight=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 34)];
    _weight.attributedText = str2;
    _weight.textAlignment = NSTextAlignmentCenter;
    [self.GrayWeightView addSubview:_weight];
}

-(void)setNumberOfBMILabel:(float)bmi numberOfTZLabel:(float)tz sex:(BOOL)s{
    _numberOfBMILabel.text=[NSString stringWithFormat:@"%.1f",bmi];
    _numberOfTZLabel.text=[NSString stringWithFormat:@"%.1f%%",tz];
    if(bmi>=18.5&&bmi<=24){
        _fitnessSituationLabel.text=@"正常";
    }
    else if(bmi>=24){
        _fitnessSituationLabel.text=@"肥胖";
    }
    else{
        _fitnessSituationLabel.text=@"偏瘦";
    }
    
    if((s==0&&tz>30)||(s==1&&tz>25)){
        _levelOfTZ.text=@"高";
    }
    else{
        _levelOfTZ.text=@"正常";
    }
    
}


@end
