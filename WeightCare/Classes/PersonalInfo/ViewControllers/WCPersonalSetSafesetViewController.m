//
//  WCPersonalSetSafesetViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetSafesetViewController.h"
#import "WCPersonalSetViewController.h"
#import "WCPersonalSetSafesetModifyViewController.H"
@interface WCPersonalSetSafesetViewController ()

@end

@implementation WCPersonalSetSafesetViewController
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _WCPssViewOne.layer.cornerRadius=10;
    _WCPssViewTwo.layer.cornerRadius=10;
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"安全设置";
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
- (IBAction)WCPSSetModify:(UIButton *)sender {
    
}
- (IBAction)WCPSSEmpty:(UIButton *)sender {
}

- (IBAction)WCPSSSwitchOne:(UISwitch *)sender {
}
- (IBAction)WCPSSSwitchTwo:(UISwitch *)sender {
}
- (IBAction)WCPSSXiugaiButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetSafesetModifyViewController *pv=[[WCPersonalSetSafesetModifyViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)WCPSSPushButtonBig:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
