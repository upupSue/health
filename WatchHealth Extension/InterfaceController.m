//
//  InterfaceController.m
//  WatchHealth Extension
//
//  Created by Friday on 16/7/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "InterfaceController.h"
#import "NKWatchChart/NKWatchChart.h"

@interface InterfaceController()
{
    NSDictionary *info;
}
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *todayStepLabel;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HealthyInfo"]) {
        info = [[NSUserDefaults standardUserDefaults] objectForKey:@"HealthyInfo"];
    }
    else
    {
        info = @{@"walk":@[@0,@0,@0,@0,@0,@0,@0] , @"sport":@0 , @"eat":@0 , @"maxEat":@1 , @"weight":@0 , @"maxWeight" : @1};
    }
    [_todayStepLabel setText:[NSString stringWithFormat:@"今日步数: %@步",info[@"walk"][6]]];
    [self drawChart];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)drawChart {
    UIImage *image0;
    CGRect frame = CGRectMake(0, 0, self.contentFrame.size.width, self.contentFrame.size.height);
    NKBarChart *chart0 = [[NKBarChart alloc] initWithFrame:frame];
    chart0.barWidth = 13;
    chart0.chartMargin = 6;
    chart0.labelTextColor = [UIColor whiteColor];
    chart0.labelFont = [UIFont systemFontOfSize:5.0];
    chart0.barBackgroundColor = [UIColor clearColor];
    chart0.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%0.f",yValueParsed];
        return labelText;
    };
    chart0.labelMarginTop = 5.0;
    chart0.showChartBorder = NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd";
    NSMutableArray *dateArr = [[NSMutableArray alloc] init];
    for (int i=6; i>=0; i--) {
        [dateArr addObject:[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-i*3600*24]]];
    }
    [chart0 setXLabels:dateArr];
    //       self.barChart.yLabels = @[@-10,@0,@10];
    [chart0 setYValues:info[@"walk"]];
    chart0.showYLabel=NO;
    UIColor *strokeColor = [UIColor colorWithRed:80/255.0 green:176/255.0 blue:1.0 alpha:1.0];
    [chart0 setStrokeColors:@[strokeColor,strokeColor,strokeColor,strokeColor,strokeColor,strokeColor,strokeColor]];
    image0 = [chart0 drawImage];
    [self.chartImage0 setImage:image0];
}

@end



