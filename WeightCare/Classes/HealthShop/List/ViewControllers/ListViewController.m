//
//  NoteViewController.m
//  WeightCare
//
//  Created by BG on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "OrderViewController.h"
#import "ProductDetailViewController.h"
#import "PaymentOrderViewController.h"
#import "LocalDBManager.h"



static NSString *const listTableViewCell = @"listTableViewCell";

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *selectView;
    UIButton *delivered;
    UIButton *paid;
    UIButton *all;
    UIView *blueRec;
    UIButton *placeOrderBtn;
    OrderStatus orderStatus;
    
    NSMutableArray *deliveredArr;
    NSMutableArray *paidArr;
    NSMutableArray *allArr;
    NSMutableArray *cartArr;
    UIView *emptyView;

}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BG_COLOR];

    deliveredArr =[[NSMutableArray alloc]init];
    paidArr =[[NSMutableArray alloc]init];
    allArr =[[NSMutableArray alloc]init];
    cartArr =[[NSMutableArray alloc]init];

    NSArray *arr = [[LocalDBManager sharedManager] readProductType:[NSUserDefaults valueWithKey:@"userId"]];
    
    for(NSDictionary *dic in arr){
        if([dic[@"pType"] isEqual:@"1"]){
            NSDictionary *bDic=@{@"pcNo":dic[@"pcNo"],
                                 @"prImg":dic[@"arrPrd"][0][@"pHeadImg"],
                                 @"prName":dic[@"arrPrd"][0][@"pName"],
                                 @"prPrice":dic[@"arrPrd"][0][@"pPrice"],
                                 @"prNum":dic[@"pNum"],
                                 @"pdImg":dic[@"arrPrd"][0][@"pDetailImg"],
                                 @"ppPrice":dic[@"arrPrd"][0][@"ppPrice"],
                                 @"pPost":dic[@"arrPrd"][0][@"pPost"],
                                 @"pAddress":dic[@"arrPrd"][0][@"pAddress"],
                                 @"pMonthSell":dic[@"arrPrd"][0][@"pMonthSell"],
                                 @"pNo":dic[@"pNo"],
                                 };
            [cartArr addObject:bDic];
        }
        if([dic[@"pType"] isEqual:@"3"]){
            NSDictionary *lDic=@{@"pcNo":dic[@"pcNo"],
                                 @"prImg":dic[@"arrPrd"][0][@"pHeadImg"],
                                 @"prName":dic[@"arrPrd"][0][@"pName"],
                                 @"prPrice":dic[@"arrPrd"][0][@"pPrice"],
                                 @"prNum":dic[@"pNum"],
                                 @"pdImg":dic[@"arrPrd"][0][@"pDetailImg"],
                                 @"ppPrice":dic[@"arrPrd"][0][@"ppPrice"],
                                 @"pPost":dic[@"arrPrd"][0][@"pPost"],
                                 @"pAddress":dic[@"arrPrd"][0][@"pAddress"],
                                 @"pMonthSell":dic[@"arrPrd"][0][@"pMonthSell"],
                                 @"pNo":dic[@"pNo"],
                                 };
            [deliveredArr addObject:lDic];
        }
        if([dic[@"pType"] isEqual:@"2"]){
            NSDictionary *pDic=@{@"pcNo":dic[@"pcNo"],
                                 @"prImg":dic[@"arrPrd"][0][@"pHeadImg"],
                                 @"prName":dic[@"arrPrd"][0][@"pName"],
                                 @"prPrice":dic[@"arrPrd"][0][@"pPrice"],
                                 @"prNum":dic[@"pNum"],
                                 @"pdImg":dic[@"arrPrd"][0][@"pDetailImg"],
                                 @"ppPrice":dic[@"arrPrd"][0][@"ppPrice"],
                                 @"pPost":dic[@"arrPrd"][0][@"pPost"],
                                 @"pAddress":dic[@"arrPrd"][0][@"pAddress"],
                                 @"pMonthSell":dic[@"arrPrd"][0][@"pMonthSell"],
                                 @"pNo":dic[@"pNo"],
                                 };
            [paidArr addObject:pDic];
        }
        if([dic[@"pType"] isEqual:@"4"]){
            NSDictionary *aDic=@{@"pcNo":dic[@"pcNo"],
                                 @"prImg":dic[@"arrPrd"][0][@"pHeadImg"],
                                 @"prName":dic[@"arrPrd"][0][@"pName"],
                                 @"prPrice":dic[@"arrPrd"][0][@"pPrice"],
                                 @"prNum":dic[@"pNum"],
                                 @"pdImg":dic[@"arrPrd"][0][@"pDetailImg"],
                                 @"ppPrice":dic[@"arrPrd"][0][@"ppPrice"],
                                 @"pPost":dic[@"arrPrd"][0][@"pPost"],
                                 @"pAddress":dic[@"arrPrd"][0][@"pAddress"],
                                 @"pMonthSell":dic[@"arrPrd"][0][@"pMonthSell"],
                                 @"pNo":dic[@"pNo"],
                                 };
            [allArr addObject:aDic];
        }
    }
    if(self.listType==orderList){
        self.title=@"我的订单";
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shopcar"] style:UIBarButtonItemStylePlain target:self action:@selector(toCart)];

        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-64-10) style:UITableViewStyleGrouped];
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:listTableViewCell];
        [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBackgroundColor:BG_COLOR];
        [self.view addSubview:_tableView];
        [self setSelectView];
        [self setBlueRecX:5];
        if((orderStatus ==orderStatusPaid&&paidArr.count==0)||(orderStatus ==orderStatusSended&&deliveredArr.count==0)||(orderStatus ==orderStatusAll&&allArr.count==0)){
            [self setEmptyView];
        }
    }
    else{
        self.title=@"购物车";
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"trash"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteAll)];

        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-64-10) style:UITableViewStyleGrouped];
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:listTableViewCell];
        [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBackgroundColor:BG_COLOR];
        [self.view addSubview:_tableView];
        if(cartArr.count==0){
            [self setEmptyView];
        }
        else{
            [self setPlaceOrder];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setSelectView{
    selectView=[[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 40)];
    [selectView setBackgroundColor:[UIColor whiteColor]];
    
    paid = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
    [paid setTitle:@"已付款" forState:UIControlStateNormal];
    [paid setTitleColor:BLUE_COLOR forState:(UIControlStateNormal)];
    paid.titleLabel.font= [UIFont systemFontOfSize: 14];
    paid.tag=0;
    [paid addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    delivered = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40)];
    [delivered setTitle:@"已发货" forState:UIControlStateNormal];
    [delivered setTitleColor:BLUE_COLOR forState:(UIControlStateNormal)];
    delivered.titleLabel.font= [UIFont systemFontOfSize: 14];
    delivered.tag=1;
    [delivered addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

    all = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 40)];
    [all setTitle:@"全部订单" forState:UIControlStateNormal];
    [all setTitleColor:BLUE_COLOR forState:(UIControlStateNormal)];
    all.titleLabel.font= [UIFont systemFontOfSize: 14];
    all.tag=2;
    [all addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIView *grayLinel=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 10, 1, 20)];
    [grayLinel setBackgroundColor:BG_COLOR];
    UIView *grayLinek=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 10, 1, 20)];
    [grayLinek setBackgroundColor:BG_COLOR];
    
    [selectView addSubview:delivered];
    [selectView addSubview:paid];
    [selectView addSubview:all];

    [selectView addSubview:grayLinel];
    [selectView addSubview:grayLinek];
    
    
    [self.view addSubview:selectView];
}

