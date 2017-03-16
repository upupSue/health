//
//  PersonalTarWeightViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "PersonalTarWeightViewController.h"
#import "RulerView.h"
#import "PersonalViewController.h"
#import "LocalDBManager.h"
@interface PersonalTarWeightViewController (){
    RulerView *rulerView;
}

@end

@implementation PersonalTarWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"初始体重";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"PLleftBtn.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"PLUcheckmark.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(Click)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    
    //设置尺子
    rulerView=[[RulerView alloc]initWithFrame:CGRectMake(4, 238, SCREEN_WIDTH-10, 283)];
    [rulerView setColor:BLUE_COLOR ];
    [rulerView setfLable:@""];
    [rulerView setWeight:1];
    rulerView.clipsToBounds=YES;
    [rulerView initRuler_MinScale:0.1 minNumValue:0 NumValue:0 NumUnit:@"kg" Precision:1 MaxNumValue:100];
    [self.view addSubview:rulerView];
    
    // Do any additional setup after loading the view from its nib.
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Click{
    [self.navigationController popViewControllerAnimated:YES];
    [[LocalDBManager sharedManager]setUserTargetWeight:[NSString stringWithFormat:@"%1.0f",[rulerView getResult]] userId:[NSUserDefaults valueWithKey:@"userId"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
