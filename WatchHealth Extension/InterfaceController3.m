//
//  InterfaceController3.m
//  WeightCare
//
//  Created by Friday on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "InterfaceController3.h"
#import "NKWatchChart/NKWatchChart.h"
@interface InterfaceController3 ()
{
    NSDictionary *info;
}
@end

@implementation InterfaceController3

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

    UIImage *image3;
    UIColor *shadowColor = [UIColor colorWithRed:34.0 / 255.0 green:15.0 / 255.0 blue:15.0 / 255.0 alpha:0.5f];
    CGRect frame = CGRectMake(0, 0, self.contentFrame.size.width, self.contentFrame.size.height);
    NKCircleChart *chart3 = [[NKCircleChart alloc] initWithFrame:frame total:info[@"maxWeight"] current:info[@"weight"] clockwise:YES shadow:YES shadowColor:shadowColor displayCountingLabel:YES overrideLineWidth:@10];
    chart3.strokeColor = [UIColor colorWithRed:255.0 / 255.0 green:109.0 / 255.0 blue:109.0 / 255.0 alpha:1.0f];
    chart3.strokeColorGradientStart = [UIColor colorWithRed:255.0 / 255.0 green:109.0 / 255.0 blue:109.0 / 255.0 alpha:1.0f];
    chart3.chartType = NKChartFormatTypeWeight;
    chart3.lblTitle = @"最近体重记录";
    chart3.imgName = @"meter";
    image3 = [chart3 drawImage];
    [self.chartImage3 setImage:image3];
    
}

@end



