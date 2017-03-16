//
//  WCLogInViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/9/1.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCLogInViewController.h"
#import "WCBaseTabBarController.h"


@interface WCLogInViewController ()<UITextFieldDelegate>{
    LoginType loginType;
}

@end

@implementation WCLogInViewController{
    UIImageView *headImageView;
    
    UIButton *logBtn;
    UIButton *registerBtn;
    UILabel *logBtnLabel;
    UILabel *registerBtnLabel;
    UIView *logBaseView;
    UIView *registerView;
    UITextField *userLogTextFiled;
    UITextField *psdLogTextFiled;
    UITextField *userTextFiled;
    UITextField *psdTextFiled;
    UITextField *psdConfirnTextFiled;
    UIButton *hidePsdBtn;
    UIButton *rememberPsdBtn;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    loginType=login;
    [self setHealthImageView];
    [self setLogView];
    [self setRegisterView];
    [self setButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setHealthImageView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 42.5, 89, 85, 85)];
    headView.backgroundColor = BG_COLOR;
    headView.layer.cornerRadius = 42.5;
    headView.layer.masksToBounds = YES;
    [self.view addSubview:headView];
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 73, 73)];
    [headImageView setImage:[UIImage imageNamed:@"PLhead"]];
    [headView addSubview:headImageView];
    
    UIImageView *healthImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-39, SCREEN_HEIGHT-55, 78, 40)];
    [healthImageView setImage:[UIImage imageNamed:@"Health"]];
    [self.view addSubview:healthImageView];
}

- (void)setLogView{
    //logBaseView
    logBaseView = [[UIView alloc] initWithFrame:CGRectMake(38, 238, SCREEN_WIDTH - 38*2, 129)];
    
    //用户名和密码输入框
    UIView *logView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 38*2, 100)];
    logView.layer.cornerRadius = 10.f;
    logView.layer.masksToBounds = YES;
    logView.layer.borderWidth = 1.f;
    logView.layer.borderColor = BG_COLOR.CGColor;
    [logBaseView addSubview:logView];
    
    UIView *cutLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH - 38*2, 1)];
    cutLineView.backgroundColor = BG_COLOR;
    [logView addSubview:cutLineView];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 16, 21.4, 20)];
    [userImageView setImage:[UIImage imageNamed:@"user"]];
    [logView addSubview:userImageView];
    
    UIImageView *passImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 66, 14, 20)];
    [passImageView setImage:[UIImage imageNamed:@"lock-open"]];
    [logView addSubview:passImageView];
    
    //textField
    userLogTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 18, 120, 20)];
    userLogTextFiled.delegate = self;
    userLogTextFiled.placeholder = @"用户名";
    [logView addSubview:userLogTextFiled];
    
    psdLogTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 68, 120, 20)];
    psdLogTextFiled.delegate = self;
    psdLogTextFiled.secureTextEntry = YES;
    psdLogTextFiled.placeholder = @"密码";
    [logView addSubview:psdLogTextFiled];
    
    //隐藏密码
    hidePsdBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 38*2) - 26 -11, 70, 26, 15)];
    [hidePsdBtn setImage:[UIImage imageNamed:@"preview"] forState:UIControlStateNormal];
    [hidePsdBtn setImage:[UIImage imageNamed:@"preview_h"] forState:UIControlStateSelected];
    [hidePsdBtn addTarget:self action:@selector(previewPsd) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:hidePsdBtn];
    
    //记住密码
    rememberPsdBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 112, 15, 15)];
    [rememberPsdBtn setImage:[UIImage imageNamed:@"forgotPassWord"] forState:UIControlStateNormal];
    [rememberPsdBtn setImage:[UIImage imageNamed:@"forgotPassWord_check"] forState:UIControlStateSelected];
    [rememberPsdBtn addTarget:self action:@selector(remenberPsd) forControlEvents:UIControlEventTouchUpInside];
    UILabel *rememberPsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 109, 56, 20)];
    rememberPsdLabel.text = @"记住密码";
    rememberPsdLabel.textColor = DEEPGRAY_COLOR;
    rememberPsdLabel.font = [UIFont fontWithName:PINGFANG size:14];
    
    //忘记密码
    UIButton *forgotPsdBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 38*2) - 80 - 10, 112, 75, 15)];
    [forgotPsdBtn addTarget:self action:@selector(forgotPsd) forControlEvents:UIControlEventTouchUpInside];
    UILabel *forgotPsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
    forgotPsdLabel.text = @"忘记密码 >>";
    forgotPsdLabel.textColor = DEEPGRAY_COLOR;
    forgotPsdLabel.textAlignment = NSTextAlignmentCenter;
    forgotPsdLabel.font = [UIFont fontWithName:PINGFANG size:14];
    [forgotPsdBtn addSubview:forgotPsdLabel];
    
    [logBaseView addSubview:rememberPsdBtn];
    [logBaseView addSubview:rememberPsdLabel];
    [logBaseView addSubview:forgotPsdBtn];
    
    [self.view addSubview:logBaseView];
    
}

