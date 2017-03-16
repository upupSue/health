//
//  ClockTableViewController.m
//  Remind
//
//  Created by 王佳楠 on 16/7/22.
//  Copyright © 2016年 study. All rights reserved.
//

#import "ClockTableViewController.h"
#import "ViewController.h"
#import "ClockTableViewCell.h"
@interface ClockTableViewController (){
    NSMutableArray *tableData;
    NSArray *imageArray;
}

@end

@implementation ClockTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"运动闹钟";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"INplus.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addCell)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    
    //初始化表格数据
    tableData = [[NSMutableArray alloc] init];
    [tableData addObject:[NSString stringWithFormat:@"10:00"]];
    [tableData addObject:[NSString stringWithFormat:@"10:20"]];
    [tableData addObject:[NSString stringWithFormat:@"10:40"]];
    [tableData addObject:[NSString stringWithFormat:@"11:00"]];
    imageArray = [NSArray arrayWithObjects:@"Image3",@"Image2",@"瑜伽1",@"自行车1",nil];
        //设置row的高度为自定义cell的高度
    self.tableView.rowHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addCell{
    self.hidesBottomBarWhenPushed=YES;
    ViewController *CL = [[ViewController alloc] init];
    [self.navigationController pushViewController:CL animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    static NSString *CellIdentifier = @"ClockTableViewCell";
    ClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClockTableViewCell" owner:self options:nil] lastObject];
    }
    cell.TimeClockLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.ClockImage.image = [UIImage imageNamed:imageArray[indexPath.row]];

    return cell;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
return 12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return 12;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

 //左滑编辑删除
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                       
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"编辑"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"编辑");
                                                                          }];
    rowActionSec.backgroundColor = [UIColor grayColor];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

@end
