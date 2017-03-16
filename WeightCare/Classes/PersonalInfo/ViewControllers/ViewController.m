//
//  ViewController.m
//  Remind
//
//  Created by 王佳楠 on 16/7/19.
//  Copyright © 2016年 study. All rights reserved.
//

#import "ViewController.h"
#import "ClockTableViewController.h"
#import "ClockTableViewCell.h"
#define kFirstComponent 0
#define kSubComponent 1
@interface ViewController ()
@property NSInteger flag;

@end

@implementation ViewController
@synthesize PickerViewHealth;

-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    self.DatePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}
- (void)viewDidLoad {
    _flag=0;
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80/255. green:176/255. blue:255/255. alpha:1.0];
    self.navigationItem.title = @"添加闹钟";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow-thin-left.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"checkmark.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    
    //周期选择
    [self.GroupOne addTarget:self action:@selector(ChangeOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupTwo addTarget:self action:@selector(ChangeTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupThree addTarget:self action:@selector(ChangeThree:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupFour addTarget:self action:@selector(ChangeFour:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupFive addTarget:self action:@selector(ChangeFive:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupSix addTarget:self action:@selector(ChangeSix:) forControlEvents:UIControlEventTouchUpInside];
    [self.GroupSeven addTarget:self action:@selector(ChangeSeven:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //PickerView
    pickerArray = [NSArray arrayWithObjects:@"运动提醒",@"饮食提醒", nil];
    dicPicker = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSArray arrayWithObjects:@"跑步",@"哑铃",@"自行车",@"瑜伽",@"跳绳",            nil], @"运动提醒",
                 [NSArray arrayWithObjects:@"早餐",@"中餐",@"晚餐", nil], @"饮食提醒",nil];
    
    subPickerArray = [dicPicker objectForKey:@"运动提醒"];
    PickerViewHealth.delegate = self;
    PickerViewHealth.dataSource = self;
    
    
    typedef enum {
        UIDatePickerModeTime,
        UIDatePickerModeDate,
        UIDatePickerModeDateAndTime,
        UIDatePickerModeCountDownTimer
    } UIDatePickerMode;
    
    _DatePickerView.datePickerMode = UIDatePickerModeTime;
    //这儿即是改变显示的模式
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addItem{
    NSDate *date = self.DatePickerView.date;
    NSLog(@"Setting a reminder for %@", date);
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"时间到啦！";
    note.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)ChangeOne:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupOne setBackgroundImage:[UIImage imageNamed:@"Group Oneblack.png"] forState:UIControlStateNormal];
        [self.GroupOne setBackgroundImage:[UIImage imageNamed:@"Group One.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupOne setBackgroundImage:[UIImage imageNamed:@"Group One.png"] forState:UIControlStateNormal];
        [self.GroupOne setBackgroundImage:[UIImage imageNamed:@"Group Oneblack.png"] forState:UIControlStateNormal];
    }
    
}
-(void)ChangeTwo:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupTwo setBackgroundImage:[UIImage imageNamed:@"Group Twoblack.png"] forState:UIControlStateNormal];
        [self.GroupTwo setBackgroundImage:[UIImage imageNamed:@"Group Two.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupTwo setBackgroundImage:[UIImage imageNamed:@"Group Two.png"] forState:UIControlStateNormal];
        [self.GroupTwo setBackgroundImage:[UIImage imageNamed:@"Group Twoblack.png"] forState:UIControlStateNormal];
    }
    
}
-(void)ChangeThree:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupThree setBackgroundImage:[UIImage imageNamed:@"Group Threeblack.png"] forState:UIControlStateNormal];
        [self.GroupThree setBackgroundImage:[UIImage imageNamed:@"Group Three.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupThree setBackgroundImage:[UIImage imageNamed:@"Group Three.png"] forState:UIControlStateNormal];
        [self.GroupThree setBackgroundImage:[UIImage imageNamed:@"Group Threeblack.png"] forState:UIControlStateNormal];
    }
    
}
-(void)ChangeFour:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupFour setBackgroundImage:[UIImage imageNamed:@"Group Fourblack.png"] forState:UIControlStateNormal];
        [self.GroupFour setBackgroundImage:[UIImage imageNamed:@"Group Four.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupFour setBackgroundImage:[UIImage imageNamed:@"Group Four.png"] forState:UIControlStateNormal];
        [self.GroupFour setBackgroundImage:[UIImage imageNamed:@"Group Fourblack.png"] forState:UIControlStateNormal];
    }
    
}
-(void)ChangeFive:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupFive setBackgroundImage:[UIImage imageNamed:@"Group Fiveblack.png"] forState:UIControlStateNormal];
        [self.GroupFive setBackgroundImage:[UIImage imageNamed:@"Group Five.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupFive setBackgroundImage:[UIImage imageNamed:@"Group Five.png"] forState:UIControlStateNormal];
        [self.GroupFive setBackgroundImage:[UIImage imageNamed:@"Group Fiveblack.png"] forState:UIControlStateNormal];
    }
    
}
-(void)ChangeSix:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupSix setBackgroundImage:[UIImage imageNamed:@"Group Sixblack.png"] forState:UIControlStateNormal];
        [self.GroupSix setBackgroundImage:[UIImage imageNamed:@"Group Six.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupSix setBackgroundImage:[UIImage imageNamed:@"Group Six.png"] forState:UIControlStateNormal];
        [self.GroupSix setBackgroundImage:[UIImage imageNamed:@"Group Sixblack.png"] forState:UIControlStateNormal];
    }
    
}

-(void)ChangeSeven:(id)sender{
    if(!self.flag){
        self.flag = 1;
        [self.GroupSeven setBackgroundImage:[UIImage imageNamed:@"Group Sevenblack.png"] forState:UIControlStateNormal];
        [self.GroupSeven setBackgroundImage:[UIImage imageNamed:@"Group Seven.png"] forState:UIControlStateNormal];
    }
    else{
        self.flag = 0;
        [self.GroupSeven setBackgroundImage:[UIImage imageNamed:@"Group Seven.png"] forState:UIControlStateNormal];
        [self.GroupSeven setBackgroundImage:[UIImage imageNamed:@"Group Sevenblack.png"] forState:UIControlStateNormal];
    }
    
}
#pragma mark - Picker Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == kFirstComponent){
        return [pickerArray count];
    }else {
        return [subPickerArray count];
    }
    
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == kFirstComponent){
        return [pickerArray objectAtIndex:row];
    }else {
        return [subPickerArray objectAtIndex:row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == kFirstComponent) {
        subPickerArray = [dicPicker objectForKey:[pickerArray objectAtIndex:row]];
        [pickerView selectRow:0 inComponent:kSubComponent animated:YES];
        [pickerView reloadComponent:kSubComponent];
    }
}




@end
