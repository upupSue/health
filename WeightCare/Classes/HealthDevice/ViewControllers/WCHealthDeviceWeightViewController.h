//
//  WCHealthDeviceWeightViewController.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/22.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>//Quartz Core 图层编程 框架
#import <CoreBluetooth/CoreBluetooth.h>//添加CoreBluetooth.framework 框架
@interface WCHealthDeviceWeightViewController : UIViewController
@property(assign,nonatomic) int blueToothType;
@property (assign, nonatomic)CGFloat blueToothWeight;

-(void)centralManagerDidUpdateState:(CBCentralManager *)central;//确保蓝牙打开，若未打开弹窗提示

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI;//搜索蓝牙秤
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接蓝牙秤
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;//蓝牙秤采集数据

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;//蓝牙秤采集数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;//蓝牙秤采集数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;//蓝牙秤进行数据转换，手机界面接收数据
-(int)hex2dec:(NSString *)hex;//进制转换

@end
