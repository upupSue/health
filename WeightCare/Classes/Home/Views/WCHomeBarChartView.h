//
//  WCHomeBarChartView.h
//  WeightCare
//
//  Created by KentonYu on 16/7/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeBarChartView : UIView

/**
 *  加载数据
 *
 *  @param dataArray       Y 轴的值
 *  @param xAxisTitleArray X 轴的坐标
 */
- (void)loadData:(NSArray<NSNumber *> *)dataArray xAxisTitle:(NSArray<NSString *> *)xAxisTitleArray;
- (void)loadSportData:(NSArray<NSNumber *> *)dataArray xAxisTitle:(NSArray<NSString *> *)xAxisTitleArray xLabel:(NSArray<NSString *> *)xLabelArray sportLabel:(UILabel*) sportLabel;
- (void) initChartView:(NSNumber*)style;

@end
