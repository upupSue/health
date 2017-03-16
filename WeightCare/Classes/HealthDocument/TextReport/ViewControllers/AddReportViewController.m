//
//  AddReportViewController.m
//  WeightCare
//
//  Created by BG on 16/8/25.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "AddReportViewController.h"

@interface AddReportViewController ()<UITextFieldDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIView *bloodPressureView;
@property (weak, nonatomic) IBOutlet UIView *bloodSugarView;
@property (weak, nonatomic) IBOutlet UIView *wbcView;
@property (weak, nonatomic) IBOutlet UIView *uricView;
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;

@property (weak, nonatomic) IBOutlet UITextField *pressureOnTextField;
@property (weak, nonatomic) IBOutlet UITextField *pressureDownTextField;
@property (weak, nonatomic) IBOutlet UITextField *SugarTextField;
@property (weak, nonatomic) IBOutlet UITextField *eggTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *redCeilTextField;
@property (weak, nonatomic) IBOutlet UITextField *whiteCeilTextField;

@property (weak, nonatomic) IBOutlet UITextField *uricTextField;

@end

@implementation AddReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"2016·05·28";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"trash"] style:UIBarButtonItemStylePlain target:self action:@selector(moveToTrash)];
    _bloodPressureView.layer.cornerRadius=10;
    _bloodSugarView.layer.cornerRadius=10;
    _wbcView.layer.cornerRadius=10;
    _uricView.layer.cornerRadius=10;
    _upLoadBtn.layer.cornerRadius=5;
    
    _pressureOnTextField.keyboardType = UIKeyboardTypePhonePad;
    _pressureDownTextField.keyboardType = UIKeyboardTypePhonePad;
    _SugarTextField.keyboardType = UIKeyboardTypePhonePad;
    _eggTextFiled.keyboardType = UIKeyboardTypePhonePad;
    _redCeilTextField.keyboardType = UIKeyboardTypePhonePad;
    _whiteCeilTextField.keyboardType = UIKeyboardTypePhonePad;
    _uricTextField.keyboardType = UIKeyboardTypePhonePad;


}
//键盘退出
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.pressureOnTextField resignFirstResponder];
    [self.pressureDownTextField resignFirstResponder];
    [self.SugarTextField resignFirstResponder];
    [self.eggTextFiled resignFirstResponder];
    [self.redCeilTextField resignFirstResponder];
    [self.whiteCeilTextField resignFirstResponder];
    [self.uricTextField resignFirstResponder];

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField.text.length!=0){
        if(textField.tag==1||textField.tag==2){
            NSString *content=[NSString stringWithFormat:@"%@mmHg", textField.text];
            textField.text=content;
        }
        if(textField.tag==3){
            NSString *content=[NSString stringWithFormat:@"%@mmol", textField.text];
            textField.text=content;
        }
        if(textField.tag==4||textField.tag==5||textField.tag==6){
            NSString *content=[NSString stringWithFormat:@"%@g/L", textField.text];
            textField.text=content;
        }
        if(textField.tag==7){
            NSString *content=[NSString stringWithFormat:@"%@umol/L", textField.text];
            textField.text=content;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)moveToTrash{
    
}

@end
