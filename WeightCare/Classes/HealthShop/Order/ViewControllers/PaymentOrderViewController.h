//
//  PayNoteViewController.h
//  WeightCare
//
//  Created by BG on 16/8/29.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentOrderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property NSString* Img;
@property NSString* name;
@property NSString* price;

@end
