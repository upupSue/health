//
//  NoteTableViewCell.h
//  WeightCare
//
//  Created by BG on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *radiusView;

@property (weak, nonatomic) IBOutlet UIImageView *prImg;
@property (weak, nonatomic) IBOutlet UILabel *prName;
@property (weak, nonatomic) IBOutlet UILabel *prNum;
@property (weak, nonatomic) IBOutlet UILabel *prPrice;

-(void)SetPrImg:(UIImage *)prImg SetPrName:(NSString *)prName SetPrNum:(NSString *)prNum SetPrPrice:(NSString *)prPrice;

@end
