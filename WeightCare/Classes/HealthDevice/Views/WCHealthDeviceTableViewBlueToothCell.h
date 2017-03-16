//
//  WCHealthDeviceTableViewBlueToothCell.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHealthDeviceTableViewBlueToothCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *healthDeviceImage;
@property (weak, nonatomic) IBOutlet UILabel *healthDeviceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *healthDeviceCheckImage;


- (void)setHealthDeviceImage:(UIImage *)image1 andSetHealthDeviceLabel:(NSString *)label andSetHealthDeviceCheckImage:(UIImage *)image2;
- (void)setHealthDeviceImage:(UIImage *)image1 andSetHealthDeviceLabel:(NSString *)label;

@end
