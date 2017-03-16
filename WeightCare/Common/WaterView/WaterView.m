//
//  VWWWaterView.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "WaterView.h"
@interface WaterView ()
{
    float _circlePercent; //0-2之间
}
@end


@implementation WaterView

//运动具体数据页面那边的圆形进度条     WaterView VWaterView VWWaterView 都是圆形进度条
//三个类型都是一样的 所以我注释只写在VWWaterView.m里
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}



-(void)animateWave
{

    
    _circlePercent+=0.02;
    
    if(_circlePercent>2.0)
        _circlePercent=2.0;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    CGContextSaveGState(context);
    

    CGContextSetRGBStrokeColor(context,255/255.,255/255.,255/255.,1.0);
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.width/2, self.frame.size.width/2-10, M_PI*-0.5, M_PI*(-0.5 + _circlePercent*_sportPersnet), 1);
    CGContextDrawPath(context, kCGPathStroke);
    

    CGContextRestoreGState(context);
    
}


@end
