//
//  WCHealthDeviceViewController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDeviceViewController.h"
#import "WCHealthDeviceTableViewWatchCell.h"
#import "WCHealthDeviceTableViewBlueToothCell.h"
#import "WCHealthDeviceWeightViewController.h"
#import "WCHealthDeviceTableViewBlueToothCellTableViewCellNew.h"
#import "WCHealthDeviceWeightViewController.h";
static NSString *const WCHealthDeviceTableViewWatchCellIdentify = @"WCHealthDeviceTableViewWatchCellIdentify";
static NSString *const WCHealthDeviceTableViewBlueToothCellTableViewCellNewIdentify = @"WCHealthDeviceTableViewBlueToothCellTableViewCellNewIdentify";

@interface WCHealthDeviceViewController()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WCHealthDeviceViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.title=@"我的设备";
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow-thin-left_blue"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(returnToView)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    _tableView.backgroundColor = BG_COLOR;
   
    // 去除导航栏下部的灰色分割线
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏颜色
    //self.navigationController.navigationBar.barTintColor = RGB(236, 236, 236);
    
    //设置tableView的数据源和委托
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHealthDeviceTableViewWatchCell" bundle:nil] forCellReuseIdentifier: WCHealthDeviceTableViewWatchCellIdentify];
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHealthDeviceTableViewBlueToothCellTableViewCellNew" bundle:nil] forCellReuseIdentifier:WCHealthDeviceTableViewBlueToothCellTableViewCellNewIdentify];

    UIButton *clickBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 60)];
    [clickBtn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn1];
    
    UIButton *clickBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, 60)];
    [clickBtn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn2];
    
}
- (void)click1{
    WCHealthDeviceWeightViewController *vc = [[WCHealthDeviceWeightViewController alloc] init];
    vc.blueToothType = 1;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)click2{
    WCHealthDeviceWeightViewController *vc = [[WCHealthDeviceWeightViewController alloc] init];
    vc.blueToothType = 2;
    [self presentViewController:vc animated:YES completion:nil];
}



#pragma mark button
- (void)returnToView{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0)
    return 150;
    else{
        return 355;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        WCHealthDeviceTableViewBlueToothCellTableViewCellNew *cell2 = [tableView dequeueReusableCellWithIdentifier:WCHealthDeviceTableViewBlueToothCellTableViewCellNewIdentify forIndexPath:indexPath];
        //UIImage *image = [UIImage imageNamed:@"healthDeviceWeight_gray"];
        //[cell2 setHealthDeviceImage:image andSetHealthDeviceLabel:@"打开蓝牙\n连接您的体重秤"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
        
    }
    
    /*else if(indexPath.section == 2){
        WCHealthDeviceTableViewBlueToothCell *cell3 = [tableView dequeueReusableCellWithIdentifier:WCHealthDeviceTableViewBlueToothCellIdentify forIndexPath:indexPath];

        UIImage *image = [UIImage imageNamed:@"healthDeviceHeart_gray"];
        [cell3 setHealthDeviceImage:image andSetHealthDeviceLabel:@"打开蓝牙\n连接您的血压计"];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell3;
    }
     */
    else{
        WCHealthDeviceTableViewWatchCell *cell4 = [tableView dequeueReusableCellWithIdentifier: WCHealthDeviceTableViewWatchCellIdentify forIndexPath:indexPath];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
///设置header的背景颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];

    [headerView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}



@end
