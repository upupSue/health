//
//  WCPersonalInfoViewController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/13.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCPersonalInfoViewController.h"
#import "WCPersonalInfoTableViewCell.h"
#import "ClockTableViewController.h"
#import "WCHealthDeviceViewController.h"
#import "WCPersonalSetViewController.h"
#import "PersonalViewController.h"
#import "WCPersonalBodyDataControllerViewController.h"
#import "CollectionPhotoController.h"
#import "LocalDBManager.h"
#import "WCBlueToothViewController.h"


static NSString *const WCPersonalInfoTableViewCellIdentfiy = @"WCPersonalInfoTableViewCellIdentify";

@interface WCPersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *personalInfoTableView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
- (IBAction)userHeadButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *manageCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkUpCard;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong ,nonatomic)NSArray *personalInfoTableViewCellImageArray;
@property (strong ,nonatomic)NSArray *personalInfoTableViewCellLabelArray;
@property (strong ,nonatomic) UIView *popView;

@property (weak, nonatomic) IBOutlet UIButton *headImg;


@end

@implementation WCPersonalInfoViewController



- (void)viewWillAppear:(BOOL)animated{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.barTintColor = BLUE_COLOR;
    NSArray *arrd = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _userNameLabel.text=arrd[0][@"uName"];

}


