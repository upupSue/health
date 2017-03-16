//
//  LineViewController.h
//  tableViewTest
//
//  Created by BG on 16/7/21.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"

@interface LineViewController : UIViewController{
    
    MPGraphView *graph,*graph2,*graph3,*graph4;
    
    MPBarsGraphView *graph5;
}

@end
