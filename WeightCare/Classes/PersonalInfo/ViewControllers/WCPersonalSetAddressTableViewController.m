//
//  WCPersonalSetAddressTableViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalSetAddressTableViewController.h"
#import "WCPersonalSetAddressTableViewCell.h"
#import "WCPersonalSetViewController.h"
#import "WCPersonalSetAddAddressViewController.h"
@interface WCPersonalSetAddressTableViewController (){
    NSMutableArray *NameLabel;
    NSMutableArray *PhoneLabel;
    NSMutableArray *AddressLabel;
}
@end

@implementation WCPersonalSetAddressTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Rectangle.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"收货地址";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSAarrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSSAplus.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addCell)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    //设置tableView的数据源和委托
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    //设置row的高度为自定义cell的高度
    self.tableView.rowHeight = 120;
    
    NameLabel = [[NSMutableArray alloc] init];
    [NameLabel addObject:[NSString stringWithFormat:@"方聪"]];
    [NameLabel addObject:[NSString stringWithFormat:@"方琼蔚"]];
    [NameLabel addObject:[NSString stringWithFormat:@"王佳楠"]];
    
    PhoneLabel = [[NSMutableArray alloc] init];
    [PhoneLabel addObject:[NSString stringWithFormat:@"17826805021"]];
    [PhoneLabel addObject:[NSString stringWithFormat:@"17826808400"]];
    [PhoneLabel addObject:[NSString stringWithFormat:@"17826804845"]];
    
    AddressLabel = [[NSMutableArray alloc] init];
    [AddressLabel addObject:[NSString stringWithFormat:@"浙江省杭州市西湖区留下街道留和路318号                                  浙江科技学院小和山校区西和公寓10幢"]];
    [AddressLabel addObject:[NSString stringWithFormat:@"浙江省杭州市西湖区留下街道留和路318号                                  浙江科技学院小和山校区西和公寓9幢"]];
    [AddressLabel addObject:[NSString stringWithFormat:@"浙江省杭州市西湖区留下街道留和路318号                                  浙江科技学院小和山校区西和公寓10幢"]];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addCell{
    self.hidesBottomBarWhenPushed=YES;
        WCPersonalSetAddAddressViewController *pv=[[WCPersonalSetAddAddressViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    static NSString *CellIdentifier = @"WCPersonalSetAddressTableViewCelll";
    WCPersonalSetAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCPersonalSetAddressTableViewCell" owner:self options:nil] lastObject];
            }
    if(indexPath.row==0){
        cell.WCPSSACheckImage.image=[UIImage imageNamed:@"WCPSSACombined Shape-1.png"];
        [cell.WCPSABigButton setBackgroundImage:[UIImage imageNamed:@"WCPSSARectangleBlue.png"] forState:UIControlStateNormal];
            }
    cell.WCPSSANameLabel.text=[NameLabel objectAtIndex:indexPath.row];
    cell.WCPSSAPhoneLabel.text=[PhoneLabel objectAtIndex:indexPath.row];
    cell.WCPSSAddressLabel.text=[AddressLabel objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                       
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    
    NSArray *arr = @[rowAction];
    return arr;
}

@end
