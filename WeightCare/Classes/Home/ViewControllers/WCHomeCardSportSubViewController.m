//
//  WCHomeCardSportSubViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardSportSubViewController.h"
#import "WCHomeCardSportTableViewCell.h"
#import "VWaterView.h"
#import "WCMulScrollViewController.h"
#import "WCSportDetailViewController.h"
#import "LocalDBManager.h"
#import "WCMulScrollViewController.h"
#import "WCRiliViewController.h"
static NSString *const WCHomeCardSportTableViewCellIdentify = @"WCHomeCardSportTableViewCellIdentify";

@interface WCHomeCardSportSubViewController ()<UITableViewDelegate, UITableViewDataSource>{
    int targetPersent;
    NSInteger targetWaste;
    NSInteger currentWaste;
    NSInteger nowWaste;
}
@property (weak, nonatomic) IBOutlet UIButton *returnToLastViewButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *preWasteLabel;
@property (weak, nonatomic) IBOutlet UILabel *todaysTargetLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong ,nonatomic)NSDictionary *sportDic;
@property (strong ,nonatomic)NSMutableArray *sportArr;
@property (strong ,nonatomic)NSMutableArray *sNoArr;

@property (strong ,nonatomic)NSArray *sportImageArray;
@property (strong ,nonatomic)NSArray *sportTextArray;
@property (strong ,nonatomic)NSArray *sportProgressArray;

@property (weak, nonatomic) IBOutlet UIImageView *blueCircleView;

@end

@implementation WCHomeCardSportSubViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadData];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sNoArr = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BG_COLOR;
    //隐藏navigation
    [self.navigationController setNavigationBarHidden:YES];
    //储存一个判断值，判断是否读取本地地图 用于map页面
    [NSUserDefaults saveValue:@"0" forKey:@"isMapHistory"];
    //按钮
    [self.returnToLastViewButton addTarget:self action:@selector(returnToLastView:) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseDateButton addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];

    [self loadData];
    //设置label参数
    targetPersent = 0;
    for(int i = 0; i<_sportArr.count; i++){
        targetPersent += [_sportArr[i][@"progress"] floatValue]*100;
    }
    if (_sportArr.count == 0) {
        targetPersent = 0;
    }
    else{
        targetPersent = targetPersent/_sportArr.count;
    }
    [NSUserDefaults saveValue:[NSNumber numberWithInteger:targetPersent] forKey:@"sportPersent"];
    [NSUserDefaults saveValue:[NSNumber numberWithInteger:currentWaste] forKey:@"currentWaste"];
    [self setTodayTargetPersent: targetPersent];
    [self setPreWaste: targetWaste];
    [self setSportDate: [[NSUserDefaults valueWithKey:@"numberOfDay"] intValue]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHomeCardSportTableViewCell" bundle:nil] forCellReuseIdentifier:WCHomeCardSportTableViewCellIdentify];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setCircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
     _sportArr = [[NSMutableArray alloc] init];
     NSArray *arry = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <arry.count; i++) {
        if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
            
            _sportDic = @{
                         @"image":arry[i][@"arrSport"][0][@"sImg"],
                         @"text":[self sportName:arry[i][@"arrSport"][0][@"sName"] sTarget:[arry[i][@"sTarget"] integerValue] unit:arry[i][@"arrSport"][0][@"sUnit"]],
                         @"progress":[NSNumber numberWithFloat:[arry[i][@"sComplete"] floatValue]/[arry[i][@"sTarget"] floatValue]],
                         
                         @"sportName":[NSString stringWithFormat:@"%@%@%@",arry[i][@"arrSport"][0][@"sName"],arry[i][@"sTarget"],arry[i][@"arrSport"][0][@"sUnit"]],
                         
                         @"name":arry[i][@"arrSport"][0][@"sName"],
                         @"target":arry[i][@"sTarget"],
                         @"unit":arry[i][@"arrSport"][0][@"sUnit"],
                         @"complete":arry[i][@"sComplete"],
                         @"waste":arry[i][@"arrSport"][0][@"sConsume"],
                         @"sNo":arry[i][@"sNo"],
                         @"scNo":arry[i][@"scNo"],
                         };
            targetWaste += [arry[i][@"sTarget"] integerValue]*[arry[i][@"arrSport"][0][@"sConsume"] integerValue];
            currentWaste += [arry[i][@"sComplete"] integerValue]*[arry[i][@"arrSport"][0][@"sConsume"] integerValue];
            
            [_sportArr addObject:_sportDic];
            [_sNoArr addObject:_sportDic[@"sNo"]];
        }
    }
}

- (void)setCircle{
    VWaterView *waterView = [[VWaterView alloc]initWithFrame:self.blueCircleView.bounds];
    waterView.sportPersnet = (double)targetPersent/100;
    [_blueCircleView addSubview:waterView];
}


