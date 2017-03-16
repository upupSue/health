//
//  WCPersonalSetZhanghaoMailViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyBlock)(NSString *);
@interface WCPersonalSetZhanghaoMailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *WCPZHMailTextField;
@property (weak, nonatomic) IBOutlet UIView *WCPUMViewOne;
@property(nonatomic,copy)MyBlock block;
@end
