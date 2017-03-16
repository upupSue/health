//
//  WCHealthDeviceTableViewBlueToothCell.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDeviceTableViewBlueToothCell.h"

@implementation WCHealthDeviceTableViewBlueToothCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.baseView.layer.cornerRadius  = 10.f;
    self.baseView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHealthDeviceImage:(UIImage *)image1 andSetHealthDeviceLabel:(NSString *)label andSetHealthDeviceCheckImage:(UIImage *)image2{
    _healthDeviceImage.image = image1;
    _healthDeviceLabel.text = label;
    _healthDeviceCheckImage.image = image2;
}

- (void)setHealthDeviceImage:(UIImage *)image1 andSetHealthDeviceLabel:(NSString *)label{
    _healthDeviceImage.image = image1;
    _healthDeviceLabel.text = label;

}

@end
