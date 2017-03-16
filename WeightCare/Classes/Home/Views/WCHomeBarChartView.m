//
//  WCHomeBarChartView.m
//  WeightCare
//
//  Created by KentonYu on 16/7/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeBarChartView.h"
@import Charts;

@interface WCHomeBarChartView ()<ChartViewDelegate>

@property (nonatomic, strong) BarChartView *chartView;
@property (nonatomic, assign) NSNumber* displayStyle; //显示风格
@property (nonatomic,weak) UILabel* sportLabel; //显示运动计划的
@property (nonatomic, copy) NSArray* sportTextArray;//运动描述
@end

@implementation WCHomeBarChartView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.displayStyle=@1;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.chartView];
    }
    return self;
}

- (void) initChartView:(NSNumber*)style{
    self.displayStyle=style;
    if (self) {
        [self addSubview:self.chartView];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.chartView.frame = CGRectMake(0, 0, self.width, self.height);
}


#pragma mark - Public

- (void)loadData:(NSArray<NSNumber *> *)dataArray xAxisTitle:(NSArray<NSString *> *)xAxisTitleArray {
    
    //对应Y轴上面需要显示的数据
    NSMutableArray<BarChartDataEntry *> *yVals = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
    [dataArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[obj doubleValue] xIndex:idx];
        [yVals addObject:entry];
    }];
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:nil];
    set1.barSpace = 0.5;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled  = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    set1.colors = @[BLUE_COLOR];
    
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithXVals:xAxisTitleArray dataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:10.f]];
    [data setValueTextColor:RGBA(148, 148, 148, 1)];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPositiveFormat:@"#0"];
    [data setValueFormatter:formatter];
    
    self.chartView.data = data;
}


- (void)loadSportData:(NSArray<NSNumber *> *)dataArray xAxisTitle:(NSArray<NSString *> *)xAxisTitleArray  xLabel:(NSArray<NSString *> *)xLabelArray sportLabel:(UILabel*) sportLabel{
    
    self.sportTextArray=[xLabelArray mutableCopy];
    self.sportLabel=sportLabel;
    //对应Y轴上面需要显示的数据
    NSMutableArray<BarChartDataEntry *> *yVals = [[NSMutableArray alloc] initWithCapacity:dataArray.count+1];
    [dataArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[obj doubleValue] xIndex:idx];
        [yVals addObject:entry];
    }];
    //末尾加个0，使得Y轴从0开始计算比例
    BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:0.0f xIndex:dataArray.count];
    [yVals addObject:entry];
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:nil];
    set1.barSpace = 0.5;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled  = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    set1.colors = @[BLUE_COLOR];
    
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithXVals:xAxisTitleArray dataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:10.f]];
    [data setValueTextColor:RGBA(148, 148, 148, 1)];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setPercentSymbol:@"%"];
    [data setValueFormatter:formatter];
    
    self.chartView.data = data;
}



#pragma mark - Getter

- (BarChartView *)chartView {
    if (!_chartView) {
        _chartView = ({
            BarChartView *view = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
            view.descriptionText = @"";
            view.noDataTextDescription = @"暂无数据";
            view.drawGridBackgroundEnabled = NO;
            view.drawBordersEnabled = NO;
            view.dragEnabled = NO;
            
            // X 轴
            ChartXAxis *xAxis = view.xAxis;
            xAxis.labelPosition = XAxisLabelPositionBottom;
            xAxis.labelFont = [UIFont systemFontOfSize:10.f];
            xAxis.drawGridLinesEnabled = NO;
            xAxis.spaceBetweenLabels   = 1;
            if ([self.displayStyle isEqual:@1])
                xAxis.labelTextColor = RGBA(148, 148, 148, 1);
            if ([self.displayStyle isEqual:@2])
                xAxis.labelTextColor = DEEPBLUE_COLOR;

            xAxis.axisLineWidth = 0.f;
            xAxis.axisLineColor = GRAY_COLOR;
            // Y 轴 隐藏
            view.leftAxis.enabled  = NO;
            view.rightAxis.enabled = NO;
            
            // 隐藏图例
            view.legend.enabled = NO;
            
            [view setScaleEnabled:NO];
           
            if ([self.displayStyle isEqual:@1])
                [view animateWithYAxisDuration:1.5f];
            
            if ([self.displayStyle isEqual:@2])
            {
               [view setScaleMinima:2.0 scaleY:1.0]; //为了显示水平滑动效果
                [view setDragEnabled:YES];
                view.delegate=self; //支持点击事件
            }
            view;
        });
    }
    return _chartView;
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    if (entry.xIndex<[self.sportTextArray count])
        self.sportLabel.text=self.sportTextArray[entry.xIndex];
    
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    self.sportLabel.text=@"运动情况";
    NSLog(@"chartValueNothingSelected");
}


@end
