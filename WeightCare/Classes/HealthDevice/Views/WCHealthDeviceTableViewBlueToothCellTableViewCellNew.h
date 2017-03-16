//
//  WCHealthDeviceTableViewBlueToothCellTableViewCellNew.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHealthDeviceTableViewBlueToothCellTableViewCellNew : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *BlueTView;
@property (weak, nonatomic) IBOutlet UITableView *HDShebeiTableViewCell;
@property (weak, nonatomic) IBOutlet UILabel *HDShebeiLabel;


@end
