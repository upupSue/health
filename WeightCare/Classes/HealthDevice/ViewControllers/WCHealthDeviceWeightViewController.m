//
//  WCHealthDeviceWeightViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/22.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDeviceWeightViewController.h"
#import "WCBlueToothWeightViewController.h"
#import "NSData+Hex.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface WCHealthDeviceWeightViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    CALayer *_guang;
    CALayer *_tu;
    float original;
}

@property (nonatomic, strong) CBCentralManager *centralManager; //接收
@property (nonatomic, strong) CBPeripheral *peripheral; //外设
@property (weak, nonatomic) IBOutlet UIButton *returnToLastViewButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *confirnButton;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property (weak, nonatomic) IBOutlet UILabel *showWeightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointImage;

@end

@implementation WCHealthDeviceWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.blueToothType=1;//白色蓝牙秤
//    self.blueToothType=2;//黑色蓝牙秤

    _confirnButton.layer.cornerRadius = 10.f;
    _confirnButton.layer.masksToBounds = YES;
    _confirnButton.layer.borderColor = RED_COLOR.CGColor;
    _confirnButton.layer.borderWidth = 1.f;
    _retryButton.layer.cornerRadius = 10.f;
    _retryButton.layer.masksToBounds = YES;
    _retryButton.layer.borderColor = RED_COLOR.CGColor;
    _retryButton.layer.borderWidth = 1.f;
    
    [self.returnToLastViewButton addTarget:self action:@selector(returnToLastView:) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraButton addTarget:self action:@selector(enterCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirnButton addTarget:self action:@selector(confirn:) forControlEvents:UIControlEventTouchUpInside];
    [self.retryButton addTarget:self action:@selector(retryAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    _blueToothWeight = 0.0f;
    [self setBlueToothWeight:0.0];
    
    _pointImage.layer.anchorPoint = CGPointMake(0.9, 0.5);//CALayer的锚点属性
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)setBlueToothWeight:(CGFloat)Weight{
    _blueToothWeight = Weight;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f\nkg", self.blueToothWeight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:30.f],
                             NSForegroundColorAttributeName : [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:90.0f],
                             NSForegroundColorAttributeName : RED_COLOR
                             } range:NSMakeRange(0, attrStr.length-2)];
    
    self.showWeightLabel.attributedText = attrStr;
}


- (void)returnToLastView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)enterCamera:(id)sender{
    NSLog(@"camers");
}

- (void)confirn:(id)sender{
    NSLog(@"confirn");
    WCBlueToothWeightViewController *vc =[[WCBlueToothWeightViewController alloc]init];
    vc.weight = _blueToothWeight;
    [NSUserDefaults saveValue:[NSString stringWithFormat:@"%.2f",_blueToothWeight] forKey:@"currectWeight"];
    [self presentViewController:vc animated:YES completion:nil];
}

//初始化中央处理器，再测一次
- (void)retryAgain:(id)sender{
    NSLog(@"retryAgain");
     _centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
}


//CABasicAnimation，指针动画
-(void)rotationFrom:(float)from To:(float)to{
    NSLog(@"point move");
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = [NSNumber numberWithFloat:M_PI*from/100];
    animation.toValue   = [NSNumber numberWithFloat:M_PI*to/100];
    animation.duration  = 1.0f;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态
    
    [_pointImage.layer addAnimation:animation forKey:nil];
}

#pragma mark  此处监控一下central的状态值，可以判断蓝牙是否开启/可用
-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        //若蓝牙秤已经打开
        case CBCentralManagerStatePoweredOn:
            NSLog(@"111111");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];//扫描
            break;
        //若蓝牙秤未打开
        default:
            {
                UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"请打开蓝牙" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertVc animated:NO completion:nil];
                [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){NSLog(@"点击了取消按钮");}]];
            }
        break;
    }
}

