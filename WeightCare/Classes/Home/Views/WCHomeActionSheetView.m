//
//  WCHomeActionSheetView.m
//  WeightCare
//
//  Created by KentonYu on 16/7/16.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCHomeActionSheetView.h"

@interface WCHomeActionSheetView ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *otherButtonView;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation WCHomeActionSheetView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4f);
    }
    return self;
}

- (void)setActionInfoArray:(NSArray<NSDictionary *> *)actionInfoArray {
    _actionInfoArray = actionInfoArray;
    
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = ({
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            button.layer.cornerRadius  = 10.f;
            button.layer.masksToBounds = YES;
            button;
        });
    }
    return _cancelButton;
}


@end
