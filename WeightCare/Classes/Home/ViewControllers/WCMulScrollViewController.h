//
//  WCMulScrollViewController.h
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/8/29.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCMulScrollViewController : UIViewController

@property (nonatomic, assign) NSInteger viewType;
@property (nonatomic, assign) NSString *fNo;
@property (nonatomic, assign) NSString *fIntake;
@property (nonatomic, assign) NSString *fcNo;

@property (nonatomic, assign) NSString *sNo;
@property (nonatomic, assign) NSString *waste;
@property (nonatomic, assign) NSString *scNo;
@property (nonatomic, assign)NSMutableArray *ssNo;
@end
