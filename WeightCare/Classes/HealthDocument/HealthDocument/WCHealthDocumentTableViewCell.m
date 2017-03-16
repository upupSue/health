//
//  WCHealthyDocumentTableViewCell.m
//  WeightCare
//
//  Created by BG on 16/9/4.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHealthDocumentTableViewCell.h"

@implementation WCHealthDocumentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.radiusView.layer.cornerRadius = 10.f;
    self.radiusView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setIconImage:(UIImage *)image SetCatalogLabel:(NSString *)catalogLabel SetContentLabel:(NSString *)contentLabel SetNumLabel:(NSString *)numLabel SetUnitLabel:(NSString *)unitLabel{
    _iconImage.image = image;
    _catalogLabel.text = catalogLabel;
    _contentLabel.text = contentLabel;
    _numLabel.text = numLabel;
    _unitLabel.text = unitLabel;
}

@end
