//
//  WCPersonalSetViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPersonalSetViewController : UIViewController
- (IBAction)WCPSBackLoginButton:(UIButton *)sender;
- (IBAction)WCPSZhanghaoButtonBig:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *WCPZHViewOne;
@property (weak, nonatomic) IBOutlet UIView *WCPZHViewTwo;
- (IBAction)WCPSafeButtonBig:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *WCPZHViewThree;
- (IBAction)WCPSAddressButtonBig:(UIButton *)sender;
- (IBAction)WCPAboutusButtonBig:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *WCPZHViewFour;
@property (weak, nonatomic) IBOutlet UIButton *WCPZHBackButton;
- (IBAction)WCPZHClearButtonBig:(UIButton *)sender;
- (IBAction)WCPShareButtonBig:(UIButton *)sender;
- (IBAction)WCPSetnumberButtonBig:(UIButton *)sender;

@end
