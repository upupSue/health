//
//  WCPersonalSetAddressTableViewCell.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface WCPersonalSetAddressTableViewCell : UITableViewCell
@property NSInteger flag;
@property (weak, nonatomic) IBOutlet UIImageView *WCPSSACheckImage;
@property (weak, nonatomic) IBOutlet UILabel *WCPSSANameLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCPSSAPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCPSSAMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCPSSAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *WCPSABigButton;
- (IBAction)WCPSABigButton:(UIButton *)sender;
@end
