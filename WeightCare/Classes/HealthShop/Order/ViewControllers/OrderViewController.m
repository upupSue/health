//
//  CheckNoteViewController.m
//  WeightCare
//
//  Created by BG on 16/8/28.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "OrderViewController.h"
#import "PaymentOrderViewController.h"
#import "WCPersonalSetAddressTableViewController.h"


@interface OrderViewController (){
    int inum;
    NSArray *pdArr;
}

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIButton *chechBtn;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;

@property (weak, nonatomic) IBOutlet UIImageView *prImg;
@property (weak, nonatomic) IBOutlet UILabel *prName;
@property (weak, nonatomic) IBOutlet UILabel *prPrice;
@property (weak, nonatomic) IBOutlet UILabel *prNum;

@property (strong,nonatomic) UIView *deliveryView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_orderType==checkOrder){
        self.title=@"确认订单";
        
        _productImg=_dic[@"prImg"];
        _productName=_dic[@"prName"];
        _productNum=_dic[@"prNum"]==NULL?@"1":_dic[@"prNum"];
        _productPrice=_dic[@"prPrice"];
        
        _messageView.layer.cornerRadius=10;
        _chechBtn.layer.cornerRadius=10;
    }
    if(_orderType==orderDetail){
        self.title=@"订单详情";
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"headset"] style:UIBarButtonItemStylePlain target:self action:@selector(online)];
        
        _messageView.hidden=YES;
        _chechBtn.hidden=YES;
        
        _selectView.backgroundColor=BG_COLOR;
        _numLabel.textColor=BLUE_COLOR;
        _plusBtn.enabled=NO;
        _minusBtn.enabled=NO;
        _plusBtn.adjustsImageWhenDisabled =NO;
        _minusBtn.adjustsImageWhenDisabled =NO;
    
        [self setDeliveryView];
    }
    
    NSString *str = _productPrice;
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    float number;
    [scanner scanFloat:&number];
    
    _prImg.image=[UIImage imageNamed:_productImg];
    _prName.text=_productName;
    _prPrice.text=[NSString stringWithFormat:@"￥%.1f",number*[_productNum floatValue]] ;
    _prNum.text=_productNum;
    
    inum=[_productNum intValue];
    _numLabel.text=[NSString stringWithFormat:@"%d",inum];


    _selectView.layer.cornerRadius=5;
    _productImage.layer.cornerRadius=56;
    _productImage.layer.borderWidth=6;
    _productImage.layer.borderColor=LIGHTGRAY_COLOR.CGColor;
    _productImage.layer.masksToBounds = YES;
    _headView.layer.cornerRadius=10;
    _priceView.layer.cornerRadius=10;
    _userView.layer.cornerRadius=10;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)setDeliveryView{
    _deliveryView=[[UIView alloc]initWithFrame:CGRectMake(0, 504-64, SCREEN_WIDTH-20, 153)];
    _deliveryView.backgroundColor=[UIColor whiteColor];
    _deliveryView.layer.cornerRadius=10;
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
    icon.image=[UIImage imageNamed:@"rocket"];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 162, 22)];
    titleLabel.text=@"快递跟踪：暂无订单号";
    titleLabel.textColor=DEEPGRAY_COLOR;
    titleLabel.font=[UIFont systemFontOfSize:16];
    
    UIImageView *noneImg=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-68-20)/2, 52, 68, 68)];
    noneImg.image=[UIImage imageNamed:@"car"];
    
    UILabel *noneLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20-204)/2, 120, 204, 17)];
    noneLabel.text=@"再等等吧！很快就有您的快递消息了！";
    noneLabel.textColor=GRAY_COLOR;
    noneLabel.font=[UIFont systemFontOfSize:12];
    
    [_deliveryView addSubview:icon];
    [_deliveryView addSubview:titleLabel];
    [_deliveryView addSubview:noneImg];
    [_deliveryView addSubview:noneLabel];
    
    [self.scrollView addSubview:_deliveryView];
}

-(void)online{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"8008-820820" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}


- (IBAction)minus:(id)sender {
    if(inum>1){
        inum--;
        _numLabel.text=[NSString stringWithFormat:@"%d",inum];
        
        NSString *str = _productPrice;
        NSScanner *scanner = [NSScanner scannerWithString:str];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        float number;
        [scanner scanFloat:&number];
        
        _prPrice.text=[NSString stringWithFormat:@"￥%.1f",number*inum] ;
    }
}

- (IBAction)plus:(id)sender {
    if(inum<100){
        inum++;
        _numLabel.text=[NSString stringWithFormat:@"%d",inum];
       
        NSString *str = _productPrice;
        NSScanner *scanner = [NSScanner scannerWithString:str];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        float number;
        [scanner scanFloat:&number];
        
        _prPrice.text=[NSString stringWithFormat:@"￥%.1f",number*inum] ;
    }
}

- (IBAction)check:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    PaymentOrderViewController *vc=[[PaymentOrderViewController alloc]init];
    vc.Img=_dic[@"prImg"];
    vc.name=_dic[@"prName"];
    vc.price=_prPrice.text;;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)setAddress:(id)sender {
    WCPersonalSetAddressTableViewController *vc=[[WCPersonalSetAddressTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
