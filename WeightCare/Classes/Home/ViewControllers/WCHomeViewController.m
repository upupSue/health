//
//  WCHomeViewController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeViewController.h"
#import "WCHomeCardSwitchView.h"
#import "WCHealthDataManager.h"
#import "WCHomeBarChartView.h"
#import "WCHomeModel.h"

#import "WCHomeCardFoodSubViewController.h"
#import "WCHomeCardWeightSubViewController.h"
#import "WCHomeCardSportSubViewController.h"

#import "WCPersonalInfoViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "LocalDBManager.h"
#import "WCHealthDataManager.h"
@interface WCHomeViewController ()
<
WCHomeCardSwitchViewDelegate,WCSessionDelegate
>{
    NSTimer *timer;
    NSArray *stepArray;
    
    NSInteger targetWaste;
    int targetPersent;
    int tWeight;
    
    NSString *homeFood;
}

@property (nonatomic, strong) WCHomeModel *homeModel;

@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) WCHomeCardSwitchView *cardSwitchView;

@property (nonatomic, strong) UIView *stickPlotView;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *monthWeekLabel;
@property (nonatomic, strong) UILabel *stepCountLabel;
@property (nonatomic, strong) WCHomeBarChartView *barChartView;

@property (strong ,nonatomic)NSDictionary *sportDic;
@property (strong ,nonatomic)NSMutableArray *sportArr;
@property (strong ,nonatomic)NSDictionary *foodDic;
@property (strong ,nonatomic)NSMutableArray *foodArr;

@end

@implementation WCHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_cardSwitchView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断本地保存的体重是否有值，没有则添加一个
    if([NSUserDefaults valueWithKey:@"currectWeight"] == nil){
        [NSUserDefaults saveValue:@"82" forKey:@"currectWeight"];
    }
    
    //读取数据库数据
    [self setArray];
    
    /******************  WCHealthDataManager *********************/
    
    [[WCHealthDataManager shareManager] registerUseHealthKit];
    
    // 去除导航栏下部的灰色分割线
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    self.view.backgroundColor = RGB(236, 236, 236);
    
    // 卡片选择
    [self.cardSwitchView reloadData];
    
    // 柱状图区域
    NSDate *today = [NSDate date];
    self.dayLabel.text = [NSString stringWithFormat:@"%ld", (long)today.day];
    self.monthWeekLabel.text = [self p_monthWeekLabelText];
    
    //查询当日步数
    //调用的是IHealth里的数据
    @weakify(self)
    [self.homeModel queryTodayStepCountFromHealthKit:^(NSAttributedString *attrStr) {
        @strongify(self)
        self.stepCountLabel.attributedText = attrStr;
    }];
    
    // 加载柱状图
    //调用的是IHealth里的数据
    [self.homeModel queryThisWeekStepCountFromHealthKit:^(NSDictionary *result) {
        if (result[@"stepCount"] == nil) {
            UIImageView *barCharEmptyView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 284)/2, SCREEN_WIDTH , 284, 113)];
            barCharEmptyView.image = [UIImage imageNamed:@"barCharEmptyView"];
            [self.view addSubview:barCharEmptyView];
        }
        else{
            [self.barChartView loadData:result[@"stepCount"] xAxisTitle:result[@"date"]];
            stepArray = [result[@"stepCount"] copy];
        }
        
        //首页发送数据给watch
        //跳转首页后先执行sendMessage 先发一遍数据
        //stepArray里储存的是healthKit里获取的步数 这里做了个保护 如果stepArray数组小于7 则不执行传数据给iWatch
        if (stepArray.count >=7) {
            [self sendMessage];
        }
    }];
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@",fontName);
        }
    }
    
    //同上 对其做一个保护
    if(stepArray.count >=7){
        //然后是一小时发一次 这里可以设置scheduledTimerWithTimeInterval来改变频率
        timer = [NSTimer scheduledTimerWithTimeInterval:360.0f
                                                 target:self
                                               selector:@selector(sendMessage)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    ///healthKit
    //查询当日心率
    [self.homeModel queryHeartRateFromHealthKit:^(NSNumber *heartRate) {
        NSLog(@"%@",heartRate);
    }];
    
    //本地保存运动天数
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    int date = [str intValue] - 13;
    [NSUserDefaults saveValue:[NSString stringWithFormat:@"%d",date] forKey:@"numberOfDay"];
    
    
}


/*
 发数据给iWatch代码
 */
-(void)sendMessage
{
    NSLog(@"watch sendMessage");
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;//即使没有写相关事件，也必须赋值delegate
    [session activateSession];

    //Protect
    if (homeFood==nil){
        homeFood=@"100"; //default value
    }
    
    //在后台发送的数据，具体发什么数据参照ExtensionDelegate.m里面存储的HealthyInfo数据
    [session updateApplicationContext:@{@"walk":@[stepArray[stepArray.count-7],stepArray[stepArray.count-6],stepArray[stepArray.count-5],stepArray[stepArray.count-4],stepArray[stepArray.count-3],stepArray[stepArray.count-2],stepArray[stepArray.count-1]] , @"sport":[NSString stringWithFormat:@"%d",targetPersent] , @"eat":homeFood, @"maxEat":@100 , @"weight":[NSString stringWithFormat:@"%d",tWeight] , @"maxWeight" : @100} error:nil];
        
    //在前台发送的数据
    [session sendMessage:@{@"walk":@[stepArray[stepArray.count-7],stepArray[stepArray.count-6],stepArray[stepArray.count-5],stepArray[stepArray.count-4],stepArray[stepArray.count-3],stepArray[stepArray.count-2],stepArray[stepArray.count-1]] , @"sport":[NSString stringWithFormat:@"%d",targetPersent] , @"eat":homeFood, @"maxEat":@100 , @"weight":[NSString stringWithFormat:@"%d",tWeight] , @"maxWeight" : @100} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            
    } errorHandler:^(NSError * _Nonnull error) {
            
    }];
    
}


