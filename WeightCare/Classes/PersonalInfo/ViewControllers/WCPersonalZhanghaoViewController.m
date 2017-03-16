//
//  WCPersonalZhanghaoViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalZhanghaoViewController.h"
#import "WCPersonalSetViewController.h"
#import "WCPersonalSetZhanghaoMailViewController.h"
#import "WCPersonalSetZhanghaoPhoneViewController.h"
#import "LocalDBManager.h"
@interface WCPersonalZhanghaoViewController ()

@end

@implementation WCPersonalZhanghaoViewController

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    NSArray *arrx = [[LocalDBManager sharedManager] readUserid:[NSUserDefaults valueWithKey:@"userId"]];
    _WCPZMailLabel.text=arrx[0][@"uEmail"];
    
    NSArray *arrx2 = [[LocalDBManager sharedManager] readUserid:[NSUserDefaults valueWithKey:@"userId"]];
    _WCPZPhoneLabel.text=arrx2[0][@"uPhone"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _WCPZHPViewOne.layer.cornerRadius=10;
    _WCPZHPViewTwo.layer.cornerRadius=10;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"账号设置";
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
- (IBAction)WCPZHMailButton:(UIButton *)sender {
}
- (IBAction)WCPZHPhoneButton:(UIButton *)sender {
    
}
- (IBAction)WCPZHWeixinButton:(UIButton *)sender {
}

- (IBAction)WCPZHWeiboButton:(UIButton *)sender {
}

- (IBAction)WCPZHQQButton:(UIButton *)sender {
}
- (IBAction)WCPZHmailButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetZhanghaoMailViewController *pv=[[WCPersonalSetZhanghaoMailViewController alloc]init];
    __weak typeof(self)temp = self;
    pv.block = ^(NSString *string){
        // 通过回调将传进来的字符串赋值给label
        temp.WCPZMailLabel.text = string;
    };
    [self.navigationController pushViewController:pv animated:YES];
    
}

- (IBAction)WCPZHPhoneButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetZhanghaoPhoneViewController *pv=[[WCPersonalSetZhanghaoPhoneViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)WCPZHWechatButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)WCPZHWeiboButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)WCPZHQQButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