- (void)setRegisterView{
    //registerView
    registerView = [[UIView alloc] initWithFrame:CGRectMake(38, 238, SCREEN_WIDTH - 38*2, 150)];
    registerView.layer.cornerRadius = 10.f;
    registerView.layer.masksToBounds = YES;
    registerView.layer.borderWidth = 1.f;
    registerView.layer.borderColor = BG_COLOR.CGColor;
    
    UIView *cutLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH - 38*2, 1)];
    cutLineView.backgroundColor = BG_COLOR;
    [registerView addSubview:cutLineView];
    
    UIView *cutLine2View = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH - 38*2, 1)];
    cutLine2View.backgroundColor = BG_COLOR;
    [registerView addSubview:cutLine2View];

    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 16, 21.4, 20)];
    [userImageView setImage:[UIImage imageNamed:@"user"]];
    [registerView addSubview:userImageView];
    
    UIImageView *passImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 66, 14, 20)];
    [passImageView setImage:[UIImage imageNamed:@"lock-open"]];
    [registerView addSubview:passImageView];
    
    UIImageView *passLockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 116, 14, 20)];
    [passLockImageView setImage:[UIImage imageNamed:@"lock"]];
    [registerView addSubview:passLockImageView];
    
    //textField
    userTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 18, 120, 20)];
    userTextFiled.delegate = self;
    userTextFiled.placeholder = @"用户名";
    [registerView addSubview:userTextFiled];
    
    psdTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 68, 120, 20)];
    psdTextFiled.delegate = self;
    psdTextFiled.secureTextEntry = YES;
    psdTextFiled.placeholder = @"密码";
    [registerView addSubview:psdTextFiled];
    
    psdConfirnTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 118, 120, 20)];
    psdConfirnTextFiled.delegate = self;
    psdConfirnTextFiled.secureTextEntry = YES;
    psdConfirnTextFiled.placeholder = @"确认密码";
    [registerView addSubview:psdConfirnTextFiled];

    [self.view addSubview:registerView];
    registerView.hidden = YES;

}

- (void)setButton{
    logBtn = [[UIButton alloc] initWithFrame:CGRectMake(38, 427, SCREEN_WIDTH - 10 - 64-38 - 38, 60)];
    logBtn.backgroundColor = BLUE_COLOR;
    logBtn.layer.cornerRadius = 10.f;
    logBtn.layer.masksToBounds = YES;
    [logBtn addTarget:self action:@selector(logInBtn) forControlEvents:UIControlEventTouchUpInside];
    logBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 10 - 64-38 - 38)/2-27, 16, 54, 28)];
    logBtnLabel.text = @"登录";
    logBtnLabel.textColor = [UIColor whiteColor];
    logBtnLabel.font = [UIFont fontWithName:PINGFANG size:20.f];
    logBtnLabel.textAlignment = NSTextAlignmentCenter;
    [logBtn addSubview:logBtnLabel];
    [self.view addSubview:logBtn];
    
    registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 64 -38, 427, 64, 60)];
    registerBtn.backgroundColor = WHITE_COLOR;
    registerBtn.layer.cornerRadius = 10.f;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.borderWidth = 1.f;
    registerBtn.layer.borderColor = BLUE_COLOR.CGColor;
    registerBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(64/2-27, 16, 54, 28)];
    registerBtnLabel.text = @"注册";
    registerBtnLabel.textColor = BLUE_COLOR;
    registerBtnLabel.font = [UIFont fontWithName:PINGFANG size:20.f];
    registerBtnLabel.textAlignment = NSTextAlignmentCenter;
    [registerBtn addSubview: registerBtnLabel];
    [registerBtn addTarget:self action:@selector(registerInBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}

#pragma mark - textField Delegate
//键盘退出
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [userLogTextFiled resignFirstResponder];
    [psdLogTextFiled resignFirstResponder];
    [userTextFiled resignFirstResponder];
    [psdTextFiled resignFirstResponder];
    [psdConfirnTextFiled resignFirstResponder];
}

//点击RETURN
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(userLogTextFiled.text.length!=0)//登录用户名输入框
    {
        [psdLogTextFiled becomeFirstResponder];
        [userLogTextFiled resignFirstResponder];
    }
    if(psdLogTextFiled.text.length!=0)//登录密码输入框
    {
        [psdLogTextFiled resignFirstResponder];
    }
    if(userTextFiled.text.length!=0)//注册用户名输入框
    {
        [psdTextFiled becomeFirstResponder];
        [userTextFiled resignFirstResponder];
    }
    if(psdTextFiled.text.length!=0)//注册密码输入框
    {
        [psdConfirnTextFiled becomeFirstResponder];
        [psdTextFiled resignFirstResponder];
    }
    if(psdConfirnTextFiled.text.length!=0)//注册确认密码输入框
    {
        [psdConfirnTextFiled resignFirstResponder];
    }

    return YES;
}

#pragma mark button action

