//
//  WCPersonalSetAddAddressViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPersonalSetAddAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *WCPSSAACollecterNameText;
@property (weak, nonatomic) IBOutlet UITextField *WCPSSAAPhoneText;
@property (weak, nonatomic) IBOutlet UITextField *WCPSSAAMailText;
@property (weak, nonatomic) IBOutlet UITextView *WCPSSAAAddressBackgroundText;
@property (weak, nonatomic) IBOutlet UIButton *WCPSSASetAddressButton;
- (IBAction)WCPSSASetAddressButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *WCPSSAViewTwo;
@property (weak, nonatomic) IBOutlet UIView *WCPSSAViewOne;
@end