- (void)setArray{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    _sportArr = [[NSMutableArray alloc] init];
    NSArray *arry = [[LocalDBManager sharedManager] getEverydaySport:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = 0; i <arry.count; i++) {
        if ([arry[i][@"date"] isEqualToString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]]]) {
            
            _sportDic = @{
                          @"progress":[NSNumber numberWithFloat:[arry[i][@"sComplete"] floatValue]/[arry[i][@"sTarget"] floatValue]]
                          ,
                          };
            targetWaste = [arry[i][@"sTarget"] integerValue]*[arry[i][@"arrSport"][0][@"sConsume"] integerValue];
    
            [_sportArr addObject:_sportDic];
        }
    }
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
    
    //设置Label的参数
    NSArray *arr = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    float currectWeight;
    if([NSUserDefaults valueWithKey:@"currectWeight"]  == nil){
        currectWeight = 0;
    }
    else{
        currectWeight = [[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
    }
    
    float beginWeight = [arr[0][@"sWeight"] floatValue];
    float targetWeight = [arr[0][@"tWeight"] floatValue];
    if ((beginWeight - targetWeight)!=0) {
        tWeight = (int)(currectWeight - targetWeight)/(beginWeight - targetWeight)*100;
    }
    else{
        tWeight = 0;
    }
    homeFood = [NSUserDefaults valueWithKey:@"homeFood"];
    //Protect
    if (homeFood==nil){
        homeFood=@"100"; //default value
    }
}

#pragma mark - WCHomeCardSwitchViewDelegate

- (NSArray<NSDictionary *> *)wcHomeCardSwitchViewDataSource:(WCHomeCardSwitchView *)switchView {
    return [self.homeModel homeSwitchCardDataSource];
}

- (void)wcHomeCardSwitchViewClickIndex:(NSInteger)index {
    WCHomeCardManagerEnum type = (WCHomeCardManagerEnum)[[self.homeModel homeSwitchCardDataSource][index][@"cardType"] integerValue];
    
    switch (type) {
        case WCHomeCardManagerEnumAdd: {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_DISPLAYNAME message:@"添加管理卡片" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* sportAction = [UIAlertAction actionWithTitle:@"运动管理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self p_processAddCard:WCHomeCardManagerEnumSport];
            }];
            UIAlertAction* foodAction = [UIAlertAction actionWithTitle:@"饮食管理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self p_processAddCard:WCHomeCardManagerEnumFood];
            }];
            UIAlertAction* weightAction = [UIAlertAction actionWithTitle:@"体重记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self p_processAddCard:WCHomeCardManagerEnumWeight];
            }];
            [alert addAction:cancelAction];
            [alert addAction:sportAction];
            [alert addAction:foodAction];
            [alert addAction:weightAction];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case WCHomeCardManagerEnumSport: {
            WCHomeCardSportSubViewController *sportSubView = [[WCHomeCardSportSubViewController alloc] init];
            [self presentViewController:sportSubView animated:YES completion:nil];
            break;
        }
        case WCHomeCardManagerEnumFood: {
            WCHomeCardFoodSubViewController * foodSubView = [[WCHomeCardFoodSubViewController alloc] init];
            [self presentViewController:foodSubView animated:YES completion:nil];
            break;
        }
        case WCHomeCardManagerEnumWeight: {
            WCHomeCardWeightSubViewController *weightSubView = [[WCHomeCardWeightSubViewController alloc] init];
            [self presentViewController:weightSubView animated:YES completion:nil];
            break;
        }
    }

}


#pragma mark - Getter

