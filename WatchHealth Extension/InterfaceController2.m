//
//  InterfaceController2.m
//  WeightCare
//
//  Created by Friday on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "InterfaceController2.h"
#import "NKWatchChart/NKWatchChart.h"
@interface InterfaceController2 ()
{
    NSDictionary *info;
}
@end

@implementation InterfaceController2

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
    [self drawChart];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
-(void)drawChart {

    UIImage *image2;
    UIColor *shadowColor = [UIColor colorWithRed:1.0 / 255.0 green:27.0 / 255.0 blue:19.0 / 255.0 alpha:0.5f];
    CGRect frame = CGRectMake(0, 0, self.contentFrame.size.width, self.contentFrame.size.height);
    NKCircleChart *chart2 = [[NKCircleChart alloc] initWithFrame:frame total:info[@"maxEat"] current:info[@"eat"] clockwise:YES shadow:YES shadowColor:shadowColor displayCountingLabel:YES overrideLineWidth:@10];
    chart2.strokeColor = [UIColor colorWithRed:10.0 / 255.0 green:230.0 / 255.0 blue:163.0 / 255.0 alpha:1.0f];
    chart2.strokeColorGradientStart = [UIColor colorWithRed:10.0 / 255.0 green:230.0 / 255.0 blue:163.0 / 255.0 alpha:1.0f];
    chart2.chartType = NKChartFormatTypeCal;
    chart2.lblTitle = @"今日还可摄入";
    chart2.imgName = @"cutlery";
    image2 = [chart2 drawImage];
    [self.chartImage2 setImage:image2];

    
}

@end



