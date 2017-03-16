//
//  WCRiliViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/12.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCRiliViewController.h"
#import "WCHomeCardFoodSubViewController.h"
#import "WCRiliTableViewCell.h"
#import "WCRiliselectViewController.h"
#import "LocalDBManager.h"
static NSString *const WCRiliTableViewCellIdentfiy = @"WCRiliTableViewCellIdentify";
static NSString *const WCRiliCell = @"WCRiliTableViewCell";
@interface WCRiliViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UILabel *dateLabel;
    NSDate *nowDate;
    
    NSInteger addInterval;
    NSInteger subInterval;
    NSArray *RiliArr;
    NSMutableArray *DataLabel;
    NSMutableArray *SheruLabel;
    NSMutableArray *XiaohaoLabel;
    NSMutableArray *RiliWeight;
    
    NSMutableArray *everydayArr;
    NSDictionary *everyMonthDic;
    
    NSString *smonth;
    int i;
    UIView *emptyView;
}

@end

@implementation WCRiliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=BG_COLOR;
    //self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 33, 25, 20)];
    [BackBtn setImage:[UIImage imageNamed:@"arrow-thin-left.png"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackBtn];
    [self setDateView];
    //设置tableView的数据源和委托
    self.WCRiliView.delegate   = self;
    self.WCRiliView.dataSource = self;
    [self.WCRiliView registerNib:[UINib nibWithNibName:@"WCRiliTableViewCell" bundle:nil] forCellReuseIdentifier:WCRiliTableViewCellIdentfiy];
    
    everyMonthDic=@{@"06":[self saveDic:@"06"],
                    @"07":[self saveDic:@"07"],
                    @"08":[self saveDic:@"08"],
                    @"09":[self saveDic:@"09"],
                    @"10":[self saveDic:@"10"],
                    @"11":[self saveDic:@"11"],
                    @"12":[self saveDic:@"12"],
                    };
    
    smonth=@"09";
    i=9;
    emptyView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
}

-(NSArray *)saveDic:(NSString *)month{
    everydayArr=[[NSMutableArray alloc]init];

    NSArray *arrf = [[LocalDBManager sharedManager] getEverydayFood:[NSUserDefaults valueWithKey:@"userId"]];
    NSArray *arrs = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
    NSArray *arrw = [[LocalDBManager sharedManager] getWeight:[NSUserDefaults valueWithKey:@"userId"]];
    float xh;
    float sr;
    float wt;
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString* day=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    for(int i=14;i<=[day intValue];i++){
        NSString *dates=[NSString stringWithFormat:@"2016/%@/%d",month,i];
        xh = 0.0;
        sr = 0.0;
        for(NSDictionary *dicf in arrf){
            float c;
            if([dicf[@"date"] isEqual:dates]){
                float a=[dicf[@"fAmount"] floatValue];
                float b=[dicf[@"arrFood"][0][@"fIntake"] floatValue];
                c=a*b;}
            else{
                c=0;}
            xh+=c;
        }
        for(NSDictionary *dics in arrs){
            float c;
            if([dics[@"date"] isEqual:dates]){
                float a=[dics[@"sComplete"] floatValue];
                float b=[dics[@"arrSport"][0][@"sConsume"] floatValue];
                c=a*b;}
            else{
                c=0;}
            sr+=c;
        }
        for(NSDictionary *dicw in arrw){
            if([dicw[@"date"] isEqual:dates]&&([dicw[@"wCurrent"] intValue]!=0)){
                wt=[dicw[@"wCurrent"] floatValue];}
            
        }

        NSDictionary *everydayDic=@{
                                    @"date":dates,
                                    @"consume":[NSString stringWithFormat:@"%.f",xh],
                                    @"intake":[NSString stringWithFormat:@"%.f",sr],
                                    @"weight":[NSString stringWithFormat:@"%.1f",wt],
                                    };
        if(!(xh==0&&sr==0)){
            [everydayArr addObject:everydayDic];
        }
    }
    return everydayArr;
}


- (void)setDateView{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    nowDate = [NSDate date];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    
    //日期label
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 32, 100, 20)];
    dateLabel.font = [UIFont fontWithName:PINGFANG size:18.f];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nowDate]];
    [_ViewHead addSubview:dateLabel];
    
    UIButton *subDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50 -20, 35, 10, 15)];
    [subDateBtn setImage:[UIImage imageNamed:@"subDate_white"] forState:UIControlStateNormal];
    [subDateBtn addTarget:self action:@selector(subDate) forControlEvents:UIControlEventTouchUpInside];
    [_ViewHead addSubview:subDateBtn];
    
    UIButton *addDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 50 +10, 35, 10, 15)];
    [addDateBtn setImage:[UIImage imageNamed:@"addDate_white"] forState:UIControlStateNormal];
    [addDateBtn addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
    [_ViewHead addSubview:addDateBtn];
}

- (void)subDate{
    subInterval = 1;
    dateLabel.text  = [self getDate:0 month:-subInterval day:0];
    i--;
    if(i<10){
        smonth=[NSString stringWithFormat:@"0%d",i];
    }
    else
        smonth=[NSString stringWithFormat:@"%d",i];
    [_WCRiliView reloadData];
}

- (void)addDate{
    addInterval =1;
    dateLabel.text  = [self getDate:0 month:+addInterval day:0];
    i++;
    if(i<10){
        smonth=[NSString stringWithFormat:@"0%d",i];
    }
    else
        smonth=[NSString stringWithFormat:@"%d",i];
    [_WCRiliView reloadData];
}

-(void)Back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.(20,33)
}

#pragma mark date
-(NSString*)getDate:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSDate *date = [dateFormatter dateFromString:dateLabel.text];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateFromData = [formatter stringFromDate:newdate];
    return dateFromData;
}


#pragma mark TableView DataSource & Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        WCRiliselectViewController *pv=[[WCRiliselectViewController alloc]init];
        [self presentViewController:pv animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSArray *arrr=everyMonthDic[smonth];
    if(arrr.count==0){
        [self setEmptyView];}
    else emptyView.hidden=YES;
    
    return arrr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
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
    WCRiliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCRiliTableViewCellIdentfiy forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCRiliTableViewCell" owner:self options:nil] lastObject];
    }
    [cell wCRiliDateLabel:everyMonthDic[smonth][indexPath.section][@"date"] wCRilixiaohaoLabel:everyMonthDic[smonth][indexPath.section][@"consume"] wCRilisheruLabel:everyMonthDic[smonth][indexPath.section][@"intake"] wCRiliWeightLabel:everyMonthDic[smonth][indexPath.section][@"weight"]];
    return cell;
}

-(void)setEmptyView{
    UILabel *noneLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 30)];
    noneLabel.text=@"该月没有记录哦";
    noneLabel.textAlignment=NSTextAlignmentCenter;
    noneLabel.textColor=DEEPGRAY_COLOR;
    noneLabel.font=[UIFont systemFontOfSize:16];
    [emptyView addSubview:noneLabel];
    emptyView.hidden=NO;
    [self.view addSubview:emptyView];
}


@end
