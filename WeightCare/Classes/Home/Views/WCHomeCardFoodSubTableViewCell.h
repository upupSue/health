//
//  WCHomeCardFoodSubTableViewCell.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeCardFoodSubTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerNameLabel;




- (void)setFoodImage:(UIImage *)foodImage andSetFoodName:(NSString *)foodName andSetFoodNumber:(NSString *)foodNumber andSetFoodCalories:(NSString *)foodCalories andSetDinnerName:(NSString *)dinner;


@end
