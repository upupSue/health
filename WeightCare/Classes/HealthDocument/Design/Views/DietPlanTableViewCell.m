//
//  DietPlanTableViewCell.m
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "DietPlanTableViewCell.h"
#import "DietPlanCollectionViewCell.h"

static NSString *const collectionCellIdentity = @"collectionCellIdentity";

@implementation DietPlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _radiusView.layer.cornerRadius=8;
    _radiusView.clipsToBounds=YES;
    
    _cellCollectionView.delegate = self;
    _cellCollectionView.dataSource = self;
    _cellCollectionView.backgroundColor = [UIColor whiteColor];
    [_cellCollectionView registerNib:[UINib nibWithNibName:@"DietPlanCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellIdentity];
    
    collectionCellSize = CGSizeMake(80, 119);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark UICollectionViewDataSource UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_cTag==0){
        return _bfArr.count;
    }
    if(_cTag==1){
        return _lcArr.count;
    }
    else{
        return _dnArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DietPlanCollectionViewCell *cell = [self.cellCollectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentity forIndexPath:indexPath];
    if(_cTag==0){
        [cell SetFoodImg:[UIImage imageNamed:_bfArr[indexPath.row][@"foodImg"]] SetFoodName:_bfArr[indexPath.row][@"foodName"] SetFoodAmount:_bfArr[indexPath.row][@"foodAmount"]];
    }
    else if(_cTag==1){
        [cell SetFoodImg:[UIImage imageNamed:_lcArr[indexPath.row][@"foodImg"]] SetFoodName:_lcArr[indexPath.row][@"foodName"] SetFoodAmount:_lcArr[indexPath.row][@"foodAmount"]];
    }
    else{
        [cell SetFoodImg:[UIImage imageNamed:_dnArr[indexPath.row][@"foodImg"]] SetFoodName:_dnArr[indexPath.row][@"foodName"] SetFoodAmount:_dnArr[indexPath.row][@"foodAmount"]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    return collectionCellSize;
}

//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  10;
}

@end
