//
//  PayNoteViewController.m
//  WeightCare
//
//  Created by BG on 16/8/29.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "PaymentOrderViewController.h"

@interface PaymentOrderViewController (){
    NSMutableArray *checkButtonArr;
}
@property (weak, nonatomic) IBOutlet UIView *orderContentView;
@property (weak, nonatomic) IBOutlet UIView *methodContentView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *creditCard;


@end

@implementation PaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付订单";
    _orderContentView.layer.cornerRadius=10;
    _methodContentView.layer.cornerRadius=10;
    _checkBtn.layer.cornerRadius=10;
    _alipayBtn.selected=YES;
    checkButtonArr=[[NSMutableArray alloc]init];
    [checkButtonArr addObject:_alipayBtn];
    [checkButtonArr addObject:_weChatBtn];
    [checkButtonArr addObject:_creditCard];
    _headImg.layer.cornerRadius=23;
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.borderColor=BG_COLOR.CGColor;
    _headImg.layer.borderWidth=3;

    _headImg.image=[UIImage imageNamed:_Img];
    _nameLabel.text=_name;
    _priceLabel.text=_price;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)selectBtn:(UIButton *)sender {
    if(sender.selected==NO){
        for(UIButton *btn in checkButtonArr){
            btn.selected=NO;
        }
        sender.selected=YES;
    }
}

- (IBAction)confirmPayment:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
