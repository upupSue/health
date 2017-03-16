//
//  WCSportDetailViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCSportDetailViewController.h"
#import "WaterView.h"
#import "WalkMapViewController.h"
#import "LocalDBManager.h"
#import "WCMulScrollViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface WCSportDetailViewController (){
    UIScrollView *scrollView;
    
    UILabel *dateLabel;
    NSDate *nowDate;
    
    NSInteger addInterval;
    NSInteger subInterval;
    UIButton *continueBtn;
    UILabel *continueBtnLabel;
    UILabel *timeLabel;
    NSTimer *timer;
    NSInteger time;
    BOOL flag;
    BOOL startFlag;
    
    CMMotionManager *manager;//创建运动管理对象
    NSInteger chinCount;//引体向上计数
}

@end

@implementation WCSportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    startFlag = 0;
    flag = 0;
    time = 0;
    /******************  运动详情页面  *********************/
    
    //设置ScrollView
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 635.f);
    scrollView.backgroundColor = DEEPBLUE_COLOR;
    [self.view addSubview:scrollView];
    
    //设置返回按钮和垃圾箱按钮
    [self setReturnButtonAndTrashButton];
    [self setDateView];
    [self setCircle];
    [self setButton];
    [self setLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chinSport{
    //创建管理对象
    manager= [[CMMotionManager alloc]init];
    //    manager.gyroUpdateInterval = 1;
    //    [manager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
    //        NSLog(@"gyro %f,%f,%f\n",manager.gyroData.rotationRate.x,manager.gyroData.rotationRate.y,manager.gyroData.rotationRate.z);
    //    }];
    
    manager.accelerometerUpdateInterval = 1;
    //在当前线程中回调
    [manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        NSLog(@"acce %f,%f,%f\n",manager.accelerometerData.acceleration.x,manager.accelerometerData.acceleration.y,manager.accelerometerData.acceleration.z);
        if(manager.accelerometerData.acceleration.y < -1.0){
            flag = 1;
        }
        if(manager.accelerometerData.acceleration.y > -0.97&& flag == 1){
            flag = 0;
            chinCount++;
        }
    }];
}

#pragma mark setView
//
- (void)setReturnButtonAndTrashButton{
    //button
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 33, 25, 22)];
    [returnBtn setImage:[UIImage imageNamed:@"arrow-thin-left"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToView) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:returnBtn];
    
    UIButton *trashBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-25, 33, 25, 22)];
    [trashBtn setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
    [trashBtn addTarget:self action:@selector(moveToTrash) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:trashBtn];
}

//
- (void)setDateView{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    nowDate = [NSDate date];
    [dateFormatter setDateFormat:@"yy·MM·dd"];
    
    //日期label
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 32, 100, 20)];
    dateLabel.font = [UIFont fontWithName:PINGFANG size:18.f];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nowDate]];
    [scrollView addSubview:dateLabel];
    
    UIButton *subDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50 -20, 35, 10, 15)];
    [subDateBtn setImage:[UIImage imageNamed:@"subDate_white"] forState:UIControlStateNormal];
    [subDateBtn addTarget:self action:@selector(subDate) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:subDateBtn];
    
    UIButton *addDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 50 +10, 35, 10, 15)];
    [addDateBtn setImage:[UIImage imageNamed:@"addDate_white"] forState:UIControlStateNormal];
    [addDateBtn addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addDateBtn];
}

- (void)setCircle{
    UIImageView *outCircleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(29, 159, SCREEN_WIDTH-58, SCREEN_WIDTH-58)];
    [outCircleImageView setImage:[UIImage imageNamed:@"out_Circel_SportItem"]];
    [scrollView addSubview:outCircleImageView];
    
    UIImageView *inCircleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45, 174, SCREEN_WIDTH-90, SCREEN_WIDTH-90)];
    [inCircleImageView setImage:[UIImage imageNamed:@"in_Circel_SportItem"]];
    [scrollView addSubview:inCircleImageView];
    
    WaterView *waterView = [[WaterView alloc]initWithFrame:CGRectMake(-8,-8,inCircleImageView.size.width+15,inCircleImageView.size.width+15)];
    waterView.sportPersnet = _progress;
    [inCircleImageView addSubview:waterView];
}

