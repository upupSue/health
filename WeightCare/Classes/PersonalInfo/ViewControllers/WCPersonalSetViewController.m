//
//  WCPersonalSetViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetViewController.h"
#import "WCPersonalSetAboutusViewController.h"
#import "WCPersonalZhanghaoViewController.h"
#import "WCPersonalSetSafesetViewController.h"
#import "WCPersonalSetAddressTableViewController.h"
#import "WCPersonalSetAddressTableViewCell.h"
#import "WCPersonalInfoViewController.h"
#import "WCLogInViewController.h"
@interface WCPersonalSetViewController ()

@end

@implementation WCPersonalSetViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    //self.DatePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _WCPZHViewOne.layer.cornerRadius=10;
    _WCPZHViewTwo.layer.cornerRadius=10;
    _WCPZHViewThree.layer.cornerRadius=10;
    _WCPZHViewFour.layer.cornerRadius=10;
    _WCPZHBackButton.layer.cornerRadius=10;
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSarrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WCPSBackLoginButton:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCLogInViewController *vc = [[WCLogInViewController alloc] init];
    [NSUserDefaults saveBoolValue:NO withKey:@"isLogIn"];
    [NSUserDefaults removeValueWithKey:@"userId"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)WCPSZhanghaoButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalZhanghaoViewController *pv=[[WCPersonalZhanghaoViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}
- (IBAction)WCPSafeButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetSafesetViewController *pv=[[WCPersonalSetSafesetViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)WCPSAddressButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetAddressTableViewController* pv=[[WCPersonalSetAddressTableViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)WCPAboutusButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetAboutusViewController *CL = [[WCPersonalSetAboutusViewController alloc] init];
    [self.navigationController pushViewController:CL animated:YES];
    
}
- (IBAction)WCPZHBackButton:(UIButton *)sender {
}
- (IBAction)WCPZHClearButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)WCPShareButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)WCPSetnumberButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
@end
