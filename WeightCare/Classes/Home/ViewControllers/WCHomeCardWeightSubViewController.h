//
//  WCHomeCardWeightSubViewController.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"

@interface WCHomeCardWeightSubViewController : UIViewController{
    
    MPGraphView *graph,*graph2,*graph3,*graph4;
    
    MPBarsGraphView *graph5;
}


//当前体重
@property (assign, nonatomic)CGFloat presentWeight;

//初始体重
@property (assign, nonatomic)CGFloat beginWeight;

//目标体重
@property (assign, nonatomic)CGFloat targetWeight;

@property (nonatomic, assign)NSInteger blueToothType;

@end
