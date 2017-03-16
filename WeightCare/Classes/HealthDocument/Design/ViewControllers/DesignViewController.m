//
//  DesignViewController.m
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "DesignViewController.h"
#import "DesignHeaderView.h"
#import "DesignFooterView.h"
#import "DietPlanTableViewCell.h"
#import "SportPlanTableViewCell.h"
#import "LocalDBManager.h"

static NSString *const DietPlanCell = @"DietPlanTableViewCell";
static NSString *const SportPlanCell = @"SportPlanTableViewCell";
static NSString *const DesignHeader = @"DesignHeaderView";
static NSString *const DesignFooter = @"DesignFooterView";

@interface DesignViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *timeArr;
    NSArray *headArr;
    NSArray *sportArr;
    NSMutableArray *breakfastArr;
    NSMutableArray *lunchArr;
    NSMutableArray *dinnerArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) DesignHeaderView *HeaderView;
@property (nonatomic,strong) DesignFooterView *FooterView;


@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=BG_COLOR;
    self.tableView.separatorColor=[UIColor clearColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"DietPlanTableViewCell" bundle:nil]  forHeaderFooterViewReuseIdentifier:DietPlanCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"SportPlanTableViewCell" bundle:nil]  forHeaderFooterViewReuseIdentifier:SportPlanCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"DesignHeaderView" bundle:nil]  forHeaderFooterViewReuseIdentifier:DesignHeader];
    [self.tableView registerNib:[UINib nibWithNibName:@"DesignFooterView" bundle:nil]  forHeaderFooterViewReuseIdentifier:DesignFooter];
    
    float allFIntake=0.0;
    
    if(_designType==dietDesign){
        self.title=@"饮食方案";
        breakfastArr=[[NSMutableArray alloc]init];
        lunchArr=[[NSMutableArray alloc]init];
        dinnerArr=[[NSMutableArray alloc]init];

        NSArray *arr = [[LocalDBManager sharedManager] readFoodPlan];
        
        for(NSDictionary *dic in arr){
            if([dic[@"time"] isEqual:@"1"]){
                NSDictionary *bDic=@{@"foodImg":dic[@"arrFood"][0][@"fImg"],
                                     @"foodName":dic[@"arrFood"][0][@"fName"],
                                     @"foodAmount":[NSString stringWithFormat:@"%@%@",dic[@"fAmount"],dic[@"arrFood"][0][@"fUnit"]]};
                [breakfastArr addObject:bDic];
                allFIntake+=([dic[@"arrFood"][0][@"fIntake"] floatValue]*[dic[@"fAmount"] floatValue]);
            }
            if([dic[@"time"] isEqual:@"2"]){
                NSDictionary *lDic=@{@"foodImg":dic[@"arrFood"][0][@"fImg"],
                                     @"foodName":dic[@"arrFood"][0][@"fName"],
                                     @"foodAmount":[NSString stringWithFormat:@"%@%@",dic[@"fAmount"],dic[@"arrFood"][0][@"fUnit"]]};
                [lunchArr addObject:lDic];
                allFIntake+=([dic[@"arrFood"][0][@"fIntake"] floatValue]*[dic[@"fAmount"] floatValue]);
            }
            if([dic[@"time"] isEqual:@"3"]){
                NSDictionary *dDic=@{@"foodImg":dic[@"arrFood"][0][@"fImg"],
                                     @"foodName":dic[@"arrFood"][0][@"fName"],
                                     @"foodAmount":[NSString stringWithFormat:@"%@%@",dic[@"fAmount"],dic[@"arrFood"][0][@"fUnit"]]};
                [dinnerArr addObject:dDic];
                allFIntake+=([dic[@"arrFood"][0][@"fIntake"] floatValue]*[dic[@"fAmount"] floatValue]);
            }
        }
        timeArr=@[@"早餐（建议7:00-8:00用餐)",@"中餐（建议11:30-12:30用餐)",@"晚餐（建议17:00-18:00用餐)"];
    }
    if(_designType==sportDesign){
        self.title=@"运动方案";
        sportArr = [[LocalDBManager sharedManager] readSportPlan];
    }
    
    headArr=@[@{@"content":@"热量预算",@"num":[NSString stringWithFormat:@"%.1f",allFIntake],@"unit":@"大卡"},@{@"content":@"燃脂心率",@"num":@"119 - 159",@"unit":@"次/分钟"}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  TABLEVIEW
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_designType==dietDesign){
        return 3;
    }
    else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_designType==dietDesign){
        return 230;
    }
    else{
        return 90;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DesignHeader];
    self.HeaderView.radiusView.layer.cornerRadius=8;
    
    if(_designType==dietDesign){
        [self.HeaderView SetContentLabel:headArr[0][@"content"] SetNumLabel:headArr[0][@"num"] SetUnitLabel:headArr[0][@"unit"]];
    }
    if(_designType==sportDesign){
        [self.HeaderView SetContentLabel:headArr[1][@"content"] SetNumLabel:headArr[1][@"num"] SetUnitLabel:headArr[1][@"unit"]];
    }
    return self.HeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    self.FooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DesignFooter];
    self.FooterView.addBtn.layer.cornerRadius=5;
    
    if(_designType==dietDesign){
        [self.FooterView.addBtn setTitle:@"复制到饮食记录" forState:UIControlStateNormal];
        [self.FooterView.addBtn addTarget:self action:@selector(copyFoodRecord) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [self.FooterView.addBtn setTitle:@"复制到运动管理" forState:UIControlStateNormal];
        [self.FooterView.addBtn addTarget:self action:@selector(copySportRecord) forControlEvents:UIControlEventTouchUpInside];
    }
    return self.FooterView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_designType==dietDesign){
        DietPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DietPlanCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DietPlanTableViewCell" owner:self options:nil] lastObject];
        }
        cell.eatTime.text=timeArr[indexPath.row];
        [cell.refresh addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.bfArr=breakfastArr;
        cell.lcArr=lunchArr;
        cell.dnArr=dinnerArr;
        cell.cTag=indexPath.row;

        return cell;

    }
    else{
        SportPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SportPlanCell];
        if (cell == nil) {
            float SpEnergyNum=[sportArr[indexPath.row][@"arrSport"][0][@"sConsume"] floatValue]*[sportArr[indexPath.row][@"sTarget"] floatValue];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SportPlanTableViewCell" owner:self options:nil] lastObject];
            [cell SetSpIcon:[UIImage imageNamed:sportArr[indexPath.row][@"arrSport"][0][@"pImg"]] SetSpKind:sportArr[indexPath.row][@"arrSport"][0][@"sName"] SetSpNum:sportArr[indexPath.row][@"sTarget"] SetSpUnit:sportArr[indexPath.row][@"arrSport"][0][@"sUnit"] SetSpEnergyNum:[NSString stringWithFormat:@"%.0f",SpEnergyNum]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollViewp{
    if(_tableView.contentOffset.y<=100){
        _tableView.bounces=NO;
    }
    else{
        _tableView.bounces=YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(void)copyFoodRecord{
    NSArray *arr = [[LocalDBManager sharedManager] getEverydayFood:[NSUserDefaults valueWithKey:@"userId"]];
    NSArray *arry = [[LocalDBManager sharedManager] readFoodPlan];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *date=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    
    for(NSDictionary *dic in arr){
        if([dic[@"date"]isEqualToString:date]){
            [[LocalDBManager sharedManager]deleteFoods:date];
        }
    }
    for(NSDictionary *dic in arry){
        NSString *time=dic[@"time"];
        NSString *no=dic[@"fNo"];
        NSString *amount=dic[@"fAmount"];

        [[LocalDBManager sharedManager]insertTodayFood:[no intValue] date:date time:[time intValue] fAmount:[amount floatValue] userId:[[NSUserDefaults valueWithKey:@"userId"]intValue]];
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"复制成功" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)copySportRecord{
    NSArray *arr = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
    NSArray *arrx = [[LocalDBManager sharedManager] readSportPlan];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *date=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    
    for(NSDictionary *dic in arr){
        if([dic[@"date"]isEqualToString:date]){
            [[LocalDBManager sharedManager]deleteSports:date];
        }
    }
    for(NSDictionary *dic in arrx){
        NSString *sNo=dic[@"sNo"];
        NSString *sComplete=dic[@"sComplete"];
        NSString *sTarget=dic[@"sTarget"];
        
        [[LocalDBManager sharedManager]insertTodaySport:[sNo intValue] date:date sTarget:[sTarget floatValue] sComplete:[sComplete floatValue] userId:[[NSUserDefaults valueWithKey:@"userId"]intValue]];
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"复制成功" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)doRefresh{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"刷新成功" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
