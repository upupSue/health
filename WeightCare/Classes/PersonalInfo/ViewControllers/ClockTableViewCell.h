//
//  ClockTableViewCell.h
//  Remind
//
//  Created by 王佳楠 on 16/7/22.
//  Copyright © 2016年 study. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClockTableViewCellDelegate <NSObject>

//委托方法
- (void)isSelected:(BOOL)select TimeClockText:(NSString *)text;

@end

@interface ClockTableViewCell : UITableViewCell
{
    BOOL isSelect;
    
}

- (IBAction)ClockSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *TimeClockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ClockImage;
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundWhite;
 
//Cell的委托
@property (assign, nonatomic) id<ClockTableViewCellDelegate> delegate;


@end