- (WCHomeModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [WCHomeModel new];
    }
    return _homeModel;
}

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = ({
            UIView *view = [[UIView alloc] init];
            UIImageView *avatarImageView = [[UIImageView alloc] init];
            avatarImageView.image = [UIImage imageNamed:@"icon_avatarPlaceholder"];
            avatarImageView.layer.cornerRadius  = 15.f;
            avatarImageView.layer.masksToBounds = YES;
            [view addSubview:avatarImageView];
            [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
                make.right.equalTo(view);
                make.centerY.equalTo(view);
            }];
            NSArray *arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
            UILabel *label = [[UILabel alloc] init];
            label.text = arry[0][@"uName"];
            label.font = [UIFont systemFontOfSize:18.f];
            label.textColor = GRAY_COLOR;
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(avatarImageView.mas_left).offset(-10.f);
                make.centerY.equalTo(view);
            }];
            [view sizeToFit];
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        });
    }
    return _rightBarButtonItem;
}

- (WCHomeCardSwitchView *)cardSwitchView {
    if (!_cardSwitchView) {
        _cardSwitchView = ({
            WCHomeCardSwitchView *view = [[WCHomeCardSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (self.view.height - TABBAR_HEIGHT) / 2.f)];
            view.delegate = self;
            [self.view addSubview:view];
            view;
        });
    }
    return _cardSwitchView;
}

- (UIView *)stickPlotView {
    if (!_stickPlotView) {
        _stickPlotView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.cardSwitchView.bottom, SCREEN_WIDTH, self.view.height - self.cardSwitchView.height - TABBAR_HEIGHT - NAVGATIONBAR_HEIGHT)];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
            view;
        });
    }
    return _stickPlotView;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:NUM_FONT_NAME size:40.f];
            label.textColor = BLUE_COLOR;
            [self.stickPlotView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.stickPlotView).offset(10.f);
                make.top.equalTo(self.stickPlotView).offset(10.f);
            }];
            label;
        });
    }
    return _dayLabel;
}

- (UILabel *)monthWeekLabel {
    if (!_monthWeekLabel) {
        _monthWeekLabel = ({
            UILabel *label = [[UILabel alloc] init];;
            label.font = [UIFont systemFontOfSize:12.f];
            label.textColor = RGBA(148, 148, 148, 1);
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentCenter;
            [self.stickPlotView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dayLabel.mas_right).offset(5.f);
                make.centerY.equalTo(self.dayLabel);
            }];
            label;
        });
    }
    return _monthWeekLabel;
}

- (UILabel *)stepCountLabel {
    if (!_stepCountLabel) {
        _stepCountLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [self.stickPlotView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.stickPlotView.mas_right).offset(-10.f);
                make.top.equalTo(self.stickPlotView).offset(10.f);
            }];
            label;
        });
    }
    return _stepCountLabel;
}

- (WCHomeBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = ({
            WCHomeBarChartView *view = [[WCHomeBarChartView alloc] init];
            [self.stickPlotView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.dayLabel.mas_bottom);
                make.left.equalTo(self.stickPlotView).offset(20);
                make.right.equalTo(self.stickPlotView).offset(-20);
                make.bottom.equalTo(self.stickPlotView).offset(-5);
            }];
            view;
        });
    }
    return _barChartView;
}


#pragma mark - Pravite

- (void)p_showActionSheet {

}

- (NSString *)p_monthWeekLabelText {
    NSDate *today = [NSDate date];
    NSString *weekStr;
    switch (today.weekday) {
        case 1:
            weekStr = @"周日";
            break;
        case 2:
            weekStr = @"周一";
            break;
        case 3:
            weekStr = @"周二";
            break;
        case 4:
            weekStr = @"周三";
            break;
        case 5:
            weekStr = @"周四";
            break;
        case 6:
            weekStr = @"周五";
            break;
        case 7:
            weekStr = @"周六";
            break;
        default:
            weekStr = @"";
            break;
    }
    return [NSString stringWithFormat:@"%ld月\n%@", (long)today.month, weekStr];
}

- (void)p_processAddCard:(WCHomeCardManagerEnum)type {
    if (![self.homeModel validateHomeSwitchCardUsed:type]) {
        if ([self.homeModel addHomeSwitchCard:type]) {
            [self.cardSwitchView reloadData];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:APP_DISPLAYNAME message:@"添加失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
            [NSTimer scheduledTimerWithTimeInterval:ALERT_TIME block:^(NSTimer * _Nonnull timer) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            } repeats:NO];

            [self presentViewController:alert animated:YES completion:nil];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:APP_DISPLAYNAME message:@"卡片已存在，请勿重复添加" preferredStyle:UIAlertControllerStyleAlert];
        [NSTimer scheduledTimerWithTimeInterval:ALERT_TIME block:^(NSTimer * _Nonnull timer) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        } repeats:NO];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end
