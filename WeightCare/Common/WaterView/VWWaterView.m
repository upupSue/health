//
//  VWWWaterView.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "VWWaterView.h"
@interface VWWaterView ()
{
    float _circlePercent; //0-2之间

}
@end


@implementation VWWaterView

//首页卡片那边的圆形进度条     WaterView VWaterView VWWaterView 都是圆形进度条
//三个类型都是一样的 所以我注释只写在VWaterView.m里
//由于不同的页面圆圈的半径，线宽，线的颜色，所在位置不同，我又不会封装，所以只能写了三边一样的代码


//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];

        //时间控制器 不用管
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
    
    //绘制两头圆弧端的圆弧
    CGContextSetRGBStrokeColor(context,101/255.,176/255.,213/255.,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 14.0);//线的宽度
    CGContextSetLineCap(context,kCGLineCapRound); //线头为圆弧
    
    /**
     *  CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
     x,y为圆点坐标，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     */
    CGContextAddArc(context, 120/2+10, 120/2+10, 124/2, M_PI*-0.5,M_PI*(-0.5 + _circlePercent*_sportPersnet), 0); //添加一个圆 这边sportPersent时运动了百分之多少 是传值
    
    //绘制路径
    CGContextDrawPath(context, kCGPathStroke);
  
    

    CGContextRestoreGState(context);
    
}


@end
