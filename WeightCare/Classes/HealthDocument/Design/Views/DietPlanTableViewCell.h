//
//  DietPlanTableViewCell.h
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietPlanTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>{    
    CGSize collectionCellSize;
}

@property (weak, nonatomic) IBOutlet UIView *radiusView;

@property (weak, nonatomic) IBOutlet UILabel *eatTime;
@property (weak, nonatomic) IBOutlet UILabel *quantity;

@property (weak, nonatomic) IBOutlet UICollectionView *cellCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *refresh;

@property  NSArray *bfArr;
@property NSArray *lcArr;
@property NSArray *dnArr;
@property NSInteger cTag;

@end
