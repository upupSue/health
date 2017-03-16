//
//  WCHealthDeviceTableViewBlueToothCellTableViewCellNew.m
//  WeightCare
//
//  Created by 王佳楠 on 16/9/14.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDeviceTableViewBlueToothCellTableViewCellNew.h"
#import "WCHealthShebeiTableViewCell.h"
#import "WCHealthDeviceWeightViewController.h"

static NSString *const WCHealthShebeiTableViewCellIdentify = @"WCHealthShebeiTableViewCellIdentify";

@implementation WCHealthDeviceTableViewBlueToothCellTableViewCellNew

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.BlueTView.layer.cornerRadius=10;
    self.BlueTView.clipsToBounds=YES;
    self.HDShebeiTableViewCell.delegate   = self;
    self.HDShebeiTableViewCell.dataSource = self;
    
    //注册cell
    //[self.HDShebeiTableViewCell registerNib:[UINib nibWithNibName:@"WCHealthShebeiTableViewCell" bundle:nil] forCellReuseIdentifier: WCHealthShebeiTableViewCellIdentify];
  
    
}
#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [self.HDShebeiTableViewCell registerNib:[UINib nibWithNibName:@"WCHealthShebeiTableViewCell" bundle:nil] forCellReuseIdentifier: WCHealthShebeiTableViewCellIdentify];
        WCHealthShebeiTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:WCHealthShebeiTableViewCellIdentify forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = NO;
    
        return cell2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
