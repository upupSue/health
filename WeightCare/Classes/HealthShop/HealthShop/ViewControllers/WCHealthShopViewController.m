//
//  WCHealthShopViewController.m
//  WeightCare
//
//  Created by BG on 16/7/19.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "WCHealthShopViewController.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"
#import "ProductDetailViewController.h"
#import "OrderViewController.h"
#import "ListViewController.h"
#import "LocalDBManager.h"


@interface WCHealthShopViewController ()<CCDraggableContainerDataSource,CCDraggableContainerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end


@implementation WCHealthShopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BG_COLOR];
    
    _whiteView.layer.cornerRadius=15;
    _redView.layer.cornerRadius=7;
    
    NSArray *allarr = [[LocalDBManager sharedManager] readProductType:[NSUserDefaults valueWithKey:@"userId"]];
    NSMutableArray *cartarr=[[NSMutableArray alloc]init];
    for(NSDictionary *dic in allarr){
        if([dic[@"pType"] isEqual:@"1"]){
            [cartarr addObject:dic];
        }
    }
    _numLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)cartarr.count];
    [self loadData];
    [self loadUI];
}

- (void) viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)loadUI {
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 70, CCWidth, CCWidth+137) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    [self.container reloadData];
}

- (void)loadData {
    _dataSources = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"bImg%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"商品详情"]};
        [_dataSources addObject:dict];
    }
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    NSArray *arr = [[LocalDBManager sharedManager] readProductDetail:((int)didSelectIndex+1)];
    
    self.hidesBottomBarWhenPushed=YES;
    ProductDetailViewController *vc=[[ProductDetailViewController alloc]init];
    NSDictionary *dic=@{
                        @"prImg":arr[0][@"pHeadImg"],
                        
                        @"prName":arr[0][@"pName"],
                        
                        @"prPrice":arr[0][@"pPrice"],
                        
                        @"pdImg":arr[0][@"pDetailImg"],
                        
                        @"ppPrice":arr[0][@"ppPrice"],
                        
                        @"pPost":arr[0][@"pPost"],
                        
                        @"pAddress":arr[0][@"pAddress"],
                        
                        @"pMonthSell":arr[0][@"pMonthSell"],
                        
                        @"pNo":arr[0][@"pNo"],
                        };

    vc.dic=dic;
    vc.buttonEnable=1;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    [draggableContainer reloadData];
}


- (IBAction)toNote:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    ListViewController *vc=[[ListViewController alloc]init];
    vc.listType=orderList;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (IBAction)toCart:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    ListViewController *vc=[[ListViewController alloc]init];
    vc.listType=cartList;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (IBAction)searchBtn:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//键盘退出
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_searchTextField resignFirstResponder];
}
@end
