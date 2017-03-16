//
//  WCHomeCardFoodSubViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardFoodSubViewController.h"
#import "WCHomeCardFoodSubTableViewCell.h"
#import "VWWWaterView.h"
#import "WCMulScrollViewController.h"
#import "WCRiliViewController.h"
#import "LocalDBManager.h"
#import "WCMulScrollViewController.h"

static NSString *const WCHomeCardFoodSubTableViewCellIdentify = @"WCHomeCardFoodSubTableViewCellIdentify";

@interface WCHomeCardFoodSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UILabel *todayRemainTakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *datesLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *takeInCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wasteCaloriesLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateButton;
- (IBAction)chooseDateButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic)NSDictionary *foodDic;
@property (strong ,nonatomic)NSMutableArray *foodArr;
@property (strong ,nonatomic)NSArray *FoodImageArray;
@property (strong ,nonatomic)NSArray *FoodNameArray;
@property (strong ,nonatomic)NSArray *FoodNunberArray;
@property (strong ,nonatomic)NSArray *FoodCaloriesArray;
@property (strong ,nonatomic)NSArray *DinnerNameArray;
@property (weak, nonatomic) IBOutlet UIImageView *baseGreenCircleView;
@end

@implementation WCHomeCardFoodSubViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadData];
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = BG_COLOR;
    
    //隐藏navigation
    [self.navigationController setNavigationBarHidden:YES];
    
    [self loadData];
    int takeInCalories = 0;
    if (_foodArr.count != 0) {
        for(int i = 0; i<_foodArr.count; i++){
            takeInCalories += [_foodArr[i][@"calorie"] integerValue];
        }

    }
        self.datesLabel.text = [NSUserDefaults valueWithKey:@"numberOfDay"];
    //设置三个label参数
    [self setBudgetCalories:_budgetCalories];
    [self setTakeInCalories:takeInCalories];
    [self setWasteCalories:[[NSUserDefaults valueWithKey:@"currentWaste"] integerValue]];
    
    _todayRemainTake = _budgetCalories - takeInCalories + [[NSUserDefaults valueWithKey:@"currentWaste"] integerValue];
    _todayRemainTakeLabel.text = [NSString stringWithFormat:@"%ld",_todayRemainTake];
    
    [NSUserDefaults saveValue:[NSNumber numberWithInteger:_budgetCalories] forKey:@"totalCariol"];
    [NSUserDefaults saveValue:[NSNumber numberWithInteger:_todayRemainTake] forKey:@"todayRemainTake"];
    //返回按钮
    [self.returnButton addTarget:self action:@selector(returnToLastView:) forControlEvents:UIControlEventTouchUpInside];
    
    //TableViewCell注册 数据源 委托
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHomeCardFoodSubTableViewCell" bundle:nil] forCellReuseIdentifier:WCHomeCardFoodSubTableViewCellIdentify];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(10, 10, 140, 140)];
    waterView.hotPresent = (CGFloat)_todayRemainTake/_budgetCalories;
    [NSUserDefaults saveValue:[NSNumber numberWithFloat:waterView.hotPresent] forKey:@"homeFood"];
    waterView.layer.cornerRadius = 70.f;
    waterView.layer.masksToBounds = YES;
//    self.layer.cornerRadius  = 10.f;
//    self.layer.masksToBounds = YES;
    [self.baseGreenCircleView addSubview:waterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    
    NSArray *arryUser = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    if ([arryUser[arryUser.count-1][@"tWeight"]  isEqualToString:@"男"]) {
        _budgetCalories = 67 + 13.73*[arryUser[arryUser.count-1][@"tWeight"] floatValue]+5*[arryUser[arryUser.count-1][@"uHeight"] floatValue] - 6.9*21;
    }
    else{
        _budgetCalories = 661 + 9.6*[arryUser[arryUser.count-1][@"tWeight"] floatValue]+1.72*[arryUser[arryUser.count-1][@"uHeight"] floatValue] - 4.7*21;
    }
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    _foodArr = [[NSMutableArray alloc] init];
    
    NSArray *arry = [[LocalDBManager sharedManager] getEverydayFood:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <arry.count; i++) {
        if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
            
            NSString *dinner;
            if ([arry[i][@"time"]  isEqual: @"1"]) {
                dinner = @"早餐";
            }
            else if([arry[i][@"time"]  isEqual:@"2"]){
                dinner = @"午餐";
            }
            else{
                dinner = @"晚餐";
            }
            
            _foodDic = @{
                         
                         @"name":arry[i][@"arrFood"][0][@"fName"],
                         @"image":arry[i][@"arrFood"][0][@"fImg"],
                         @"number":arry[i][@"fAmount"],
                         @"calorie":[NSNumber numberWithFloat:[arry[i][@"fAmount"] floatValue]*[arry[i][@"arrFood"][0][@"fIntake"] floatValue]],
                         @"dinnername":dinner,
                         @"unit":arry[i][@"arrFood"][0][@"fUnit"],
                         @"fNo":arry[i][@"arrFood"][0][@"fNo"],
                         @"fIntake":arry[i][@"arrFood"][0][@"fIntake"],
                         @"fcNo":arry[i][@"fcNo"], 
                          };
        
            [_foodArr addObject:_foodDic];
        }
    }
}

