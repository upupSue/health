//
//  WCHomeCardFoodSubTableViewCell.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardFoodSubTableViewCell.h"

@implementation WCHomeCardFoodSubTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFoodImage:(UIImage *)foodImage andSetFoodName:(NSString *)foodName andSetFoodNumber:(NSString *)foodNumber andSetFoodCalories:(NSString *)foodCalories andSetDinnerName:(NSString *)dinner
{
    _foodImage.image = foodImage;
    _foodNameLabel.text = foodName;
    _foodNumberLabel.text = foodNumber;
    _foodCaloriesLabel.text = foodCalories;
    _dinnerNameLabel.text = dinner;
}

@end
