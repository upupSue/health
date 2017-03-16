//
//  WCHomeSwitchCardWeightCollectionViewCell.h
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeSwitchCardWeightCollectionViewCell : UICollectionViewCell

// 当前体重
@property (nonatomic, assign) CGFloat currentWeight;
// 初始体重
@property (nonatomic, assign) CGFloat startWeight;
// 目标体重
@property (nonatomic, assign) CGFloat targetWeight;


@end
