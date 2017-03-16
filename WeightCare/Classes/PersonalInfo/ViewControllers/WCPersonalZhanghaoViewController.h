//
//  WCPersonalZhanghaoViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPersonalZhanghaoViewController : UIViewController
- (IBAction)WCPZHMailButton:(UIButton *)sender;
- (IBAction)WCPZHPhoneButton:(UIButton *)sender;
- (IBAction)WCPZHWeixinButton:(UIButton *)sender;
- (IBAction)WCPZHWeiboButton:(UIButton *)sender;
- (IBAction)WCPZHQQButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *WCPZMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCPZPhoneLabel;
@property (weak, nonatomic) IBOutlet UIView *WCPZHPViewOne;
@property (weak, nonatomic) IBOutlet UIView *WCPZHPViewTwo;
- (IBAction)WCPZHmailButtonBig:(UIButton *)sender;
- (IBAction)WCPZHPhoneButtonBig:(UIButton *)sender;
- (IBAction)WCPZHWechatButtonBig:(UIButton *)sender;
- (IBAction)WCPZHWeiboButtonBig:(UIButton *)sender;
- (IBAction)WCPZHQQButtonBig:(UIButton *)sender;


@end
