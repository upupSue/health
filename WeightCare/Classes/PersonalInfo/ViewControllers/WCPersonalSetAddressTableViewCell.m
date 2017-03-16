//
//  WCPersonalSetAddressTableViewCell.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetAddressTableViewCell.h"
#import "WCPersonalSetAddressTableViewController.h"
@implementation WCPersonalSetAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)WCPSABigButton:(UIButton *)sender {
    if(!self.flag)
    {
        self.flag=1;
        UIImage *image=[UIImage imageNamed:@"WCPSSACombined Shape-1.png"];
        _WCPSSACheckImage.image=image;
        UIImage *image2=[UIImage imageNamed:@"WCPSSACombined Shape.png"];
        _WCPSSACheckImage.image=image2;
        [self.WCPSABigButton setBackgroundImage:[UIImage imageNamed:@"WCPSSARectangleBlue.png"] forState:UIControlStateNormal];
        [self.WCPSABigButton setBackgroundImage:[UIImage imageNamed:@"WCPSSARectangleGray.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag=0;
        UIImage *image=[UIImage imageNamed:@"WCPSSACombined Shape.png"];
        _WCPSSACheckImage.image=image;
        UIImage *image2=[UIImage imageNamed:@"WCPSSACombined Shape-1.png"];
        _WCPSSACheckImage.image=image2;
        [self.WCPSABigButton setBackgroundImage:[UIImage imageNamed:@"WCPSSARectangleGray.png"] forState:UIControlStateNormal];
        [self.WCPSABigButton setBackgroundImage:[UIImage imageNamed:@"WCPSSARectangleBlue.png"] forState:UIControlStateNormal];
    }
}
@end
