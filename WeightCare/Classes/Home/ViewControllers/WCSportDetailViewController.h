//
//  WCSportDetailViewController.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/8/30.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCSportDetailViewController : UIViewController

@property (nonatomic, assign)float progress;
@property (nonatomic, assign)NSString *name;
@property (nonatomic, assign)NSString *target;
@property (nonatomic, assign)NSString *unit;
@property (nonatomic, assign)NSString *complete;

@property (nonatomic, assign)NSString *waste;
@property (nonatomic, assign)NSString *scNo;
@property (nonatomic, assign)NSString *sNo;
@property (nonatomic, assign)NSMutableArray *ssNo;

@end
