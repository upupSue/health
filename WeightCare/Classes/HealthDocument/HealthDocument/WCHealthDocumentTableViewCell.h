//
//  WCHealthyDocumentTableViewCell.h
//  WeightCare
//
//  Created by BG on 16/9/4.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHealthDocumentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *radiusView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *catalogLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

- (void)setIconImage:(UIImage *)image SetCatalogLabel:(NSString *)catalogLabel SetContentLabel:(NSString *)contentLabel SetNumLabel:(NSString *)numLabel SetUnitLabel:(NSString *)unitLabel;

@end
