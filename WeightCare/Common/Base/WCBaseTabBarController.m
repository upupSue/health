//
//  WCBaseTabBarController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCBaseTabBarController.h"
#import "WCHomeViewController.h"
#import "WCHealthDocumentViewController.h"
#import "WCHealthShopViewController.h"
#import "WCPersonalInfoViewController.h"

@interface WCBaseTabBarController ()

@end

@implementation WCBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"icon_tabHome"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabHomeSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"icon_tabDoc"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabDocSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"icon_tabShop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabShopSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                           
    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"icon_tabPersonal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabPersonalSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[WCHomeViewController new]];
    nav1.tabBarItem = item1;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[WCHealthDocumentViewController new]];
    nav2.tabBarItem = item2;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[WCHealthShopViewController new]];
    nav3.tabBarItem = item3;
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:[WCPersonalInfoViewController new]];
    nav4.tabBarItem = item4;
    
    self.viewControllers = @[nav1, nav2, nav3, nav4];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
