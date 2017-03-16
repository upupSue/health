//
//  WCHomeCardSportTableViewCell.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeCardSportTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sportImage;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressD;
@property (weak, nonatomic) IBOutlet UIImageView *baseView;

@property (assign, nonatomic) float persent;

- (void)setSportImage:(UIImage *)image andNameTextLabel:(NSAttributedString *)attStr andPresent:(float) present;

@end
