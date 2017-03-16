//
//  WCPersonalSetAboutusViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetAboutusViewController.h"
#import "WCPersonalSetViewController.h"
@interface WCPersonalSetAboutusViewController ()

@end

@implementation WCPersonalSetAboutusViewController

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WCPSABackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
