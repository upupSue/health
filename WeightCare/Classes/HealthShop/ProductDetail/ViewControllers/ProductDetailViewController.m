//
//  ProductDetailViewController.m
//  WeightCare
//
//  Created by BG on 16/8/28.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "OrderViewController.h"
#import "LocalDBManager.h"


@interface ProductDetailViewController (){
    float thPrice;
    int inum;
    UILabel *myPrice;
    UIImageView *priceImg;
}

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) UIButton *checkBtn;
@property (strong, nonatomic) UILabel *num;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImg;

@end

@implementation ProductDetailViewController


- (void)viewDidLoad {
    
    self.title=@"商品详情";
    
    [super viewDidLoad];
    _nameLabel.text=_dic[@"prName"];
    _priceLabel.text=_dic[@"prPrice"];
    _pPriceLabel.text=_dic[@"ppPrice"];
    _postLabel.text=_dic[@"pPost"];
    _addressLabel.text=_dic[@"pAddress"];
    _sellLabel.text=_dic[@"pMonthSell"];
    _detailImg.image=[UIImage imageNamed:_dic[@"pdImg"]];

    thPrice=22.8;
    inum=1;
    _buyBtn.layer.cornerRadius=5;
    _addBtn.layer.cornerRadius=5;
    [self setShadeView];
    [_shadeView setHidden:YES];
    [self setBottomView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (IBAction)addCart:(id)sender {
    if(_buttonEnable==0){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该商品已经在购物车中了哦" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            [_shadeView setHidden:NO];
            _bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-190-64, SCREEN_WIDTH, 190);
        }];
    }
}

- (IBAction)toBuy:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    OrderViewController *vc=[[OrderViewController alloc]init];
    vc.orderType=checkOrder;
    vc.dic=_dic;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setBottomView{
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, 190)];
    UIView *selectContent=[[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 100)];
    selectContent.layer.cornerRadius=10;
    [selectContent setBackgroundColor:[UIColor whiteColor]];
   
    priceImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48, 50)];
    priceImg.image = [UIImage imageNamed:@"wallet.png"];
    
    UIImageView *numImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 51, 48, 49)];
    numImg.image = [UIImage imageNamed:@"archive.png"];
    
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(48, priceImg.centerY-11, 34, 22)];
    priceLabel.text=@"总价";
    priceLabel.textColor=DEEPGRAY_COLOR;
    priceLabel.font=[UIFont systemFontOfSize:16];
    
    UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(48, numImg.centerY-11, 34, 22)];
    numLabel.text=@"数量";
    numLabel.textColor=DEEPGRAY_COLOR;
    numLabel.font=[UIFont systemFontOfSize:16];
    
    NSString *st = _dic[@"prPrice"];
    NSScanner *scanner = [NSScanner scannerWithString:st];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    float number;
    [scanner scanFloat:&number];
    NSString *price=[NSString stringWithFormat:@"￥%.1f", number];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:price];
    [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(0,1)];
    [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(1,price.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang SC" size:20] range:NSMakeRange(0,1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Haettenschweiler" size:35] range:NSMakeRange(1,price.length-1)];

    myPrice=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-str.size.width, priceImg.centerY-str.size.height/2, str.size.width, str.size.height)];
    myPrice.attributedText = str;
    myPrice.textAlignment = NSTextAlignmentCenter;
    
    
    
    UIView *selectNum=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-94, numImg.centerY-30/2, 92,30)];
    selectNum.layer.cornerRadius=5;
    selectNum.backgroundColor=BLUE_COLOR;
    selectNum.layer.borderWidth=1;
    selectNum.layer.borderColor=BLUE_COLOR.CGColor;
    
    UIButton *minus=[[UIButton alloc]initWithFrame:CGRectMake(1, 1, 27, 28)];
    [minus setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [minus addTarget:self action:@selector(doMinus) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *plus=[[UIButton alloc]initWithFrame:CGRectMake(64, 1, 27, 28)];
    [plus setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [plus addTarget:self action:@selector(doPlus) forControlEvents:UIControlEventTouchUpInside];
    
    _num=[[UILabel alloc]initWithFrame:CGRectMake(28, 1, 36, 28)];
    _num.text=[NSString stringWithFormat:@"%d",inum];
    _num.textColor=[UIColor whiteColor];
    _num.font=[UIFont systemFontOfSize:20];
    _num.textAlignment = NSTextAlignmentCenter;
    
    [selectNum addSubview:minus];
    [selectNum addSubview:plus];
    [selectNum addSubview:_num];
    
    [selectContent addSubview:priceImg];
    [selectContent addSubview:numImg];
    [selectContent addSubview:priceLabel];
    [selectContent addSubview:numLabel];
    [selectContent addSubview:myPrice];
    [selectContent addSubview:selectNum];
    
    _checkBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 60)];
    _checkBtn.layer.cornerRadius=10;
    [_checkBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_checkBtn setTitleColor:BLUE_COLOR forState:(UIControlStateNormal)];
    _checkBtn.titleLabel.font= [UIFont systemFontOfSize: 20];
    [_checkBtn setBackgroundColor:[UIColor whiteColor]];
    [_checkBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20-20, 1)];
    
    [_bottomView addSubview:selectContent];
    [_bottomView addSubview:_checkBtn];
    [_bottomView addSubview:line];

    [self.view addSubview:_bottomView];
}

