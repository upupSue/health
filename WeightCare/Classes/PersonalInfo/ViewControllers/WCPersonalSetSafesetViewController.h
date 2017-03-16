//
//  WCPersonalSetSafesetViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface WCPersonalSetSafesetViewController : UIViewController
- (IBAction)WCPSSetModify:(UIButton *)sender;
- (IBAction)WCPSSEmpty:(UIButton *)sender;
- (IBAction)WCPSSSwitchOne:(UISwitch *)sender;
- (IBAction)WCPSSSwitchTwo:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIView *WCPssViewOne;
@property (weak, nonatomic) IBOutlet UIView *WCPssViewTwo;
- (IBAction)WCPSSXiugaiButtonBig:(UIButton *)sender;
- (IBAction)WCPSSPushButtonBig:(UIButton *)sender;

@end
