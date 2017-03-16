//
//  WCRiliselectViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCRiliselectViewController.h"
#import "WCHomeCardFoodSubTableViewCell.h"
#import "LocalDBManager.h"
#import "WCHealthDocumentViewController.h"
static NSString *const WCHomeCardFoodSubTableViewCellIdentfiy = @"WCHomeCardFoodSubTableViewCellIdentify";
@interface WCRiliselectViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *dateLabel;
    NSDate *nowDate;
    NSInteger addInterval;
    NSInteger subInterval;
    int targetPersent;
    NSInteger targetWaste;
    NSInteger currentWaste;
    NSInteger nowWaste;
    NSString *currectWeight;
}
@property (strong ,nonatomic)NSArray *FoodImageArray;
@property (strong ,nonatomic)NSArray *FoodNameArray;
@property (strong ,nonatomic)NSArray *FoodNunberArray;
@property (strong ,nonatomic)NSArray *FoodCaloriesArray;
@property (strong ,nonatomic)NSArray *DinnerNameArray;
@property (strong ,nonatomic)NSDictionary *sportDic;
@property (strong ,nonatomic)NSMutableArray *sportArr;
@property (strong ,nonatomic)NSMutableArray *sNoArr;
@property (strong ,nonatomic)NSMutableArray *percentArray;
@property (strong ,nonatomic)NSMutableArray *xLabelArray;
@property (strong ,nonatomic)NSMutableArray *xLabelTextArray;
@end

@implementation WCRiliselectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _WtNotesView.layer.cornerRadius=10;
    _WtNotesView.clipsToBounds=YES;
    _SptPlanView.layer.cornerRadius=10;
    _SptPlanView.clipsToBounds=YES;
    _FdNotesView.layer.cornerRadius=10;
    _FdNotesView.clipsToBounds=YES;
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=BG_COLOR;
    UIButton *BackBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 33, 25, 20)];
    [BackBtn setImage:[UIImage imageNamed:@"arrow-thin-left.png"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackBtn];
    [self setDateView];
    
    
    _GaryView.layer.cornerRadius=17;
    UIView *blueview=[[UIView alloc]initWithFrame:CGRectMake(3, 3, 270, 28)];
    blueview.backgroundColor=BLUE_COLOR;
    blueview.layer.cornerRadius=14;
    [_GaryView addSubview:blueview];
    
    
    
    
    NSArray *arrIfo = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _WeightExcept.text=arrIfo[0][@"tWeight"];
    _WeightPast.text=arrIfo[0][@"sWeight"];
    float wa=[[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
    currectWeight=[NSString stringWithFormat:@"%.1f",wa]==NULL?arrIfo[0][@"sWeight"]:[NSString stringWithFormat:@"%.1f",wa];
    _PresentWeightLabel.text=currectWeight;
    
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
        _sportArr = [[NSMutableArray alloc] init];
        _percentArray=[[NSMutableArray alloc] init];
        _xLabelArray=[[NSMutableArray alloc] init];
        _xLabelTextArray=[[NSMutableArray alloc]init];
        NSArray *arry = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
        for (int i = 0; i <arry.count; i++) {
            if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
                
                _sportDic = @{
                              
                              @"sportName":[NSString stringWithFormat:@"%@%@%@",arry[i][@"arrSport"][0][@"sName"],arry[i][@"sTarget"],arry[i][@"arrSport"][0][@"sUnit"]],
                              @"name":arry[i][@"arrSport"][0][@"sName"],
                              @"target":arry[i][@"sTarget"],
                              @"unit":arry[i][@"arrSport"][0][@"sUnit"],
                              @"complete":arry[i][@"sComplete"],
                              @"sNo":arry[i][@"sNo"],
                              @"scNo":arry[i][@"scNo"],
                              };
                [_percentArray addObject:[NSString stringWithFormat:@"%f%%",[_sportDic[@"complete"] floatValue]/[_sportDic[@"target"] floatValue] ]];
                [ _xLabelArray addObject:_sportDic[@"name"]];
                [ _xLabelTextArray addObject:_sportDic[@"sportName"]];
                
                [_sportArr addObject:_sportDic];
                [_sNoArr addObject:_sportDic[@"sNo"]];
            }
        }
    //加载数据演示
    
    NSMutableDictionary* barData=[[NSMutableDictionary alloc] init];
    [barData setValue:_percentArray forKey:@"percents"];
    [barData setValue:_xLabelArray forKey:@"xlabels"];
    [_imageViewBar initChartView:@2];
    [_imageViewBar loadSportData:barData[@"percents"] xAxisTitle:barData[@"xlabels"] xLabel:_xLabelTextArray sportLabel:self.labelSport];
    
    [self.FoodPlan registerNib:[UINib nibWithNibName:@"WCHomeCardFoodSubTableViewCell" bundle:nil] forCellReuseIdentifier:WCHomeCardFoodSubTableViewCellIdentfiy];
    self.FoodPlan.delegate= self;
    self.FoodPlan.dataSource = self;
    [self setTableViewCellDatasource];
    
}

- (void)setTableViewCellDatasource{
    _FoodNameArray = [NSArray arrayWithObjects:@"普通饼干", @"牛奶", @"煮鸡蛋", @"三明治", nil];
    _FoodImageArray = [NSArray arrayWithObjects:@"饼干", @"牛奶图片", @"煮鸡蛋图片", @"三明治",nil];
    _FoodNunberArray = [NSArray arrayWithObjects:@"3片", @"1杯(200g)", @"1个", @"1个", nil];
    _FoodCaloriesArray = [NSArray arrayWithObjects:@"78大卡", @"108大卡", @"71大卡", @"278大卡",nil];
    _DinnerNameArray = [NSArray arrayWithObjects:@"早餐", @"早餐", @"早餐", @"早餐", nil];;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setDateView{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    nowDate = [NSDate date];
    [dateFormatter setDateFormat:@"MM·dd"];
    
    //日期label
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 32, 100, 20)];
    dateLabel.font = [UIFont fontWithName:PINGFANG size:18.f];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nowDate]];
    [_HeadView addSubview:dateLabel];
    
    UIButton *subDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50 -20, 35, 10, 15)];
    [subDateBtn setImage:[UIImage imageNamed:@"subDate_white"] forState:UIControlStateNormal];
    [subDateBtn addTarget:self action:@selector(subDate) forControlEvents:UIControlEventTouchUpInside];
    [_HeadView addSubview:subDateBtn];
    
    UIButton *addDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 50 +10, 35, 10, 15)];
    [addDateBtn setImage:[UIImage imageNamed:@"addDate_white"] forState:UIControlStateNormal];
    [addDateBtn addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
    [_HeadView addSubview:addDateBtn];
}

