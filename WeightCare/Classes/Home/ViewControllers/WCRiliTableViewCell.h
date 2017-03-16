//
//  WCRiliTableViewCell.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/12.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCRiliTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ViewCell;
@property (weak, nonatomic) IBOutlet UIView *ViewHead;
@property (weak, nonatomic) IBOutlet UILabel *WCRiliDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCRilixiaohaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCRilisheruLabel;
@property (weak, nonatomic) IBOutlet UILabel *WCRiliWeightLabel;

-(void) wCRiliDateLabel:(NSString *)WCRiliDateLabel wCRilixiaohaoLabel:(NSString *)WCRilixiaohaoLabel wCRilisheruLabel:(NSString *)WCRilisheruLabel wCRiliWeightLabel:(NSString *)WCRiliWeightLabel;
@end
