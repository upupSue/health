//
//  WCHomeCardSwitchView.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeCardSwitchView.h"
#import "WCHomeCollectionViewFlowLayout.h"
#import "WCHomeSwitchCardAddCollectionViewCell.h"
#import "WCHomeSwitchCardWeightCollectionViewCell.h"
#import "WCHomeSwitchCardFoodCollectionViewCell.h"
#import "WCHomeSwitchCardSportsCollectionViewCell.h"
#import "LocalDBManager.h"

static NSString *const WCHomeSwitchCardAddCollectionViewCellIdentity = @"WCHomeSwitchCardAddCollectionViewCellIdentity";
static NSString *const WCHomeSwitchCardWeightCollectionViewCellIdentity = @"WCHomeSwitchCardWeightCollectionViewCellIdentity";
static NSString *const WCHomeSwitchCardFoodCollectionViewCellIdentity = @"WCHomeSwitchCardFoodCollectionViewCellIdentity";
static NSString *const WCHomeSwitchCardSportsCollectionViewCellIdentity = @"WCHomeSwitchCardSportsCollectionViewCellIdentity";

@interface WCHomeCardSwitchView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSourceArray;

@end

@implementation WCHomeCardSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


#pragma mark - Public

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)insertItemsAtIndex:(NSInteger)index {

}

- (void)deleteItemsAtIndex:(NSInteger)index {

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCHomeCardManagerEnum cardType = (WCHomeCardManagerEnum)[self.dataSourceArray[indexPath.row][@"cardType"] integerValue];
    switch (cardType) {
        case WCHomeCardManagerEnumAdd: {
            WCHomeSwitchCardAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCHomeSwitchCardAddCollectionViewCellIdentity forIndexPath:indexPath];
            return cell;
        }
        case WCHomeCardManagerEnumSport: {
            WCHomeSwitchCardSportsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCHomeSwitchCardSportsCollectionViewCellIdentity forIndexPath:indexPath];
            return cell;
        }
        case WCHomeCardManagerEnumFood: {
            WCHomeSwitchCardFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCHomeSwitchCardFoodCollectionViewCellIdentity forIndexPath:indexPath];
//            cell.totalHot = [[NSUserDefaults valueWithKey:@"totalCariol"] integerValue];
//            cell.takedHot = 170;
//            cell.todayRemainTake = [[NSUserDefaults valueWithKey:@"todayRemainTake"] integerValue];
            return cell;
        }
        case WCHomeCardManagerEnumWeight: {
            WCHomeSwitchCardWeightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCHomeSwitchCardWeightCollectionViewCellIdentity forIndexPath:indexPath];
            
             NSArray *arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
             //NSArray *arry = [[LocalDBManager sharedManager] readUserIfo:@"2"];

            cell.currentWeight = [[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
            cell.startWeight   = [arry[arry.count-1][@"sWeight"] floatValue];
            cell.targetWeight  = [arry[arry.count-1][@"tWeight"] floatValue];
//             NSArray *arry = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
//             NSArray *arry = [[LocalDBManager sharedManager] readUserIfo:@"2"];
//            cell.currentWeight = [[NSUserDefaults valueWithKey:@"currectWeight"] floatValue];
//            cell.startWeight   = [arry[arry.count-1][@"sWeight"] floatValue];
//            cell.targetWeight  = [arry[arry.count-1][@"tWeight"] floatValue];
            return cell;
        }
    }
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wcHomeCardSwitchViewClickIndex:)]) {
        [self.delegate wcHomeCardSwitchViewClickIndex:indexPath.row];
    }
}


#pragma mark - UICollectionViewLayoutDelegate


#pragma mark - Getter 

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            WCHomeCollectionViewFlowLayout *layout = [[WCHomeCollectionViewFlowLayout alloc] init];
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:layout];
            collectionView.backgroundColor = [UIColor clearColor];
            collectionView.showsHorizontalScrollIndicator = NO;
            collectionView.dataSource = self;
            collectionView.delegate   = self;
            [collectionView registerNib:[UINib nibWithNibName:@"WCHomeSwitchCardAddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WCHomeSwitchCardAddCollectionViewCellIdentity];
            [collectionView registerNib:[UINib nibWithNibName:@"WCHomeSwitchCardWeightCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WCHomeSwitchCardWeightCollectionViewCellIdentity];
            [collectionView registerNib:[UINib nibWithNibName:@"WCHomeSwitchCardFoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WCHomeSwitchCardFoodCollectionViewCellIdentity];
            [collectionView registerNib:[UINib nibWithNibName:@"WCHomeSwitchCardSportsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WCHomeSwitchCardSportsCollectionViewCellIdentity];
            [self addSubview:collectionView];
            collectionView;
        });
    }
    return _collectionView;
}

- (NSArray<NSDictionary *> *)dataSourceArray {
    _dataSourceArray = [NSArray new];
    if (self.delegate && [self.delegate respondsToSelector:@selector(wcHomeCardSwitchViewDataSource:)]) {
        _dataSourceArray = [self.delegate wcHomeCardSwitchViewDataSource:self];
    }
    return _dataSourceArray;
}

@end
