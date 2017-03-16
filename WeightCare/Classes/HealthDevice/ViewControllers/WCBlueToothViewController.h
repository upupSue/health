//
//  WCBlueToothViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCBlueToothViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *ViewOne;
@property (weak, nonatomic) IBOutlet UIView *ShebeiView;
@property (weak, nonatomic) IBOutlet UILabel *ShebeiLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *ShebeiLabelTwo;
- (IBAction)ShebeiClickButtonOne:(UIButton *)sender;
- (IBAction)ShebeiClickButtonTwo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ClickImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *ClickImageTwo;
@property (weak, nonatomic) IBOutlet UILabel *HeadLabel;
@property (weak, nonatomic) IBOutlet UIButton *ShebeiClickButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *ShebeiClickButtonTwo;
- (IBAction)HeadWatchButton:(UIButton *)sender;

@end
