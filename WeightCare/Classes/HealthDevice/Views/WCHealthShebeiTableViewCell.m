//
//  WCHealthShebeiTableViewCell.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthShebeiTableViewCell.h"

@implementation WCHealthShebeiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ChoseButton:(UIButton *)sender {
    if(!self.flag)
    {
        self.flag=1;
        [self.ChoseButton setBackgroundImage:[UIImage imageNamed:@"Oval Copy.png"] forState:UIControlStateNormal];
        [self.ChoseButton setBackgroundImage:[UIImage imageNamed:@"Oval.png"] forState:UIControlStateNormal];
    }
    
}
@end
