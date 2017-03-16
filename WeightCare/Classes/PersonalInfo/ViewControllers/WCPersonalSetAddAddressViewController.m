//
//  WCPersonalSetAddAddressViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetAddAddressViewController.h"
#import "WCPersonalSetAddressTableViewController.h"

@interface WCPersonalSetAddAddressViewController ()

@end

@implementation WCPersonalSetAddAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _WCPSSAViewOne.layer.cornerRadius=10;
    _WCPSSAViewTwo.layer.cornerRadius=10;
    _WCPSSASetAddressButton.layer.cornerRadius=10;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"添加地址";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSAarrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSAAcheckmark.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addCell)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addCell{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WCPSSASetAddressButton:(UIButton *)sender {
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_WCPSSAAMailText resignFirstResponder];
    [_WCPSSAAPhoneText resignFirstResponder];
    [_WCPSSAACollecterNameText resignFirstResponder];
    [_WCPSSAAAddressBackgroundText resignFirstResponder];

}

@end
