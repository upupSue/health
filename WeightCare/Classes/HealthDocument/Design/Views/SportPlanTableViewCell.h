//
//  SportPlanTableViewCell.h
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportPlanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *spIcon;
@property (weak, nonatomic) IBOutlet UILabel *spKind;
@property (weak, nonatomic) IBOutlet UILabel *spNum;
@property (weak, nonatomic) IBOutlet UILabel *spUnit;
@property (weak, nonatomic) IBOutlet UILabel *spEnergyNum;

@property (weak, nonatomic) IBOutlet UIView *radiusView;

-(void)SetSpIcon:(UIImage *)image SetSpKind:(NSString *)spKind SetSpNum:(NSString *)spNum SetSpUnit:(NSString *)spUnit SetSpEnergyNum:(NSString *)spEnergyNum;


@end
