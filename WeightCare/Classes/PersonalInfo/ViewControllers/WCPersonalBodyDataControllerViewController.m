//
//  WCPersonalBodyDataControllerViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/9.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalBodyDataControllerViewController.h"
#import "WCPersonalInfoViewController.h"
#import "LocalDBManager.h"
#import "PersonalViewHeightControllerViewController.h"
@interface WCPersonalBodyDataControllerViewController (){
    NSArray *arry;
}
@property (weak, nonatomic) IBOutlet UIView *weightView;

@property (strong ,nonatomic)NSDictionary *weightDic;
@property (strong ,nonatomic)NSMutableArray *weightArr;
@property (strong ,nonatomic)NSMutableArray *dateArr;

@end

@implementation WCPersonalBodyDataControllerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelector:@selector(animate) withObject:nil afterDelay:1];
    NSArray *arrd4 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _HeightLabel.text=[NSString stringWithFormat:@"%@cm",arrd4[0][@"uHeight"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"健康数据";
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"WCPSarrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    
    [self loadData];
    
    graph=[MPPlot plotWithType:MPPlotTypeGraph frame:CGRectMake(0, 42, SCREEN_WIDTH, 138)];
    //    紫色曲线图
    graph3=[[MPGraphView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 48)];
    graph3.waitToUpdate=YES;
    graph3.values=_weightArr;
    graph3.graphColor=BLUE_COLOR;
    graph3.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    graph3.curved=YES;
    
    
    //    橘色曲线填充图
    graph4=[[MPGraphView alloc] initWithFrame:graph3.frame];
    graph4.values=_weightArr;
    graph4.fillColors=@[BASE_COLOR,BASE_COLOR];
    graph4.graphColor=BLUE_COLOR;
    graph4.curved=YES;
    [_weightView addSubview:graph4];
    [_weightView addSubview:graph3];
}

- (void)loadData{
    //设置Label的参数
    arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
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
}

- (void)animate{
    [graph2 animate];
    [graph3 animate];
    [graph5 animate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chevrondown:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    PersonalViewHeightControllerViewController *pv=[[PersonalViewHeightControllerViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}
@end
