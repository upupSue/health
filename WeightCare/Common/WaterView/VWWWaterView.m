//
//  VWWWaterView.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "VWWWaterView.h"

@interface VWWWaterView ()
{
    UIColor *_currentWaterColor;
    UIColor *_circleBackgroudColor;
    

    float _currentLinePointY; //动态高度
    float _maxLinePointY; //最大高度
    float a;
    float b;
    
    BOOL jia;
}
@end

//饮食管理     波纹动画

@implementation VWWWaterView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        //设置波纹滚动的初始参数
        a = 1.5;
        b = 0;
        jia = NO;
        
        //设置波浪颜色
        _currentWaterColor = GREEN_COLOR;
        _circleBackgroudColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:139/255.0f alpha:1];
        
        _currentLinePointY = 200;
        
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    
    return self;
}



-(void)animateWave
{
    //给最高高度赋值
    _maxLinePointY = 200 - 200*(_hotPresent+0.1);
    
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    //a b都是用于水波动画里三角函数的参数
    
    _currentLinePointY-=3;
    if (_currentLinePointY<_maxLinePointY)
        _currentLinePointY=_maxLinePointY;

    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSInteger centerY=140;
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //在一个图形栈中保存
    CGContextSaveGState(context);
    
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();

    //绘制水波纹效果
    
    //宽度
    CGContextSetLineWidth(context, 1);
    //颜色
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    
    //在路径上移动当前画笔的位置到一个点，这个点由CGPoint 类型的参数指定
    CGPathMoveToPoint(path, NULL, 0, y);
    
    //三角函数 水波的动画效果
    for(float x=0;x<=160;x++){
        y= a * sin( x/180*M_PI + 4*b/M_PI ) * 5 + _currentLinePointY;
        //从当前的画笔位置向指定位置（同样由CGPoint类型的值指定）绘制线段
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //绘制区域控制在裁剪圆内
    CGPathAddLineToPoint(path, nil, 160, centerY+80);
    CGPathAddLineToPoint(path, nil, 0, centerY+80);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    //添加一个由句柄指定的路径的图形上下文，准备用于绘图
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
    //在图形上下文中绘制给出的路径。
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
    
}


@end
