//
//  DietPlanHeaderView.h
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesignHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIView *radiusView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

- (void)SetContentLabel:(NSString *)contentLabel SetNumLabel:(NSString *)numLabel SetUnitLabel:(NSString *)unitLabel;

@end
