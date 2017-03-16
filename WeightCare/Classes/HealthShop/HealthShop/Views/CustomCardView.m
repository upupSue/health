//
//  CustomCardView.m
//  CCDraggableCard-Master
//
//  Created by jzzx on 16/7/9.
//  Copyright © 2016年 Zechen Liu. All rights reserved.
//

#import "CustomCardView.h"

@interface CustomCardView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *titleLabel;

@end

@implementation CustomCardView

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.imageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.titleLabel.textColor = [UIColor colorWithRed:80/255.0 green:176/255.0 blue:255/255.0 alpha:1];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)cc_layoutSubviews {
    self.imageView.frame   = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 68);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 68, self.frame.size.width, 68);
}

- (void)installData:(NSDictionary *)element {
    self.imageView.image  = [UIImage imageNamed:element[@"image"]];
    self.titleLabel.text = element[@"title"];
}

@end