- (void)logInBtn{
    if(loginType==login){
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
        [parameter setObject:userLogTextFiled.text forKey:@"HealtherName"];
        [parameter setObject:[psdLogTextFiled.text md5to16Hash] forKey:@"PasswordMd5"];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HandlerBusiness HealthRealServiceWithApicode:ApiCodeLogin Parameters:parameter Success:^(id data, id msg){
            NSLog(@"Success");
            //在本地存储userId
            [NSUserDefaults saveValue:data[@"HealtherId"] forKey:@"userId"];
            //登录成功后在本地存储一个判断登录成功的bool数
            [NSUserDefaults saveBoolValue:YES withKey:@"isLogIn"];
            WCBaseTabBarController *vc =[[WCBaseTabBarController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC setDismissInterval:ALERT_TIME];
                [self presentViewController:alertVC animated:YES completion:nil];
            });
        
        }Failed:^(NSInteger code ,id errorMsg){
            NSLog(@"failed");
        
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:errorMsg[@"prompt"] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC setDismissInterval:0.5];	
            [self presentViewController:alertVC animated:YES completion:nil];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }Complete:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else{
        loginType=login;
        logBtn.frame = CGRectMake(38, 427, SCREEN_WIDTH - 10 - 64-38 - 38, 60);
        registerBtn.frame = CGRectMake(SCREEN_WIDTH - 64 -38, 427, 64, 60);
        logBtnLabel.frame = CGRectMake((SCREEN_WIDTH - 10 - 64-38 - 38)/2-27, 16, 54, 28);
        registerBtnLabel.frame = CGRectMake(64/2-27, 16, 54, 28);
        [headImageView setImage:[UIImage imageNamed:@"PLhead"]];
        
        userTextFiled.text = nil;
        psdTextFiled.text = nil;
        psdConfirnTextFiled.text = nil;
        
        logBaseView.hidden = NO;
        registerView.hidden = YES;
    }
}

- (void)registerInBtn{
    //用户登录界面跳转到注册页面
    if(loginType==regis){
        if(userTextFiled.text.length == 0){
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC setDismissInterval:ALERT_TIME];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        else{
            if(psdTextFiled.text.length == 0){
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC setDismissInterval:ALERT_TIME];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
            else{
                if(psdConfirnTextFiled.text.length == 0){
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"请确认密码" preferredStyle:UIAlertControllerStyleAlert];
                    [alertVC setDismissInterval:ALERT_TIME];
                    [self presentViewController:alertVC animated:YES completion:nil];
                }
                else{
                    if ([psdTextFiled.text isEqual:psdConfirnTextFiled.text]) {
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
                        [alertVC setDismissInterval:ALERT_TIME];
                        [self presentViewController:alertVC animated:YES completion:nil];
                        
                        //注册成功跳转到登录界面
                        logBtn.frame = CGRectMake(38, 427, SCREEN_WIDTH - 10 - 64-38 - 38, 60);
                        registerBtn.frame = CGRectMake(SCREEN_WIDTH - 64 -38, 427, 64, 60);
                        logBtnLabel.frame = CGRectMake((SCREEN_WIDTH - 10 - 64-38 - 38)/2-27, 16, 54, 28);
                        registerBtnLabel.frame = CGRectMake(64/2-27, 16, 54, 28);
                        [headImageView setImage:[UIImage imageNamed:@"PLhead"]];
                        
                        userTextFiled.text = nil;
                        psdTextFiled.text = nil;
                        psdConfirnTextFiled.text = nil;
                        
                        logBaseView.hidden = NO;
                        registerView.hidden = YES;
                        
                    }
                    else{
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"两次密码不一致" preferredStyle:UIAlertControllerStyleAlert];
                        [alertVC setDismissInterval:ALERT_TIME];
                        [self presentViewController:alertVC animated:YES completion:nil];
                    }
                }
            }
        }
    }
    else{
        loginType=regis;
        logBtn.frame = CGRectMake(38, 427, 64, 60);
        registerBtn.frame = CGRectMake(38 + 64 + 10, 427, SCREEN_WIDTH - 38 - 10 - 64 - 38, 60);
        logBtnLabel.frame = CGRectMake(64/2-27, 16, 54, 28);
        registerBtnLabel.frame = CGRectMake((SCREEN_WIDTH - 10 - 64-38 - 38)/2-27, 16, 54, 28);
        [headImageView setImage:[UIImage imageNamed:@"user_nil"]];
        
        userLogTextFiled.text = nil;
        psdLogTextFiled.text = nil;
        
        logBaseView.hidden = YES;
        registerView.hidden = NO;

    }

}

//密码是否可见
- (void)previewPsd{
    if(psdLogTextFiled.secureTextEntry){
        psdLogTextFiled.secureTextEntry = NO;
        hidePsdBtn.selected = NO;
        //这里没有闭眼的图片
    }
    else{
        psdLogTextFiled.secureTextEntry = YES;
        hidePsdBtn.selected = YES;
    }
}

- (void)remenberPsd{
    
    if (rememberPsdBtn.isSelected == NO) {
//        userLogTextFiled.text = @"q";
//        psdLogTextFiled.text = @"q";
        rememberPsdBtn.selected = YES;
    }
    else{
//        userLogTextFiled.text = nil;
//        psdLogTextFiled.text = nil;
        rememberPsdBtn.selected = NO;
    }
}

- (void)forgotPsd{
    NSLog(@"forgotPsd");
}





@end
