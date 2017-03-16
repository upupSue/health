//
//  WCRiliTableViewCell.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/12.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCRiliTableViewCell.h"

@implementation WCRiliTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ViewCell.layer.cornerRadius=10;
    _ViewCell.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) wCRiliDateLabel:(NSString *)WCRiliDateLabel wCRilixiaohaoLabel:(NSString *)WCRilixiaohaoLabel wCRilisheruLabel:(NSString *)WCRilisheruLabel wCRiliWeightLabel:(NSString *)WCRiliWeightLabel{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];

    _WCRiliDateLabel.text=WCRiliDateLabel;
    _WCRilisheruLabel.text=WCRilisheruLabel;
    _WCRilixiaohaoLabel.text=WCRilixiaohaoLabel;
    _WCRiliWeightLabel.text=WCRiliWeightLabel;
}

@end
