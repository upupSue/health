//
//  WCPersonalBodyDataControllerViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"

@interface WCPersonalBodyDataControllerViewController : UIViewController{
    
    MPGraphView *graph,*graph2,*graph3,*graph4;
    
    MPBarsGraphView *graph5;
}
@property (weak, nonatomic) IBOutlet UILabel *HeightLabel;
- (IBAction)chevrondown:(UIButton *)sender;

@end
