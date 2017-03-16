//
//  WCHomeCardWeightSubViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardWeightSubViewController.h"
#import "WCMulScrollViewController.h"
#import "LocalDBManager.h"
#import "WCRiliViewController.h"
@interface WCHomeCardWeightSubViewController (){
    NSArray *arry;
}

@property (weak, nonatomic) IBOutlet UIButton *returnToLastView;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *addNewWeightButton;
@property (weak, nonatomic) IBOutlet UILabel *targetWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentWeightLabel;

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLeadingViewLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewWeight;
- (IBAction)calendarButton:(UIButton *)sender;

@property (strong ,nonatomic)NSDictionary *weightDic;
@property (strong ,nonatomic)NSMutableArray *weightArr;
@property (strong ,nonatomic)NSMutableArray *dateArr;
@end

@implementation WCHomeCardWeightSubViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏navigation
    [self.navigationController setNavigationBarHidden:YES];
    
    //判断蓝牙秤是否连接
//    [self judgeBlueTooth];
    if (self.blueToothType == 1) {
        _addNewWeightButton.hidden = YES;
        UIButton *addNewButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -30, 184, 60, 50)];
        [addNewButton addTarget:self action:@selector(blueTooth) forControlEvents:UIControlEventTouchUpInside];
        [addNewButton setImage:[UIImage imageNamed:@"蓝牙称按钮"] forState:UIControlStateNormal];
    }
    
    //按钮
    [self.returnToLastView addTarget:self action:@selector(returnToLastView:) forControlEvents:UIControlEventTouchUpInside];
    [self.addNewWeightButton addTarget:self action:@selector(addNewWeightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarButton addTarget:self action:@selector(chooseCalendar:) forControlEvents:UIControlEventTouchUpInside];

    [self loadData];
    [self setDate];
    
//    [self setChartView];
    graph=[MPPlot plotWithType:MPPlotTypeGraph frame:CGRectMake(0,SCREEN_HEIGHT-312, SCREEN_WIDTH, 312)];

    
    //    紫色曲线图
    graph3=[[MPGraphView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT- 312, SCREEN_WIDTH, 312)];
    
    graph3.waitToUpdate=YES;
    graph3.values = _weightArr;
    graph3.dateArray = _dateArr;
    
    graph3.graphColor=[UIColor colorWithRed:255/255.0 green:75/255.0 blue:75/255.0 alpha:1];
    graph3.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    
    graph3.curved=YES;
    
    
    //    橘色曲线填充图
    graph4=[[MPGraphView alloc] initWithFrame:graph3.frame];
    graph4.values = _weightArr;
    graph4.dateArray = _dateArr;
    graph4.fillColors=@[[UIColor whiteColor],[UIColor whiteColor]];
    graph4.graphColor=[UIColor colorWithRed:255/255.0 green:75/255.0 blue:75/255.0 alpha:1];
    graph4.curved=YES;
    [self.view addSubview:graph4];
    [self.view addSubview:graph3];
    
    
    self.view.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];

    //单位label
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 263, 60, 20)];
    unitLabel.text = @"单位: Kg";
    unitLabel.textColor = RGBA(148, 148, 148, 1.f);
    unitLabel.font = [UIFont fontWithName:PINGFANG size:14.f];
    
    [self.view addSubview:unitLabel];
    
    //提示label
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, SCREEN_HEIGHT-40, 160, 20)];
    tipLabel.text = @"早晨称体重更准确哦！";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = RGBA(148, 148, 148, 1.f);
    tipLabel.font = [UIFont fontWithName:PINGFANG size:14.f];
    
    [self.view addSubview:tipLabel];

    // Do any additional setup after loading the view from its nib.
}