- (void)subDate{
    subInterval = 1;
    dateLabel.text  = [self getDate:0 month:0 day:-subInterval];
}

- (void)addDate{
    addInterval =1;
    dateLabel.text  = [self getDate:0 month:0 day:+addInterval];
    
}

-(void)Back{
    [self dismissViewControllerAnimated:YES completion:nil];

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
    [dateFormatter setDateFormat:@"MM·dd"];
    NSDate *date = [dateFormatter dateFromString:dateLabel.text];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM·dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateFromData = [formatter stringFromDate:newdate];
    //    NSLog(@"dateFromData===%@",dateFromData);
    return dateFromData;
}


#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _FoodNameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == _FoodNameArray.count-1){
        return 80;
    }
    else
        return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:248/255. green:248/255. blue:248/255. alpha:1.f]];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 5)];
    [leftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    [headerView addSubview:leftLine];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCHomeCardFoodSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCHomeCardFoodSubTableViewCellIdentfiy forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImage *image = [UIImage imageNamed:_FoodImageArray[indexPath.section]];
    
    [cell setFoodImage:image andSetFoodName:_FoodNameArray[indexPath.section] andSetFoodNumber:_FoodNunberArray[indexPath.section] andSetFoodCalories:_FoodCaloriesArray[indexPath.section] andSetDinnerName:_DinnerNameArray[indexPath.section]];
    cell.backgroundColor=[UIColor colorWithRed:248/255. green:248/255. blue:248/255. alpha:1.0];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    //设置前几个的背景颜色 并添加一条灰线
    UIView *commonFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [commonFooterView setBackgroundColor:[UIColor colorWithRed:248/255. green:248/255. blue:248/255. alpha:1.f]];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 5)];
    [leftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    [commonFooterView addSubview:leftLine];
    
    
    //设置最后一个的背景颜色 并添加一条灰线
    UIView *lastFooterView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, tableView.bounds.size.width, 80)];
    [lastFooterView setBackgroundColor:[UIColor colorWithRed:248/255. green:248/255. blue:248/255. alpha:1.f]];
    
    UIView *lastLeftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 80)];
    [lastLeftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    
    //最后一个section的图片按钮
    
    [lastFooterView addSubview:lastLeftLine];
    if(section == _FoodNameArray.count-1){
        return lastFooterView;
    }
    else{
        return commonFooterView;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
