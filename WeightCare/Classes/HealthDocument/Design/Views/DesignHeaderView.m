//
//  DietPlanHeaderView.m
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "DesignHeaderView.h"

@implementation DesignHeaderView

- (void)SetContentLabel:(NSString *)contentLabel SetNumLabel:(NSString *)numLabel SetUnitLabel:(NSString *)unitLabel{
    _contentLabel.text = contentLabel;
    _numLabel.text = numLabel;
    _unitLabel.text = unitLabel;
}

@end
