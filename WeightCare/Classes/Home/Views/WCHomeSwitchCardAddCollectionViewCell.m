//
//  WCHomeSwitchCardAddCollectionViewCell.m
//  WeightCare
//
//  Created by KentonYu on 16/7/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeSwitchCardAddCollectionViewCell.h"

@implementation WCHomeSwitchCardAddCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius  = 10.f;
    self.layer.masksToBounds = YES;
    self.grayView.layer.cornerRadius  = 10.f;
    self.grayView.layer.masksToBounds = YES;

//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_grayView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.grayView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.grayView.layer.mask = maskLayer;


}

@end
