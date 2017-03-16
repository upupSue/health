//
//  SportPlanTableViewCell.m
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "SportPlanTableViewCell.h"

@implementation SportPlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _radiusView.layer.cornerRadius=10;
    _radiusView.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)SetSpIcon:(UIImage *)image SetSpKind:(NSString *)spKind SetSpNum:(NSString *)spNum SetSpUnit:(NSString *)spUnit SetSpEnergyNum:(NSString *)spEnergyNum{
    _spIcon.image=image;
    _spKind.text=spKind;
    _spNum.text=spNum;
    _spUnit.text=spUnit;
    _spEnergyNum.text=spEnergyNum;
}

@end
