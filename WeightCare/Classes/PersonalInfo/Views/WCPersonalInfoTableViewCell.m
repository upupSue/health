//
//  TableViewCell.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalInfoTableViewCell.h"

@implementation WCPersonalInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPerosnalInfoTableCellImage:(UIImage *)image andSetPersonalInfoTableCellLabel:(NSString *)label{
    _perosnalInfoTableCellImage.image = image;
    _perosnalInfoTableCellLabel.text = label;
}

@end
