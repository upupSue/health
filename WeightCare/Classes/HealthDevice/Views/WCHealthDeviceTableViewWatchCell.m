//
//  WCHealthDeviceTableViewWatchCell.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDeviceTableViewWatchCell.h"




@implementation WCHealthDeviceTableViewWatchCell

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

@end
