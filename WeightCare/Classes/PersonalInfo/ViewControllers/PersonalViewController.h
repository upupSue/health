//
//  PersonalViewController.h
//  WeightCare
//
//  Created by 王佳楠 on 16/8/18.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *PLheadImage;
@property (weak, nonatomic) IBOutlet UILabel *UserLabel;
@property (weak, nonatomic) IBOutlet UILabel *SexLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *HtLable;
@property (weak, nonatomic) IBOutlet UILabel *FinalHtLable;
@property (weak, nonatomic) IBOutlet UIView *WCPViewOne;
@property (weak, nonatomic) IBOutlet UIView *WCPViewTwo;
- (IBAction)HeadClickButtonBig:(UIButton *)sender;
- (IBAction)UserClickButtonBig:(UIButton *)sender;
- (IBAction)SexButtonBig:(UIButton *)sender;
- (IBAction)TimeButtonBig:(UIButton *)sender;
- (IBAction)HtButtonBig:(UIButton *)sender;
- (IBAction)FirstWtButtonBig:(UIButton *)sender;
- (IBAction)FinallWtButtonBig:(UIButton *)sender;

@property (nonatomic, assign)NSString *height;

@property (weak, nonatomic) IBOutlet UILabel *FirstHtLable;
@end