- (void)viewDidLoad{
    [super viewDidLoad];

    _headImg.layer.cornerRadius=65;
    _headImg.layer.borderWidth=4;
    _headImg.layer.borderColor=[UIColor whiteColor].CGColor;
    
    //设置tableView的数据源和委托
    self.personalInfoTableView.delegate   = self;
    self.personalInfoTableView.dataSource = self;
    
    //注册cell
    [self.personalInfoTableView registerNib:[UINib nibWithNibName:@"WCPersonalInfoTableViewCell" bundle:nil] forCellReuseIdentifier:WCPersonalInfoTableViewCellIdentfiy];
    
    //WCPeresonalInfoTableViewCell里的 image label 数组
    _personalInfoTableViewCellImageArray = [NSArray arrayWithObjects:@"document_personalInfo",@"alarm_personalInfo",@"photo_personalInfo",@"device_personalInfo",nil];
    _personalInfoTableViewCellLabelArray = [NSArray arrayWithObjects:@"健康数据",@"运动闹钟",@"运动相册",@"我的设备",nil];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


- (IBAction)leftBtn:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    WCPersonalSetViewController *pv=[[WCPersonalSetViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


#pragma mark TableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 71.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCPersonalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WCPersonalInfoTableViewCellIdentfiy forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:_personalInfoTableViewCellImageArray[indexPath.row]];
    [cell setPerosnalInfoTableCellImage:image andSetPersonalInfoTableCellLabel:_personalInfoTableViewCellLabelArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1){
        self.hidesBottomBarWhenPushed=YES;
        ClockTableViewController *clockTableViewController = [[ClockTableViewController alloc] init];
        [self.navigationController pushViewController:clockTableViewController animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    if (indexPath.row == 0){
        self.hidesBottomBarWhenPushed=YES;
        WCPersonalBodyDataControllerViewController *clockTableViewController = [[WCPersonalBodyDataControllerViewController alloc] init];
        [self.navigationController pushViewController:clockTableViewController animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    if (indexPath.row == 3) {
        self.hidesBottomBarWhenPushed=YES;
        WCBlueToothViewController *healthDeviceViewController = [[WCBlueToothViewController alloc] init];
        [self.navigationController pushViewController:healthDeviceViewController animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (indexPath.row == 2) {
        self.hidesBottomBarWhenPushed=YES;
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        CollectionPhotoController *pv = [[CollectionPhotoController alloc]initWithCollectionViewLayout:flow];
        [self.navigationController pushViewController:pv animated:YES];
        self.hidesBottomBarWhenPushed=NO;
            }
    
}


- (IBAction)userHeadButton:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    PersonalViewController *pv=[[PersonalViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (IBAction)DS:(id)sender {
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd 00:00:00"];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    NSDictionary *value = [[NSMutableDictionary alloc]init];
    NSMutableArray *valueArr = [[NSMutableArray alloc] init];
    
    if ([NSUserDefaults valueWithKey:@"currectWeight"]) {
        value = @{
                  @"Type":@"1",
                  @"Value":[NSUserDefaults valueWithKey:@"currectWeight"],
                  };
        [valueArr addObject:value];
    }
    else{
        value = @{
                  @"Type":@"1",
                  @"Value":@"0",
                  };
        [valueArr addObject:value];
    }
    if([NSUserDefaults valueWithKey:@"homeSport"]){
        value = @{
                  @"Type":@"2",
                  @"Value":[NSUserDefaults valueWithKey:@"homeSport"],
                  };
        [valueArr addObject:value];
    }
    else{
        value = @{
                  @"Type":@"2",
                  @"Value":@"0",
                  };
        [valueArr addObject:value];
    }
    if([NSUserDefaults valueWithKey:@"homeFood"]){
        value = @{
                  @"Type":@"3",
                  @"Value":[NSUserDefaults valueWithKey:@"homeFood"],
                  };
        [valueArr addObject:value];
    }
    else{
        value = @{
                  @"Type":@"3",
                  @"Value":@"0",
                  };
        [valueArr addObject:value];
    }
    
    [parameter setObject:[NSUserDefaults valueWithKey:@"userId"] forKey:@"HealtherId"];
    [parameter setObject:str forKey:@"RecordDay"];
    [parameter setObject:valueArr forKey:@"Values"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HandlerBusiness HealthRealServiceWithApicode:ApiCodeRecordHealth Parameters:parameter Success:^(id data, id msg){
        NSLog(@"Success");
        //在本地存储userId
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setPushView];
        });
        
    }Failed:^(NSInteger code ,id errorMsg){
        NSLog(@"failed");
        
        [self setFailPushView];
        
        //UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:errorMsg[@"prompt"] preferredStyle:UIAlertControllerStyleAlert];
        //[alertVC setDismissInterval:0.5];
        //[self presentViewController:alertVC animated:YES completion:nil];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }Complete:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    
}

-(void)setPushView{
    _popView=[[UIView alloc]initWithFrame:CGRectMake(0,0-24, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_popView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]];
    
    UIView *pushView=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-210)/2,(SCREEN_HEIGHT-180)/2, 210, 180)];
    [pushView setBackgroundColor:[UIColor whiteColor]];
    pushView.layer.cornerRadius=10;
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 210, 20)];
    title.text=@"已将您的数据传输到云端";
    title.textColor=BLUE_COLOR;
    title.textAlignment = NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:14];
    
    UIImageView *circleView=[[UIImageView alloc]initWithFrame:CGRectMake((210-66)/2, 45, 66, 66)];
    circleView.image = [UIImage imageNamed:@"Group6"];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 123, 210, 2)];
    line.backgroundColor=BG_COLOR;
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake((210-44)/2, 140, 44, 25)];
    [cancel setTitle:@"确定" forState:UIControlStateNormal];
    [cancel setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    cancel.titleLabel.font= [UIFont systemFontOfSize: 18];
    [cancel setBackgroundColor:[UIColor clearColor]];
    [cancel addTarget:self action:@selector(cancelPush) forControlEvents:UIControlEventTouchUpInside];
    
    [pushView addSubview:title];
    [pushView addSubview:circleView];
    [pushView addSubview:line];
    [pushView addSubview:cancel];
    
    [_popView addSubview:pushView];
    [self.view addSubview:_popView];
}

-(void)setFailPushView{
    _popView=[[UIView alloc]initWithFrame:CGRectMake(0,0-24, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_popView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]];
    
    UIView *pushView=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-210)/2,(SCREEN_HEIGHT-180)/2, 210, 180)];
    [pushView setBackgroundColor:[UIColor whiteColor]];
    pushView.layer.cornerRadius=10;
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake((210-56)/2, 15, 56, 20)];
    title.text=@"同步失败";
    title.textColor=BLUE_COLOR;
    title.font=[UIFont systemFontOfSize:14];
    
    UIView *circleView=[[UIView alloc]initWithFrame:CGRectMake((210-66)/2, 45, 66, 66)];
    circleView.backgroundColor=[UIColor whiteColor];
    circleView.layer.cornerRadius=33;
    circleView.layer.borderColor=BLUE_COLOR.CGColor;
    circleView.layer.borderWidth=4;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 123, 210, 2)];
    line.backgroundColor=BG_COLOR;
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake((210-36)/2, 140, 36, 25)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    cancel.titleLabel.font= [UIFont systemFontOfSize: 18];
    [cancel setBackgroundColor:[UIColor clearColor]];
    [cancel addTarget:self action:@selector(cancelPush) forControlEvents:UIControlEventTouchUpInside];
    
    [pushView addSubview:title];
    [pushView addSubview:circleView];
    [pushView addSubview:line];
    [pushView addSubview:cancel];
    
    [_popView addSubview:pushView];
    [self.view addSubview:_popView];
}



-(void)cancelPush{
    [_popView setHidden:YES];
}

@end
