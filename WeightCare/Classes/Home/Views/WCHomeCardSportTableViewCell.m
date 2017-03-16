//
//  WCHomeCardSportTableViewCell.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/7/19.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardSportTableViewCell.h"

@implementation WCHomeCardSportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressD.frame = CGRectMake(87, 67, 250, 3);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSportImage:(UIImage *)image andNameTextLabel:(NSAttributedString *)attStr andPresent:(float)present{
    
    _sportImage.image = image;
    _nameTextLabel.attributedText = attStr;
    
    _progressD.progress = present;
    _progressD.trackTintColor = LIGHTGRAY_COLOR;
    _progressD.progressTintColor = DEEPBLUE_COLOR;
    int i = present*100;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i%%", i]];
    [attr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:24.f],
                             NSForegroundColorAttributeName : DEEPBLUE_COLOR
                             } range:NSMakeRange(0, attr.length)];
    
    UILabel *numberLabel = [UILabel new];
    numberLabel.attributedText = attr;
//    NSLog(@"%f",SCREEN_WIDTH-_progressD.origin.x-45);
    numberLabel.frame = CGRectMake((SCREEN_WIDTH-_progressD.origin.x-37)*present-10, -30, 33, 24);
    
    UIImage *dotImage = [UIImage imageNamed:@"blueDot_sportCell"];
    UIImageView *dotImageView = [[UIImageView alloc]initWithImage:dotImage];
    dotImageView.frame = CGRectMake((SCREEN_WIDTH-_progressD.origin.x-37)*present-3, -3, 9, 9);
    [_progressD addSubview:numberLabel];
    [_progressD addSubview:dotImageView];
}

@end
