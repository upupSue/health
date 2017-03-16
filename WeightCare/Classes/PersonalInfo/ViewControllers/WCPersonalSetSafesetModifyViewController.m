//
//  WCPersonalSetSafesetModifyViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetSafesetModifyViewController.h"
#import "WCPersonalSetSafesetViewController.h"
@interface WCPersonalSetSafesetModifyViewController ()

@end

@implementation WCPersonalSetSafesetModifyViewController
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _ViewOne.layer.cornerRadius=10;
    _ViewTwo.layer.cornerRadius=10;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"修改密码";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSMarrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSMcheckmark.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(check)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)check{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
