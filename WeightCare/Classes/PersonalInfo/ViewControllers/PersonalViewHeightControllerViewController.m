//
//  PersonalViewHeightControllerViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "PersonalViewHeightControllerViewController.h"
#import "RulerView.h"
#import "PersonalViewController.h"
#import "LocalDBManager.h"

@interface PersonalViewHeightControllerViewController (){
    RulerView *rulerView;
}

@end

@implementation PersonalViewHeightControllerViewController
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"身高";
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
    [rulerView initRuler_MinScale:0.1 minNumValue:0 NumValue:0 NumUnit:@"cm" Precision:1 MaxNumValue:240];
    [self.view addSubview:rulerView];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Click{
    
   // NSLog(@"%.2f",[rulerView getResult]);
    
    [self.navigationController popViewControllerAnimated:YES];
    [[LocalDBManager sharedManager]setUserHeight:[NSString stringWithFormat:@"%.1f",[rulerView getResult]] userId:[NSUserDefaults valueWithKey:@"userId"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
