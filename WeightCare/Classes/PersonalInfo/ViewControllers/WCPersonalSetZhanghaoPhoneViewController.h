//
//  WCPersonalSetZhanghaoPhoneViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPersonalSetZhanghaoPhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *WCPZHPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *WCPZHYanzhengTextField;
- (IBAction)WCPZHGetnumberButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *WCPSSGetNumber;

@property (weak, nonatomic) IBOutlet UIView *ViewOne;
@property (weak, nonatomic) IBOutlet UIView *ViewTwo;

@end
