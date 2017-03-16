//
//  InterfaceController1.m
//  WeightCare
//
//  Created by Friday on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "InterfaceController1.h"
#import "NKWatchChart/NKWatchChart.h"
@interface InterfaceController1 ()
{
    NSDictionary *info;
}
@end

@implementation InterfaceController1

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

    UIImage *image1;
    UIColor *shadowColor = [UIColor colorWithRed:10.0 / 255.0 green:23.0 / 255.0 blue:34.0 / 255.0 alpha:0.5f];
    CGRect frame = CGRectMake(0, 0, self.contentFrame.size.width, self.contentFrame.size.height);
    NKCircleChart *chart1 = [[NKCircleChart alloc] initWithFrame:frame total:@100 current:info[@"sport"] clockwise:YES shadow:YES shadowColor:shadowColor displayCountingLabel:YES overrideLineWidth:@10];
    chart1.strokeColor = [UIColor colorWithRed:80.0 / 255.0 green:176.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f];
    chart1.strokeColorGradientStart = [UIColor colorWithRed:80.0 / 255.0 green:176.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f];
    chart1.chartType = NKChartFormatTypePercent;
    chart1.lblTitle = @"今日完成目标";
    chart1.imgName = @"lifting";
    image1 = [chart1 drawImage];
    [self.chartImage1 setImage:image1];
}

@end



