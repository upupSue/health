//
//  TableViewCell.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPersonalInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *perosnalInfoTableCellImage;
@property (weak, nonatomic) IBOutlet UILabel *perosnalInfoTableCellLabel;

- (void)setPerosnalInfoTableCellImage:(UIImage *)image andSetPersonalInfoTableCellLabel:(NSString *)label;

@end