#pragma mark 发现设备,连接
//一旦符合要求的设备被发现，就会回调此方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if(_blueToothType==1){
        if (peripheral) {
            NSLog(@"%@",peripheral);//匹配蓝牙的UUID，将下面if语句注释掉再执行一遍程序，找到蓝牙秤名称下的UUID
            if ([peripheral.name isEqualToString:@"YUNMAI-SIGNAL-MW"]) {
                    self.peripheral = peripheral;
                    [self.centralManager connectPeripheral:self.peripheral options:nil];
            }
        }
    }
    if(_blueToothType==2){
         if ([peripheral.name isEqualToString:@"VScale"]){
                 self.peripheral = peripheral;
                 [self.centralManager connectPeripheral:self.peripheral options:nil];
        }
    }
}


#pragma mark 未能连接的处理方法
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"connected periphheral failed");
}

#pragma mark 当连接上设备,寻找指定UUID的Service
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"has connected");
    self.peripheral.delegate = self;
    [self.peripheral discoverServices:nil];
}

#pragma mark 发现设备上指定Service会回调此处,寻找指定UUID的Characteristic
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (_blueToothType==1) {
        if (error==nil) {
            for (CBService *service in peripheral.services) {
                if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE0"]]) {
                    [peripheral discoverCharacteristics:nil forService:service];
                }
            }
        }
    }
    if (_blueToothType==2) {
        if (error==nil) {
            for (CBService *service in peripheral.services) {
                NSLog(@"%@",service.UUID);
                if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F433BD80-75B8-11E2-97D9-0002A5D5C51B"]]) {
                    [peripheral discoverCharacteristics:nil forService:service];
                }
            }
        }
    }
}

#pragma mark 找到指定UUID的Characteristic会回调此处
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (_blueToothType==1) {
        if (error==nil) {
            for (CBCharacteristic *characteristic in service.characteristics) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE4"]]) {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
            }
        }
    }
    if (_blueToothType==2) {
        if (error==nil) {
            
            for (CBCharacteristic *characteristic in service.characteristics) {
                NSLog(@"%@",characteristic.UUID);
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"1A2EA400-75B9-11E2-BE05-0002A5D5C51B"]]) {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
            }
        }

    }
}

#pragma mark 监测这个服务特性的状态变化后,调用数据截取方法
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error==nil) {
        [peripheral readValueForCharacteristic:characteristic];
    }
}

#pragma mark 把接收到的数据进行截取
//此处我们就可以拿到value值对其进行数据解析了
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    original = _blueToothWeight;
    //获取16进制数据
    NSString *stringFromData =[characteristic.value hexadecimalString];
    NSLog(@"%@",stringFromData);
    NSString *weightHexStr;
    if (_blueToothType==1) {
        //截取4位体重相关的16进制数据
        //称重数值不稳定时，获取22长度的数据
        if (stringFromData.length == 22) {
            weightHexStr = [[stringFromData substringFromIndex:stringFromData.length-6] substringToIndex:4];
        }
        //称重数值稳定时，获取40长度的数据
        else if(stringFromData.length == 40) {
            weightHexStr = [[stringFromData substringFromIndex:stringFromData.length-14] substringToIndex:4];
        }
        //16数值进制转换成体重的公式
        self.blueToothWeight = [self hex2dec:weightHexStr]/100.0;

    }
    if (_blueToothType==2) {
         //称重数值稳定时，获取40长度的数据
        if(stringFromData.length == 40){
            weightHexStr = [[stringFromData substringFromIndex:8] substringToIndex:4];
        }
        self.blueToothWeight=[self hex2dec:weightHexStr]/10.0;
    }
    [self rotationFrom:original To:_blueToothWeight];
    
}

#pragma mark 16进制转10进制
-(int)hex2dec:(NSString *)hex
{
    int dec=0;
    int len = (int)hex.length;
    int i;
    for(i=len-1;i>=0;i--) {
        unichar c = [hex characterAtIndex:i];
        if(c >= '0' && c <='9'){
            dec += (c-48)<<(4*(len-i-1));
        }else if(c >= 'A' && c <='F'){
            dec += (c-55)<<(4*(len-i-1));
        }else if(c >= 'a' && c <='f'){
            dec += (c-87)<<(4*(len-i-1));
        }
    }
    return dec;
}

@end