#pragma mark - 三个label字体设置
- (void)setBudgetCalories:(NSInteger
                           )budgetCalories{
    _budgetCalories = budgetCalories;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预算\n%li大卡", (long)self.budgetCalories]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(2, attrStr.length-4)];
    self.budgetCaloriesLabel.attributedText = attrStr;

}

- (void)setTakeInCalories:(NSInteger)takeInCalories{
    _takeInCalories = takeInCalories;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"摄入\n%li大卡", (long)self.takeInCalories]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(2, attrStr.length-4)];
    self.takeInCaloriesLabel.attributedText = attrStr;
}

- (void)setWasteCalories:(NSInteger)wasteCalories{
    _wasteCalories = wasteCalories;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"消耗\n%li大卡", (long)self.wasteCalories]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(2, attrStr.length-4)];
    self.wasteCaloriesLabel.attributedText = attrStr;
}

#pragma  mark - 按钮

- (void)returnToLastView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tap1:(id)sender{
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc]init];
    vc.viewType = 2;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)emptyAdd{
    NSLog(@"em");
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc] init];
    vc.viewType = 2;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_foodArr.count == 0) {
        return 1;
    }
    else{
        return _foodArr.count;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_foodArr.count == 0) {
        return 353;
    }
    else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == _foodArr.count-1){
        return 80;
    }
    else
        return CGFLOAT_MIN;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_foodArr.count == 0) {
        static NSString *identifier=@"noDataCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.backgroundColor = BG_COLOR;
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UIButton *emptyButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 353)];
        [emptyButton addTarget:self action:@selector(emptyAdd) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *emptyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 200, 333)];
        emptyView.image = [UIImage imageNamed:@"foodEmptyView"];
        [emptyButton addSubview:emptyView];
        cell.contentView.backgroundColor  = BG_COLOR;
        [cell.contentView addSubview:emptyButton];
        return cell;

    }
    else{
        WCHomeCardFoodSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCHomeCardFoodSubTableViewCellIdentify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage *image = [UIImage imageNamed:_foodArr[indexPath.section][@"image"]];
        
        [cell setFoodImage:image andSetFoodName:_foodArr[indexPath.section][@"name"] andSetFoodNumber:[NSString stringWithFormat:@"%@%@", _foodArr[indexPath.section][@"number"], _foodArr[indexPath.section][@"unit"]] andSetFoodCalories:[NSString stringWithFormat:@"%@大卡",_foodArr[indexPath.section][@"calorie"]] andSetDinnerName:_foodArr[indexPath.section][@"dinnername"]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc]init];
    vc.viewType = 2;
    vc.fNo = _foodArr[indexPath.section][@"fNo"];
    vc.fIntake =_foodArr[indexPath.section][@"fIntake"];
    vc.fcNo = _foodArr[indexPath.section][@"fcNo"];
    [self presentViewController:vc animated:YES completion:nil];
}

//设置header的背景颜色 并添加一条灰线
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 5)];
    [leftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    [headerView addSubview:leftLine];

    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    //设置前几个的背景颜色 并添加一条灰线
    UIView *commonFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [commonFooterView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 5)];
    [leftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    [commonFooterView addSubview:leftLine];
    
    
    //设置最后一个的背景颜色 并添加一条灰线
    UIView *lastFooterView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, tableView.bounds.size.width, 80)];
    [lastFooterView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    
    UIView *lastLeftLine = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 2.f, 80)];
    [lastLeftLine setBackgroundColor:[UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.f]];
    
    //最后一个section的图片按钮
    UIImage *addFoodButton = [UIImage imageNamed:@"添加饮食按钮"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:addFoodButton];
    imageView.frame = CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 65);
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    [imageView addGestureRecognizer:tapGesturRecognizer];
    
    [lastFooterView addSubview:lastLeftLine];
    [lastFooterView addSubview:imageView];
    if(section == _foodArr.count-1){
        return lastFooterView;
    }
    else{
        return commonFooterView;
    }
}



- (IBAction)chooseDateButton:(UIButton *)sender {
    WCRiliViewController *pv=[[WCRiliViewController alloc]init];
   [self presentViewController:pv animated:YES completion:nil];
}
@end
