//
//  WCHealthDocumentViewController.m
//  WeightCare
//
//  Created by BG on 16/9/4.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDocumentViewController.h"
#import "WCHealthDocumentTableViewCell.h"
#import "WCHealthDocumentHeaderView.h"
#import "DesignViewController.h"
#import "InformationViewController.h"
#import "LocalDBManager.h"


static NSString *const WCHealthDocumentTableViewCellIdentity = @"WCHealthDocumentTableViewCellIdentity";
static NSString *const HealthDocumentHeaderView = @"WCHealthDocumentHeaderView";

@interface WCHealthDocumentViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arr;
    NSArray *arrIfo;
    NSDictionary *dic;
    int cellCount;
    NSString* currectWeight;
    NSString* dates;
    float tzl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) WCHealthDocumentHeaderView *WCHealthDocumentHeaderView;

@end


@implementation WCHealthDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellCount=2;
    arrIfo = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];

    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHealthDocumentTableViewCell" bundle:nil] forCellReuseIdentifier:WCHealthDocumentTableViewCellIdentity];
    [self.tableView registerNib:[UINib nibWithNibName:@"WCHealthDocumentHeaderView" bundle:nil]  forHeaderFooterViewReuseIdentifier:HealthDocumentHeaderView];

    arr = @[@{@"image":@"cutlery",
              @"catalogLabel":@"饮食方案",
              @"contentLabel":@"热量预算",
              @"numLabel":@"750",
              @"unitLabel":@"大卡"},
            @{@"image":@"lifting",
              @"catalogLabel":@"运动方案",
              @"contentLabel":@"燃脂心率",
              @"numLabel":@"119 - 159",
              @"unitLabel":@"次/分钟"}
            ];
    
    dic=@{@"numberOfBMILabel":@"28.3",
          @"numberOfTZLabel":@"22.6%",
          @"fitnessSituationLabel":@"肥胖",
          @"levelOfTZ":@"高",
          @"date":@"21",
          @"setLabel":@"190",
          @"weightExcept":arrIfo[0][@"tWeight"],
          @"weightPast":arrIfo[0][@"sWeight"]
          };
    float wa=[[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
    currectWeight=[NSString stringWithFormat:@"%.1f",wa]==NULL?dic[@"weightPast"]:[NSString stringWithFormat:@"%.1f",wa];
    dates=[NSUserDefaults valueWithKey:@"numberOfDay"]==NULL?@"0":[NSUserDefaults valueWithKey:@"numberOfDay"];
}

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES];

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cellCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 383.f;
    }
    else{
        return 10.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==cellCount-1){
        return 10.f;
    }
    else{
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        self.WCHealthDocumentHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HealthDocumentHeaderView];

        [self.WCHealthDocumentHeaderView setCellsFrameWeight:[currectWeight floatValue] WeightExpect:[dic[@"weightExcept"]floatValue] WeightPast:[dic[@"weightPast"] floatValue]];
        [self.WCHealthDocumentHeaderView setNumberOfBMILabel:dic[@"numberOfBMILabel"] SetNumberOfTZLabel:dic[@"numberOfTZLabel"] SetFitnessSituationLabel:dic[@"fitnessSituationLabel"] SetLevelOfTZ:dic[@"levelOfTZ"] SetDate:dates SetsetLabel:dic[@"setLabel"] SetWeightExcept:dic[@"weightExcept"] SetWeightPast:dic[@"weightPast"] SetWeight:currectWeight];
        
        if([arrIfo[0][@"uSix"] isEqualToString:@"0"]){
            float a=[arrIfo[0][@"uWaistline"] floatValue]*0.74;
            float b=[currectWeight floatValue]*0.082+34.89;
            tzl=(a-b)/[currectWeight floatValue]*100;
        }
        else{
            float a=[arrIfo[0][@"uWaistline"] floatValue]*0.74;
            float b=[currectWeight floatValue]*0.082+44.74;
            tzl=(a-b)/[currectWeight floatValue]*100;

        }
            
        [self.WCHealthDocumentHeaderView setNumberOfBMILabel:[currectWeight floatValue]/[arrIfo[0][@"uHeight"] floatValue]/[arrIfo[0][@"uHeight"] floatValue]*100*100 numberOfTZLabel:tzl sex:arrIfo[0][@"uSix"]];
        
        [self.WCHealthDocumentHeaderView.indetail addTarget:self action:@selector(inDetail) forControlEvents:UIControlEventTouchUpInside];
        return self.WCHealthDocumentHeaderView;
    }
    else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
        [headerView setBackgroundColor:LIGHTGRAY_COLOR];
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
    
    [footView setBackgroundColor:LIGHTGRAY_COLOR];
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WCHealthDocumentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCHealthDocumentTableViewCellIdentity forIndexPath:indexPath];
    
    [cell setIconImage:[UIImage imageNamed:arr[indexPath.section][@"image"]] SetCatalogLabel:arr[indexPath.section][@"catalogLabel"] SetContentLabel:arr[indexPath.section][@"contentLabel"] SetNumLabel:arr[indexPath.section][@"numLabel"] SetUnitLabel:arr[indexPath.section][@"unitLabel"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    DesignViewController *lwpc = [[DesignViewController alloc]init];
    [self.navigationController pushViewController:lwpc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
    if(indexPath.section == 0){
        lwpc.designType=dietDesign;
    }
    if(indexPath.section == 1){
        lwpc.designType=sportDesign;
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

-(void)inDetail{
    self.hidesBottomBarWhenPushed=YES;
    InformationViewController *vc =[[InformationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

@end
