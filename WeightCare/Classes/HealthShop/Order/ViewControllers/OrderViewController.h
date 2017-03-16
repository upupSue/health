//
//  CheckNoteViewController.h
//  WeightCare
//
//  Created by BG on 16/8/28.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController

@property OrderType orderType;

@property NSDictionary *dic;

@property NSString *productImg;
@property NSString *productName;
@property NSString *productNum;
@property NSString *productPrice;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
