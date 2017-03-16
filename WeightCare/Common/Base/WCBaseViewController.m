//
//  WCBaseViewController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/10.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCBaseViewController.h"
#import "WCTouchIDViewController.h"

@interface WCBaseViewController ()

@end

@implementation WCBaseViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:wcPresentTouchIDViewControllerNotificationName object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 弹出 TouchID 验证界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTouchIDViewController:) name:wcPresentTouchIDViewControllerNotificationName object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationBar];
}

- (void)configNavigationBar {
    [self.navigationController setNavigationBarHidden:NO];
    
    if (self.navigationController.navigationBar) {
        self.navigationController.navigationBar.barTintColor = RGB(236, 236, 236);
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    }
 
    if(self.navigationController.viewControllers.count > 1){
        UIButton *bckBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, ((NAVGATIONBAR_HEIGHT-STATUS_BAR_HEIGHT)-36)/2+STATUS_BAR_HEIGHT, 36, 36)];
        [bckBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [bckBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [bckBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bckBtn];
    }
    
}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presentTouchIDViewController:(id)sender {
    UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
    WCTouchIDViewController* touchVc=[WCTouchIDViewController sharedManager];
    Class cla = NSClassFromString(@"WCTouchIDViewController");
    // 判断是不是当前显示的控制器  以及 是不是已经是 TouchID 验证界面
    if (![currentVC isEqual:self] && ![currentVC isKindOfClass:cla]) {
        //id vc = [cla new];
        //[vc setValue:@NO forKey:@"push"];
        touchVc.push=NO;
        //
        if ([touchVc isBeingDismissed])
            [self presentViewController:touchVc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
