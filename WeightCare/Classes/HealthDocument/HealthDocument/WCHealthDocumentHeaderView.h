//
//  WCHealthDocumentHeaderView.h
//  WeightCare
//
//  Created by BG on 16/9/4.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHealthDocumentHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *numberOfBMILabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfTZLabel;
@property (weak, nonatomic) IBOutlet UILabel *fitnessSituationLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelOfTZ;

@property (weak, nonatomic) IBOutlet UIView *whiteContentView;
@property (weak, nonatomic) IBOutlet UIView *GrayWeightView;
@property (nonatomic,strong) UIView *blueWeightView;
@property (nonatomic,strong) UILabel *weight;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightExcept;
@property (weak, nonatomic) IBOutlet UILabel *weightPast;


@property (weak, nonatomic) IBOutlet UIButton *indetail;

- (void)setNumberOfBMILabel:(NSString *)numberOfBMILabel SetNumberOfTZLabel:(NSString *)numberOfTZLabel SetFitnessSituationLabel:(NSString *)fitnessSituationLabel SetLevelOfTZ:(NSString *)levelOfTZ SetDate:(NSString *)date SetsetLabel:(NSString *)setLabel SetWeightExcept:(NSString *)weightExcept SetWeightPast:(NSString *)weightPast SetWeight:(NSString *)weight;

-(void)setCellsFrameWeight:(float)weight WeightExpect:(float)weightExpect WeightPast:(float)weightPast;

-(void)setNumberOfBMILabel:(float)bmi numberOfTZLabel:(float)tz sex:(BOOL)s;

@end
