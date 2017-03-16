//
//  WCHomeActionSheetView.h
//  WeightCare
//
//  Created by KentonYu on 16/7/16.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHomeActionSheetView : UIView

/**
 *  keys: title(NSString) / showed(BOOL)
 */
@property (nonatomic, strong) NSArray<NSDictionary *> *actionInfoArray;

@end
