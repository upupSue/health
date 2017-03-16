//
//  ClockTableViewCell.m
//  Remind
//
//  Created by 王佳楠 on 16/7/22.
//  Copyright © 2016年 study. All rights reserved.
//

#import "ClockTableViewCell.h"

#define kNotificationCategoryIdentifile @"kNotificationCategoryIdentifile"
#define kLocalNotificationKey @"kLocalNotificationKey"
@implementation ClockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ClockSwitch:(UISwitch *)sender {
    if(isSelect == 0){
        
        NSLog(@"%@",_TimeClockLabel.text);
        //闹钟时间
        NSString *hourStr, *minStr;//小时字符串 分钟字符串
        hourStr = _TimeClockLabel.text;
        minStr = [hourStr substringFromIndex:hourStr.length-2];
        NSInteger hourInt = [hourStr integerValue];//小时int型
        NSInteger minInt = [minStr integerValue];//分钟int型
        
        NSInteger clockSecond = hourInt * 3600 + minInt * 60;//转换成秒
        
        //当前时间
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags =  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSInteger hour = [dateComponent hour];
        NSInteger minute = [dateComponent minute];
        NSInteger second = [dateComponent second];
        
        NSInteger currectSecond = hour *3600 + minute *60 + second;
        
        NSInteger leastSecond;
        
        if ((clockSecond - currectSecond) > 0) {
            leastSecond = clockSecond - currectSecond;
        }
        else{
            leastSecond = 24*3600 - currectSecond + clockSecond;
        }
        
        
        isSelect = 1;
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //触发通知时间
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:leastSecond];
        //重复间隔
        localNotification.repeatInterval = kCFCalendarUnitHour;
        
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        //通知内容
        localNotification.alertBody = @"要开始运动啦";
        localNotification.applicationIconBadgeNumber = 1;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        //通知参数
        localNotification.userInfo = @{kLocalNotificationKey: @"kLocalNotification"};
        
        localNotification.category = kNotificationCategoryIdentifile;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    }
    else if(isSelect == 1){
        NSLog(@"close");
        
        for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
            if ([obj.userInfo.allKeys containsObject:kLocalNotificationKey]) {
                [[UIApplication sharedApplication] cancelLocalNotification:obj];
            }
        }
        
        isSelect = 0;

    }
}

- (void)addLocalNotificationWithFireDate:(NSDate *)date activityId:(int)aid activityTitle:(NSString *)title forKeyName:(NSString *)keyname {
    
    
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification) {
        
        notification.fireDate = date;
        
        
        notification.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        
        notification.applicationIconBadgeNumber++;
        
        
        notification.soundName = @"自然晨曦.caf";
        
        notification.alertBody = [NSString stringWithFormat:@"%@",title];
        
        notification.alertAction = @"打开";  //提示框按钮

        // 设定通知的userInfo，用来标识该通知
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:aid],keyname,nil];
        notification.userInfo = dict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
    
}



@end
