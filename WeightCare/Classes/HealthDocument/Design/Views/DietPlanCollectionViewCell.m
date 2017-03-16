//
//  DietPlanCollectionViewCell.m
//  WeightCare
//
//  Created by BG on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "DietPlanCollectionViewCell.h"


@implementation DietPlanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)SetFoodImg:(UIImage *)foodImg SetFoodName:(NSString *)foodName SetFoodAmount:(NSString *)foodAmount{
    _foodImg.image=foodImg;
    _foodName.text=foodName;
    _foodAmount.text=foodAmount;
}


@end