#pragma  mark - 按钮

- (void)returnToLastView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chooseDate:(id)sender{
    WCRiliViewController *pv=[[WCRiliViewController alloc]init];
    [self presentViewController:pv animated:YES completion:nil];
}

- (void)tapGestur:(id)sender{
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc] init];
    vc.viewType = 1;
    vc.ssNo = _sNoArr;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)emptyAdd{
    NSLog(@"em");
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc] init];
    vc.viewType = 1;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 设置label的富文本和内容

- (void)setTodayTargetPersent:(int)todayTargetPersent{
    _todayTargetPersent = todayTargetPersent;
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i%%", self.todayTargetPersent]];
    [attrStr1 addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:35.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr1.length)];
    
    self.todaysTargetLabel.attributedText = attrStr1;
}

- (void)setPreWaste:(NSInteger)preWaste{
    _preWaste = preWaste;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li大卡", (long)self.preWaste]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length-2)];
    self.preWasteLabel.attributedText = attrStr;
}

- (void)setSportDate:(int)sportDate{
    _sportDate = sportDate;
    NSString *date = [NSString stringWithFormat:@"%i",self.sportDate];
    self.dateLabel.text = date;
}

- (NSMutableAttributedString *)sportName:(NSString*)sportName sTarget:(NSInteger)target unit:(NSString*)unit{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%li%@", sportName,(long)target,unit]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor grayColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : DEEPBLUE_COLOR
                             } range:NSMakeRange(sportName.length, attrStr.length-sportName.length-unit.length)];
    return attrStr;
}

- (NSMutableAttributedString *)yaling:(int)way{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"举哑铃 %i 个", way]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor grayColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : DEEPBLUE_COLOR
                             } range:NSMakeRange(3, attrStr.length-4)];
    return attrStr;
}

- (NSMutableAttributedString *)zixingche:(int)way{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"骑自行车 %i 小时", way]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor grayColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : DEEPBLUE_COLOR
                             } range:NSMakeRange(4, attrStr.length-6)];
    return attrStr;
}

- (NSMutableAttributedString *)yujia:(int)way{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"瑜伽 %i 分钟", way]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor grayColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : DEEPBLUE_COLOR
                             } range:NSMakeRange(2, attrStr.length-4)];
    return attrStr;
}

#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_sportArr.count == 0) {
        return 1;
    }
    else{
        return _sportArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_sportArr.count == 0) {
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
    if(section == _sportArr.count-1){
        return 80;
    }
    else
        return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_sportArr.count == 0) {
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
        emptyView.image = [UIImage imageNamed:@"sportEmptyView"];
        [emptyButton addSubview:emptyView];
        cell.contentView.backgroundColor  = BG_COLOR;
        [cell.contentView addSubview:emptyButton];
        return cell;
    }
    else{
        WCHomeCardSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCHomeCardSportTableViewCellIdentify forIndexPath:indexPath];
        UIImage *image = [UIImage imageNamed:_sportArr[indexPath.section][@"image"]];
        float progress = [_sportArr[indexPath.section][@"progress"] floatValue];
        [cell setSportImage:image andNameTextLabel:_sportArr[indexPath.section][@"text"] andPresent:progress];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
}

//设置header的背景颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    //设置前几个的背景颜色
    UIView *commonFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    
    [commonFooterView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    
    
    //设置最后一个的背景颜色
    UIView *lastFooterView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, tableView.bounds.size.width, 80)];
    [lastFooterView setBackgroundColor:[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.f]];
    
    //最后一个section的图片按钮
    UIImage *addFoodButton = [UIImage imageNamed:@"添加饮食按钮"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:addFoodButton];
    imageView.frame = CGRectMake((SCREEN_WIDTH-200)/2, 5, 200, 65);
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestur:)];
    [imageView addGestureRecognizer:tapGesturRecognizer];
    
    [lastFooterView addSubview:imageView];
    if(section == _sportArr.count-1){
        return lastFooterView;
    }
    else{
        return commonFooterView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WCSportDetailViewController *vc = [[WCSportDetailViewController alloc]init];
    vc.progress = [_sportArr[indexPath.section][@"progress"] floatValue];
    vc.name = _sportArr[indexPath.section][@"name"];
    vc.target = _sportArr[indexPath.section][@"target"];
    vc.unit = _sportArr[indexPath.section][@"unit"];
    vc.complete = _sportArr[indexPath.section][@"complete"];
    vc.waste = _sportArr[indexPath.section][@"waste"];
    vc.scNo = _sportArr[indexPath.section][@"scNo"];
    vc.sNo = _sportArr[indexPath.section][@"sNo"];
    [self presentViewController:vc animated:YES completion:nil];
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}




@end
