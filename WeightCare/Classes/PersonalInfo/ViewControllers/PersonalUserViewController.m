//
//  PersonalUserViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "PersonalUserViewController.h"
#import "PersonalViewController.h"
#import "LocalDBManager.h"
@interface PersonalUserViewController ()<UITextFieldDelegate>

@end

@implementation PersonalUserViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _PLUViewOne.layer.cornerRadius=10;
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"用户名";
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
    // Do any additional setup after loading the view from its nib.
    NSArray *arrd = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _PLUserTextField.placeholder=arrd[0][@"uName"];

   
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Click{
    [self.navigationController popViewControllerAnimated:YES];
    [[LocalDBManager sharedManager]setUserName:_PLUserTextField.text userId:[NSUserDefaults valueWithKey:@"userId"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_PLUserTextField resignFirstResponder];
}
@end