-(void)setBlueRecX:(float)x{
    blueRec=[[UIView alloc]initWithFrame:CGRectMake(x, 40-3, SCREEN_WIDTH/3-10, 3)];
    [blueRec setBackgroundColor:BLUE_COLOR];
    [selectView addSubview:blueRec];
}

-(void)setPlaceOrder{
    placeOrderBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*(375-237)/375/2, SCREEN_HEIGHT-20-64-SCREEN_WIDTH*60/375, SCREEN_WIDTH*237/375, SCREEN_WIDTH*60/375)];
    [placeOrderBtn setTitle:@"全部付款" forState:UIControlStateNormal];
    [placeOrderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    placeOrderBtn.titleLabel.font= [UIFont systemFontOfSize: 20];
    placeOrderBtn.backgroundColor=RED_COLOR;
    placeOrderBtn.layer.cornerRadius=10;
    [placeOrderBtn addTarget:self action:@selector(fullPayment:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:placeOrderBtn];
}

-(void)selectBtnClick:(UIButton *)sender{
    emptyView.hidden=YES;
    switch (sender.tag) {
        case 0:
            orderStatus = orderStatusPaid;
            if(paidArr.count==0){[self setEmptyView];}
            break;
        case 1:
            orderStatus = orderStatusSended;
            if(deliveredArr.count==0){[self setEmptyView];}
            break;
        case 2:
            orderStatus = orderStatusAll;
            if(allArr.count==0){[self setEmptyView];}
            break;
        default:
            break;
    }
    [_tableView reloadData];

    
    [UIView animateWithDuration:0.3 animations:^{
        blueRec.frame= CGRectMake(5+sender.tag*SCREEN_WIDTH/3, 40-3, SCREEN_WIDTH/3-10, 3);
    }];
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.listType==cartList){
        return cartArr.count;
    }
    else if(orderStatus == orderStatusPaid){
        return paidArr.count;
    }
    else if(orderStatus == orderStatusSended){
        return deliveredArr.count;
    }
    else{
        return allArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listTableViewCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(self.listType==cartList){
        [cell SetPrImg:[UIImage imageNamed:cartArr[indexPath.section][@"prImg"]] SetPrName:cartArr[indexPath.section][@"prName"] SetPrNum:cartArr[indexPath.section][@"prNum"] SetPrPrice:cartArr[indexPath.section][@"prPrice"]];
    }
    else if(orderStatus == orderStatusPaid){
        [cell SetPrImg:[UIImage imageNamed:paidArr[indexPath.section][@"prImg"]] SetPrName:paidArr[indexPath.section][@"prName"] SetPrNum:paidArr[indexPath.section][@"prNum"] SetPrPrice:paidArr[indexPath.section][@"prPrice"]];
    }
    else if(orderStatus == orderStatusSended){
        [cell SetPrImg:[UIImage imageNamed:deliveredArr[indexPath.section][@"prImg"]] SetPrName:deliveredArr[indexPath.section][@"prName"] SetPrNum:deliveredArr[indexPath.section][@"prNum"] SetPrPrice:deliveredArr[indexPath.section][@"prPrice"]];
    }
    else{
        [cell SetPrImg:[UIImage imageNamed:allArr[indexPath.section][@"prImg"]] SetPrName:allArr[indexPath.section][@"prName"] SetPrNum:allArr[indexPath.section][@"prNum"] SetPrPrice:allArr[indexPath.section][@"prPrice"]];
    }
    return cell;
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {NSLog(@"删除");}];
    
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {NSLog(@"编辑");}];
    rowActionSec.backgroundColor = [UIColor grayColor];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.listType==orderList){
        self.hidesBottomBarWhenPushed=YES;
        OrderViewController *lwpc = [[OrderViewController alloc]init];
        lwpc.orderType=orderDetail;

        
        if(orderStatus == orderStatusPaid){
            lwpc.productImg=paidArr[indexPath.section][@"prImg"];
            lwpc.productName=paidArr[indexPath.section][@"prName"];
            lwpc.productNum=paidArr[indexPath.section][@"prNum"];
            lwpc.productPrice=paidArr[indexPath.section][@"prPrice"];
            lwpc.numLabel.text=paidArr[indexPath.section][@"prNum"];
        }
        else if(orderStatus == orderStatusSended){
            lwpc.productImg=deliveredArr[indexPath.section][@"prImg"];
            lwpc.productName=deliveredArr[indexPath.section][@"prName"];
            lwpc.productNum=deliveredArr[indexPath.section][@"prNum"];
            lwpc.productPrice=deliveredArr[indexPath.section][@"prPrice"];
            lwpc.numLabel.text=paidArr[indexPath.section][@"prNum"];
        }
        else{
            lwpc.productImg=allArr[indexPath.section][@"prImg"];
            lwpc.productName=allArr[indexPath.section][@"prName"];
            lwpc.productNum=allArr[indexPath.section][@"prNum"];
            lwpc.productPrice=allArr[indexPath.section][@"prPrice"];
            lwpc.numLabel.text=paidArr[indexPath.section][@"prNum"];
        }

        [self.navigationController pushViewController:lwpc animated:YES];
    }
    else{
        self.hidesBottomBarWhenPushed=YES;
        ProductDetailViewController *lwpc = [[ProductDetailViewController alloc]init];
        lwpc.dic=cartArr[indexPath.section];
        lwpc.buttonEnable=0;
        [self.navigationController pushViewController:lwpc animated:YES];
    }
}

-(void)toCart{
    self.hidesBottomBarWhenPushed=YES;
    ListViewController *vc=[[ListViewController alloc]init];
    vc.listType=cartList;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)deleteAll{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"确认要清空购物车吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

-(void)fullPayment:(UIButton *)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)setEmptyView{
    emptyView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    emptyView.backgroundColor=BG_COLOR;
    
    UIImageView *noneImg=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-136)/2, 74, 136, 116)];
    noneImg.image=[UIImage imageNamed:@"order_none"];
    
    UILabel *noneLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-143)/2, 210, 143, 39)];
    noneLabel.text=@"不剁手的日子没法儿过";
    noneLabel.textColor=GRAY_COLOR;
    noneLabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *noneLabelT=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-196)/2, 230, 196, 39)];
    noneLabelT.text=@"挑选心怡的健康宝贝，买买买";
    noneLabelT.textColor=GRAY_COLOR;
    noneLabelT.font=[UIFont systemFontOfSize:14];
    
    [emptyView addSubview:noneImg];
    [emptyView addSubview:noneLabel];
    [emptyView addSubview:noneLabelT];
    [self.view addSubview:emptyView];

}

 @end
