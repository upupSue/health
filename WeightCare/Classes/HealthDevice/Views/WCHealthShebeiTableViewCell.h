//
//  WCHealthShebeiTableViewCell.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHealthShebeiTableViewCell : UITableViewCell
- (IBAction)ChoseButton:(UIButton *)sender;
@property NSInteger flag;
@property (weak, nonatomic) IBOutlet UIButton *ChoseButton;
@property (weak, nonatomic) IBOutlet UILabel *ShebeiLabel;


@end
