//
//  LineViewController.m
//  tableViewTest
//
//  Created by BG on 16/7/21.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "LineViewController.h"

@interface LineViewController ()

@end

@implementation LineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    graph=[MPPlot plotWithType:MPPlotTypeGraph frame:CGRectMake(0, 30, 375, 312)];
    
    
    //    紫色曲线图
    graph3=[[MPGraphView alloc] initWithFrame:CGRectMake(0, 100, 375, 312)];
    
    graph3.waitToUpdate=YES;
    graph3.values=@[@80.0,@82.0,@81.2,@80.5,@79.0,@79.9];
    
    graph3.graphColor=[UIColor colorWithRed:255/255.0 green:75/255.0 blue:75/255.0 alpha:1];
    graph3.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    
    graph3.curved=YES;
    
    
    //    橘色曲线填充图
    graph4=[[MPGraphView alloc] initWithFrame:graph3.frame];

    
    graph4.values=@[@80.0,@82.0,@81.2,@80.5,@79.0,@79.9];
    graph4.fillColors=@[[UIColor whiteColor],[UIColor whiteColor]];
    graph4.graphColor=[UIColor colorWithRed:255/255.0 green:75/255.0 blue:75/255.0 alpha:1];
    graph4.curved=YES;
    [self.view addSubview:graph4];
    
    [self.view addSubview:graph3];

    
    self.view.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"Animate" forState:UIControlStateNormal];
//    button.frame=CGRectMake(30, self.view.height-100, self.view.width-60, 40);
//    [button setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(animate) forControlEvents:UIControlEventTouchUpInside];
    
}


- (UIView *)customDetailView{
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blueColor];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.borderColor=label.textColor.CGColor;
    label.layer.borderWidth=.5;
    label.layer.cornerRadius=label.width*.5;
    label.adjustsFontSizeToFitWidth=YES;
    label.clipsToBounds=YES;
    
    return label;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:1];
    
}

- (void)animate{
    
    [graph2 animate];
    [graph3 animate];
    [graph5 animate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

