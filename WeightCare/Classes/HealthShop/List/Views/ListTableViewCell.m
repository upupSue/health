//
//  NoteTableViewCell.m
//  WeightCare
//
//  Created by BG on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _radiusView.layer.cornerRadius=10;
    _radiusView.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)SetPrImg:(UIImage *)prImg SetPrName:(NSString *)prName SetPrNum:(NSString *)prNum SetPrPrice:(NSString *)prPrice{
    _prImg.image=prImg;
    _prName.text=prName;
    _prNum.text=prNum;
    _prPrice.text=prPrice;
}
@end