- (void)setButton{
    //设置底下按钮
    
    if ([self.name  isEqual: @"慢跑"]||[self.name  isEqual: @"快跑"]||[self.name  isEqual: @"散步"]||[self.name  isEqual: @"快走"]) {
        continueBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, SCREEN_HEIGHT-80, SCREEN_WIDTH - 25 - 205, 60)];
        [continueBtn addTarget:self action:@selector(continueBtn) forControlEvents:UIControlEventTouchUpInside];
        continueBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 25 - 205)/2-25, 16, 50, 28)];
        
        UIButton *mapBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 195, SCREEN_HEIGHT-80, 80, 60)];
        [mapBtn addTarget:self action:@selector(enterMap) forControlEvents:UIControlEventTouchUpInside];
        mapBtn.backgroundColor = [UIColor whiteColor];
        mapBtn.layer.cornerRadius = 10.f;
        mapBtn.layer.masksToBounds = YES;
        mapBtn.layer.borderWidth = 1.f;
        mapBtn.layer.borderColor = DEEPBLUE_COLOR.CGColor;
        
        UIImageView *mapIma = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, 30, 30)];
        [mapIma setImage:[UIImage imageNamed:@"map_button"]];
        [mapBtn addSubview:mapIma];
        
        [scrollView addSubview:mapBtn];
    }
    else{
        continueBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, SCREEN_HEIGHT-80, SCREEN_WIDTH - 25 - 115, 60)];
        [continueBtn addTarget:self action:@selector(continueBtn) forControlEvents:UIControlEventTouchUpInside];
        continueBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 25 - 105)/2-25, 16, 50, 28)];
        
    }
    continueBtnLabel.textColor = DEEPBLUE_COLOR;
    continueBtnLabel.text = @"开始";
    continueBtnLabel.font = [UIFont systemFontOfSize:20];
    continueBtnLabel.textAlignment = NSTextAlignmentCenter;
    [continueBtn addSubview:continueBtnLabel];
    continueBtn.backgroundColor = [UIColor whiteColor];
    continueBtn.layer.cornerRadius = 10.f;
    continueBtn.layer.masksToBounds = YES;
    continueBtn.layer.borderWidth = 1.f;
    continueBtn.layer.borderColor = DEEPBLUE_COLOR.CGColor;
    [scrollView addSubview:continueBtn];
    
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105, SCREEN_HEIGHT-80, 80, 60)];
    [changeBtn addTarget:self action:@selector(changeBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *changeBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(80/2-32, 16, 64, 28)];
    changeBtnLabel.textColor = DEEPBLUE_COLOR;
    changeBtnLabel.numberOfLines = 2;
    changeBtnLabel.text = @"修改目标";
    changeBtnLabel.font = [UIFont systemFontOfSize:14];
    changeBtnLabel.textAlignment = NSTextAlignmentCenter;
    [changeBtn addSubview:changeBtnLabel];
    changeBtn.backgroundColor = [UIColor whiteColor];
    changeBtn.layer.cornerRadius = 10.f;
    changeBtn.layer.masksToBounds = YES;
    changeBtn.layer.borderWidth = 1.f;
    changeBtn.layer.borderColor = DEEPBLUE_COLOR.CGColor;
    [scrollView addSubview:changeBtn];
}