- (void)loadData{
    //设置Label的参数
    arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    float currectWeight = [[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
    [self setPresentWeight:currectWeight];
    [self setTargetWeight:[arry[arry.count-1][@"tWeight"] floatValue]];
    [self setBeginWeight:[arry[arry.count-1][@"sWeight"] floatValue]];
    
    self.beginWeight = [arry[arry.count-1][@"sWeight"] floatValue];
    self.presentWeight = currectWeight;
    self.targetWeight = [arry[arry.count-1][@"tWeight"] floatValue];
    
    _weightArr = [[NSMutableArray alloc] init];
    _dateArr = [[NSMutableArray alloc] init];
    NSArray *dateArry = [[LocalDBManager sharedManager] getWeight:[NSUserDefaults valueWithKey:@"userId"]];
    for (int i = ((int)dateArry.count - 6); i <dateArry.count; i++) {
        _weightDic = @{
                      @"date":dateArry[i][@"date"],
                      @"wCurrent":dateArry[i][@"wCurrent"]
                      ,
                      };
            [_weightArr addObject:_weightDic[@"wCurrent"]];
            [_dateArr addObject:_weightDic[@"date"]];
        }
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubviews {
    
    // 体重差值
    CGFloat a = fabs(self.beginWeight- self.targetWeight);
    
    // 减掉的重量所占比例
    CGFloat rate = 0;
    
    // 当前体重大于初始体重
    if (self.presentWeight > self.beginWeight) {
        self.beginWeight = self.presentWeight;
    } else if (self.presentWeight < self.targetWeight){
        // 当前体重小于目标体重
        rate = 1;
    } else {
        // 正常范围内
        rate = (self.beginWeight - self.presentWeight) / a;
    }
    float i;
    if ((1.2 - rate)>=1) {
        i = 1.1 - rate;
    }
    else{
        i = 1.2-rate;
    }
    self.redViewWeight.constant = i * self.redView.width;
    [UIView animateWithDuration:1.5f animations:^{
        [self.redView layoutIfNeeded];
    }];
    
    //[super layoutSubviews];
    

    self.redView.layer.cornerRadius   = self.redView.height / 2.f;
    self.redView.layer.masksToBounds  = YES;
}


#pragma mark - button action

- (void)returnToLastView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addNewWeightButton:(id)sender{
    WCMulScrollViewController *vc = [[WCMulScrollViewController alloc] init];
    vc.viewType = 3;
    [self presentViewController:vc animated:YES completion: nil];
}

- (void)chooseCalendar:(id)sender{
    NSLog(@"chooseCalendar");
}

- (void)blueTooth{
    
}

#pragma mark - 设置label的富文本和内容

- (void)setPresentWeight:(CGFloat)presentWeight{
    _presentWeight = presentWeight;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f/kg", self.presentWeight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:18.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:40.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length-3)];
    
    self.presentWeightLabel.attributedText = attrStr;
}

- (void)setBeginWeight:(CGFloat)beginWeight{
    _beginWeight = beginWeight;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"初始体重\n%.1f/kg", self.beginWeight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:25.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(4, attrStr.length-7)];
    
    self.beginWeightLabel.attributedText = attrStr;
}

- (void)setTargetWeight:(CGFloat)targetWeight{
    _targetWeight = targetWeight;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"目标体重\n%.1f/kg", self.targetWeight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:25.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(4, attrStr.length-7)];
    
    self.targetWeightLabel.attributedText = attrStr;
}

- (void)setDate{
    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@", @([NSDate date].month), @([NSDate date].day)];
}



- (UIView *)customDetailView{
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blueColor];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.borderColor=label.textColor.CGColor;
    label.layer.borderWidth=.5;
    label.layer.cornerRadius=label.width*.5;
    label.adjustsFontSizeToFitWidth=YES;
    label.clipsToBounds=YES;
    
    return label;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:1];
    
}

- (void)animate{

    [graph2 animate];
    [graph3 animate];
    [graph5 animate];
    
}



- (IBAction)calendarButton:(UIButton *)sender {
    WCRiliViewController *pv=[[WCRiliViewController alloc]init];
    [self presentViewController:pv animated:YES completion:nil];
}
@end
