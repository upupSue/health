//
//  ViewController.h
//  Remind
//
//  Created by 王佳楠 on 16/7/19.
//  Copyright © 2016年 study. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController:UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *pickerArray;
    NSArray *pickerArray2;
    NSArray *subPickerArray;
    NSArray *subPickerArray2;
    NSDictionary *dicPicker2;
    NSDictionary *dicPicker;
}

@property (weak, nonatomic) IBOutlet UIButton *GroupOne;
@property (weak, nonatomic) IBOutlet UIButton *GroupTwo;
@property (weak, nonatomic) IBOutlet UIButton *GroupThree;
@property (weak, nonatomic) IBOutlet UIButton *GroupFour;
@property (weak, nonatomic) IBOutlet UIButton *GroupFive;
@property (weak, nonatomic) IBOutlet UIButton *GroupSix;
@property (weak, nonatomic) IBOutlet UIButton *GroupSeven;
@property (weak, nonatomic) IBOutlet UILabel *SelectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *FootBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *ClockPoint;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerViewHealth;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePickerView;
@property (weak, nonatomic) IBOutlet UIImageView *MiddleBackgroundView;


@end
