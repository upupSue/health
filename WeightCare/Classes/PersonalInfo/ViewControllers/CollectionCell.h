//
//  CollectionCell.h
//  WeightCare
//
//  Created by 王佳楠 on 16/9/11.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionCell;

@protocol CollectionCellDelegate <NSObject>

-(void)moveImageBtnClick:(CollectionCell *)aCell;

@end

@interface CollectionCell : UICollectionViewCell
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;
@property(nonatomic ,strong)UIButton *btn;
@property(nonatomic,strong)UIButton * close;
@property(nonatomic,assign)id<CollectionCellDelegate>delegate;

@end
