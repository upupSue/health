//
//  WCRiliselectViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCHomeBarChartView.h"

@interface WCRiliselectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UIView *WtNotesView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *SptPlanView;
@property (weak, nonatomic) IBOutlet UIView *FdNotesView;
@property (weak, nonatomic) IBOutlet UILabel *WeightExcept;
@property (weak, nonatomic) IBOutlet UILabel *WeightPast;
@property (nonatomic,strong) UIView *blueWeightView;
@property (nonatomic,strong) UILabel *weight;
-(void)setCellsFrameWeight:(float)weight WeightExpect:(float)weightExpect WeightPast:(float)weightPast;
@property (weak, nonatomic) IBOutlet UIView *GaryView;
@property (weak, nonatomic) IBOutlet UILabel *labelSport;
@property (weak, nonatomic) IBOutlet WCHomeBarChartView *imageViewBar;
@property (weak, nonatomic) IBOutlet UITableView *FoodPlan;
@property (weak, nonatomic) IBOutlet UILabel *PresentWeightLabel;
- (void)SetWeightExcept:(NSString *)weightExcept SetWeightPast:(NSString *)weightPast SetWeight:(NSString *)weight;
@end
