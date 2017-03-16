//
//  WCBlueToothViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCBlueToothViewController.h"
#import "WCHealthDeviceWeightViewController.h"
@interface WCBlueToothViewController ()

@end

@implementation WCBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ViewOne.layer.cornerRadius=10;
    _ShebeiView.layer.cornerRadius=10;
    _ShebeiView.clipsToBounds=YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.title=@"我的设备";
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow-thin-left_blue"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(returnToView)];
    self.navigationItem.leftBarButtonItem=barBtn1;
}

-(void)returnToView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)ShebeiClickButtonOne:(UIButton *)sender {
    WCHealthDeviceWeightViewController *vc = [[WCHealthDeviceWeightViewController alloc] init];
    vc.blueToothType=1;
    [self presentViewController:vc animated:YES completion:nil];
    
    _ClickImageOne.image=[UIImage imageNamed:@"Oval.png"];
    _ClickImageTwo.image=[UIImage imageNamed:@"Oval Copy.png"];
    _HeadLabel.text=@"纤美蓝牙秤";

}

- (IBAction)ShebeiClickButtonTwo:(UIButton *)sender {
    WCHealthDeviceWeightViewController *vc = [[WCHealthDeviceWeightViewController alloc] init];
    vc.blueToothType=2;
    [self presentViewController:vc animated:YES completion:nil];
    
    _ClickImageTwo.image=[UIImage imageNamed:@"Oval.png"];
    _ClickImageOne.image=[UIImage imageNamed:@"Oval Copy.png"];
    _HeadLabel.text=@"云麦蓝牙秤";

}

- (IBAction)HeadWatchButton:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