-(void)setShadeView{
    _shadeView=[[UIView alloc]initWithFrame:CGRectMake(0, 199-64, SCREEN_WIDTH, SCREEN_HEIGHT-199)];
    [_shadeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doHide)];
    
    [_shadeView addGestureRecognizer:tapRecognizer];
    [self.view addSubview:_shadeView];
}

-(void)doHide{
    [UIView animateWithDuration:0.3 animations:^{
        [_shadeView setHidden:YES];
        _bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, 190);
    }];
}

-(void)check{
    [self doHide];
    if(_buttonEnable==0){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else{
        [[LocalDBManager sharedManager] insertCart:[_dic[@"pNo"] intValue] pType:1 pNum:inum userId:[[NSUserDefaults valueWithKey:@"userId"] intValue]];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"添加到购物车成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

-(void)doMinus{
    if(inum>1){
        inum--;
        _num.text=[NSString stringWithFormat:@"%d",inum];
        NSString *st = _dic[@"prPrice"];
        NSScanner *scanner = [NSScanner scannerWithString:st];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        float number;
        [scanner scanFloat:&number];
        NSString *price=[NSString stringWithFormat:@"￥%.1f", number*inum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:price];
        [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(0,1)];
        [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(1,price.length-1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang SC" size:20] range:NSMakeRange(0,1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Haettenschweiler" size:35] range:NSMakeRange(1,price.length-1)];
        myPrice.frame=CGRectMake(SCREEN_WIDTH-40-str.size.width, priceImg.centerY-str.size.height/2, str.size.width, str.size.height);
        myPrice.attributedText = str;
    }
}

-(void)doPlus{
    if(inum<100){
        inum++;
        _num.text=[NSString stringWithFormat:@"%d",inum];
        NSString *st = _dic[@"prPrice"];
        NSScanner *scanner = [NSScanner scannerWithString:st];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        float number;
        [scanner scanFloat:&number];
        NSString *price=[NSString stringWithFormat:@"￥%.1f", number*inum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:price];
        [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(0,1)];
        [str addAttribute:NSForegroundColorAttributeName value:RED_COLOR range:NSMakeRange(1,price.length-1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang SC" size:20] range:NSMakeRange(0,1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Haettenschweiler" size:35] range:NSMakeRange(1,price.length-1)];
        myPrice.frame=CGRectMake(SCREEN_WIDTH-40-str.size.width, priceImg.centerY-str.size.height/2, str.size.width, str.size.height);
        myPrice.attributedText = str;
    }
}

@end
