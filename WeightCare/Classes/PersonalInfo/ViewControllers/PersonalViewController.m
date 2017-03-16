//
//  PersonalViewController.m
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalUserViewController.h"
#import "WCPersonalInfoViewController.h"
#import "PersonalViewHeightControllerViewController.h"
#import "PersonalWeightViewController.h"
#import "LocalDBManager.h"
#import "PersonalTarWeightViewController.h"
@interface PersonalViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation PersonalViewController
@synthesize actionSheet = _actionSheet;

-(void)viewWillAppear:(BOOL)animated{
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewWillAppear:animated];
    //self.DatePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
     NSArray *arrd= [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _UserLabel.text=arrd[0][@"uName"];

    NSArray *arrd2 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    if([arrd2[0][@"uSix"] intValue]==1){
        _SexLable.text=@"男";
    }
    if([arrd2[0][@"uSix"] intValue]==0){
        _SexLable.text=@"女";
    }

        NSArray *arrd3 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _TimeLable.text=arrd3[0][@"uDate"];
    
    NSArray *arrd4 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _HtLable.text=[NSString stringWithFormat:@"%@cm",arrd4[0][@"uHeight"]];

    
    NSArray *arrd5 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _FinalHtLable.text=[NSString stringWithFormat:@"%@kg",arrd5[0][@"tWeight"]];
    
    NSArray *arrd6 = [[LocalDBManager sharedManager] readUserIfo:[NSUserDefaults valueWithKey:@"userId"]];
    _FirstHtLable.text=[NSString stringWithFormat:@"%@kg",arrd6[0][@"sWeight"]];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _WCPViewOne.layer.cornerRadius=10;
    _WCPViewTwo.layer.cornerRadius=10;
    
    self.view.backgroundColor=[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.0];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Rectangle.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"个人资料";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"PLleftBtn.png"] style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    }

- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil ,nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil,nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
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
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.PLheadImage.image = image;
}

- (IBAction)HeadClickButtonBig:(UIButton *)sender {
    [self callActionSheetFunc];
}

- (IBAction)UserClickButtonBig:(UIButton *)sender {
    self.hidesBottomBarWhenPushed=YES;
    PersonalUserViewController *CL = [[PersonalUserViewController alloc] init];
    [self.navigationController pushViewController:CL animated:YES];
    
    
}

- (IBAction)SexButtonBig:(UIButton *)sender {
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alterController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        _SexLable.text = @"男";
        [[LocalDBManager sharedManager]setUserSex:1 userId:[NSUserDefaults valueWithKey:@"userId"]];

    }]];
    [alterController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        _SexLable.text = @"女";
        [[LocalDBManager sharedManager]setUserSex:0 userId:[NSUserDefaults valueWithKey:@"userId"]];
    }]];
    
    [alterController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alterController animated:YES completion:nil];
}

- (IBAction)TimeButtonBig:(UIButton *)sender {
    
}

- (IBAction)HtButtonBig:(UIButton *)sender {
    NSLog(@"HtButton");
    self.hidesBottomBarWhenPushed=YES;
    PersonalViewHeightControllerViewController *pv=[[PersonalViewHeightControllerViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)FirstWtButtonBig:(UIButton *)sender {
    NSLog(@"FirstWtButton");
    self.hidesBottomBarWhenPushed=YES;
    PersonalWeightViewController *pv=[[PersonalWeightViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (IBAction)FinallWtButtonBig:(UIButton *)sender {
    NSLog(@"FinallWtButton");
    self.hidesBottomBarWhenPushed=YES;
    PersonalTarWeightViewController *pv=[[PersonalTarWeightViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}
@end
