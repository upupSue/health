//
//  WCHomeCardSwitchView.h
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCHomeCardSwitchView;

@protocol WCHomeCardSwitchViewDelegate <NSObject>

/**
 *  卡片选择器的数据源
 *
 *  @param switchView
 *
 *  @return 返回数据源 如果显示继续添加按钮，则也要包含在数据源中
 *  keys:  cardType
 */
- (NSArray<NSDictionary *> *)wcHomeCardSwitchViewDataSource:(WCHomeCardSwitchView *)switchView;

- (void)wcHomeCardSwitchViewClickIndex:(NSInteger)index;

@end

@interface WCHomeCardSwitchView : UIView

@property (nonatomic, assign) id<WCHomeCardSwitchViewDelegate> delegate;

- (void)reloadData;
- (void)insertItemsAtIndex:(NSInteger)index;
- (void)deleteItemsAtIndex:(NSInteger)index;

@end
