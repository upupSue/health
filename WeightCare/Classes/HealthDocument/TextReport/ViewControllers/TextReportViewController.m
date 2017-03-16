//
//  TextReportViewController.m
//  WeightCare
//
//  Created by BG on 16/8/29.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "TextReportViewController.h"
#import "AddReportViewController.h"
#import "TextReportTableViewCell.h"
static NSString *const TextReportCell= @"TextReportTableViewCell";

@interface TextReportViewController ()<UITableViewDelegate,UITableViewDataSource>{
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation TextReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.title=@"体检档案";
    self.tableview.backgroundColor=BG_COLOR;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addReport)];
    [self.tableview registerNib:[UINib nibWithNibName:@"TextReportTableViewCell" bundle:nil]  forHeaderFooterViewReuseIdentifier:TextReportCell];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
   TextReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextReportCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TextReportTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {NSLog(@"删除");}];
    
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {NSLog(@"编辑");}];
    rowActionSec.backgroundColor = [UIColor grayColor];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}



-(void)addReport{
    AddReportViewController *vc=[[AddReportViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
