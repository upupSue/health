//
//  WCTouchIDViewController.m
//  WeightCare
//
//  Created by KentonYu on 16/7/15.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCTouchIDViewController.h"
#import "WCBaseTabBarController.h"
//touchId依赖LocalAuthentication.framework框架
#import <LocalAuthentication/LocalAuthentication.h>


@interface WCTouchIDViewController ()

@property (nonatomic, strong) LAContext *laContext;//LAContext 指纹验证操作对象

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIControl *circleView;
@property (nonatomic, strong) UIImageView *fingerprintImageView;
@property (nonatomic, strong) UILabel *bottomTitleLabel;

@end

static WCTouchIDViewController* touchManager = nil;

@implementation WCTouchIDViewController

+ (BOOL)canEvaluatePolicy {
    NSError *error;
    return [[LAContext new] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}


+ (WCTouchIDViewController*)sharedManager {
    if (touchManager==nil){
        return touchManager=[[self alloc] init];
    }else {
        return touchManager;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.lineView.backgroundColor = RGBA(236, 236, 236, 1);
    self.avatarView.image = [UIImage imageNamed:@"icon_avatarPlaceholder"];
    self.fingerprintImageView.image = [UIImage imageNamed:@"icon_fingerprint"];
    self.bottomTitleLabel.text = @"Health";
    
    [self touchID:nil];
}

- (void)touchID:(id)sender {
    NSError *error;
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([self.laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
         //支持指纹验证
        [self.laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:[NSString stringWithFormat:@"进入%@", APP_DISPLAYNAME] reply:^(BOOL success, NSError * _Nullable error) {
            DDLogDebug(@"%d", success);
            if (success) {
                // 验证成功之后 设置为不需要再次验证
                [NSUserDefaults saveValue:@NO forKey:@"TouchIDVerify"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.push) {
                        [self.navigationController pushViewController:[WCBaseTabBarController new] animated:YES];
                    } else {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                });
            }
        }];
    }
}

//初始化指纹验证操作对象
- (LAContext *)laContext {
    if (!_laContext) {
        _laContext = [[LAContext alloc] init];
    }
    return _laContext;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius  = 42.5f;
            imageView.layer.masksToBounds = YES;
            imageView.layer.borderWidth = 6.f;
            imageView.layer.borderColor = RGBA(236, 236, 236, 1).CGColor;
            [self.view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.view).offset(88.f);
                make.size.mas_equalTo(CGSizeMake(85.f, 85.f));
            }];
            imageView;
        });
    }
    return _avatarView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = ({
            UIView *view = [[UIView alloc] init];
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@2);
                make.width.equalTo(self.view);
                make.center.equalTo(self.view);
            }];
            view;
        });
    }
    return _lineView;
}

- (UIControl *)circleView {
    if (!_circleView) {
        _circleView = ({
            UIControl *view = [[UIControl alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius  = 64.5f;
            view.layer.masksToBounds = YES;
            view.layer.borderWidth = 3.f;
            view.layer.borderColor = RGBA(236, 236, 236, 1).CGColor;
            [view addTarget:self action:@selector(touchID:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(129, 129));
                make.center.equalTo(self.lineView);
            }];
            view;
        });
    }
    return _circleView;
}

//在指纹图片上添加手势执行touchID：方法
- (UIImageView *)fingerprintImageView {
    if (!_fingerprintImageView) {
        _fingerprintImageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                [self touchID:sender];
            }];
            [imageView addGestureRecognizer:tap];
            [self.circleView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(88, 88));
                make.center.equalTo(self.circleView);
            }];
            imageView;
        });
    }
    return _fingerprintImageView;
}

- (UILabel *)bottomTitleLabel {
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:NUM_FONT_NAME size:40.f];
            label.textColor = BLUE_COLOR;
            [self.view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(-10.f);
            }];
            label;
        });
    }
    return _bottomTitleLabel;
}


@end
