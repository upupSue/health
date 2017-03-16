//
//  DietPlanCollectionViewCell.h
//  WeightCare
//
//  Created by BG on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietPlanCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foodImg;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodAmount;


-(void)SetFoodImg:(UIImage *)foodImg SetFoodName:(NSString *)foodName SetFoodAmount:(NSString *)foodAmount;


@end