- (void)setLabel{
    //设置运动的种类的label
    UILabel *sportLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-180)/2, 82, 180, 44)];
    sportLabel.attributedText = [self sportLabel:_name Target:_target Unit:_unit];
    sportLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:sportLabel];
    
    //完成了多少百分比的label
    UILabel *persentLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 225, 200, 100)];
    persentLabel.text = [NSString stringWithFormat:@"%.0f%%",_progress*100];
    persentLabel.font = [UIFont fontWithName:NUM_FONT_NAME size:100];
    persentLabel.textColor = [UIColor whiteColor];
    persentLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:persentLabel];
    
    //完成了多少的label
    UILabel *finishLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 360, 100, 66)];
    finishLabel.numberOfLines = 2;
    finishLabel.attributedText = [self finishLabel:_complete Unit:_unit];
    finishLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:finishLabel];
    
    //运动时间的label
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, SCREEN_HEIGHT -161, 100, 52)];
    timeLabel.numberOfLines = 2;
    timeLabel.attributedText = [self timeLabel:@"00:00:00"];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:timeLabel];
    
    //消耗卡路里label
    UILabel *wasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, SCREEN_HEIGHT -161, 100, 52)];
    wasteLabel.numberOfLines = 2;
    wasteLabel.attributedText = [self wasteLabel:[_target floatValue]*[_waste floatValue]];
    wasteLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wasteLabel];

    
}

- (void)sendMessage{
    time++;
    
    long long hour,min,sec;
    hour = time/3600;
    min = time%3600/60;
    sec = time%60;
    
    timeLabel.attributedText = [self timeLabel:[NSString stringWithFormat:@"%02lld:%02lld:%02lld",hour,min,sec]];
}

#pragma mark button action

- (void)returnToView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)moveToTrash{
    NSLog(@"moveToTrash");
    [[LocalDBManager sharedManager] deleteTodaySport:[self.scNo intValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)subDate{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)addDate{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)continueBtn{
    //第一次点击开始 开始计时 button变暂停
    if (!startFlag) {
        startFlag = 1;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(sendMessage)
                                               userInfo:nil
                                                repeats:YES];
        continueBtnLabel.text = @"暂停";
    }
    //以后都是进这里
    else{
        if (!flag) {
            continueBtnLabel.text = @"继续";
            flag = 1;
            [timer invalidate];
            NSLog(@"%li",(long)time);
        }
        else{
            continueBtnLabel.text = @"暂停";
            flag = 0;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                     target:self
                                                   selector:@selector(sendMessage)
                                                   userInfo:nil
                                                    repeats:YES];
            NSLog(@"%li",(long)time);
            
        }

    }
    
}

- (void)changeBtn{
    NSLog(@"changeBtn");
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc] init];
    vc.viewType = 1;
    vc.fNo = self.sNo;
    vc.fcNo = self.scNo;
    vc.waste = self.waste;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)enterMap{
    WalkMapViewController *vc = [[WalkMapViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
    [dateFormatter setDateFormat:@"yy·MM·dd"];
    NSDate *date = [dateFormatter dateFromString:dateLabel.text];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy·MM·dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateFromData = [formatter stringFromDate:newdate];
    //    NSLog(@"dateFromData===%@",dateFromData);
    return dateFromData;
}
#pragma mark MutableAttributedString

- (NSMutableAttributedString *)sportLabel:(NSString*)sport Target:(NSString*)aTarget Unit:(NSString*)aUnit{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@",sport,aTarget,aUnit]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:25.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(sport.length, attrStr.length - sport.length-aUnit.length)];
    return attrStr;
}

- (NSMutableAttributedString *)finishLabel:(NSString*)finish Unit:(NSString*)bUnit{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已完成\n%@%@", finish, bUnit]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:14.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(3, attrStr.length -3 -bUnit.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:20.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, 3)];
    return attrStr;
}


- (NSMutableAttributedString *)timeLabel:(NSString*)atime{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc
                                           ] initWithString:[NSString stringWithFormat:@"时间\n%@",atime]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(2, attrStr.length-2)];
    return attrStr;
}

- (NSMutableAttributedString *)wasteLabel:(float)aWaste{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预计消耗\n%.0f大卡",aWaste]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(4, attrStr.length-6)];
    return attrStr;
}

@end
