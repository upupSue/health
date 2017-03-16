//
//  RulerView.m
//  WeightCare
//
//  Created by GO on 14-7-18.
//  Copyright (c) 2014年 DreamTouch. All rights reserved.
//

#import "RulerView.h"

@interface RulerView()
{
UILabel *fLable;
UILabel *NumUnitLable;

UIScrollView *RulerScrollView;
UIView *rulerBg;
float fNumValue;
float fMinNumValue;
float fMinScale;
NSString *strNumUnit;
int intPrecision;
UILabel *NumLable;

}
@end

#define RULER_TOPOFFSET 172

@implementation RulerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}

- (void)layout
{
    fLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-64)/2, 0, 64, 24)];

    fLable.text=[[NSString alloc] initWithFormat:@"预计消耗"];
    fLable.font=[UIFont fontWithName:@"PingFang SC" size:16];
    fLable.textColor=[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];

    [self addSubview:fLable];

    WEIGHT = 0;
    //创建显示数值
    NumLable=[[UILabel alloc]initWithFrame:CGRectMake(112, 100, 160, 80)];
   
    NumLable.center=CGPointMake(self.center.x, 60);
    NumLable.textAlignment=NSTextAlignmentCenter;
   
    NumLable.font=[UIFont fontWithName:@"Haettenschweiler" size:80];
    NumLable.textColor=[UIColor colorWithRed:80/255.0 green:176/255.0 blue:255/255.0 alpha:1];
    [self addSubview:NumLable];
    
    //动态位置显示单位
    CGSize titleSize = [NumLable.text sizeWithFont:NumLable.font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    NumUnitLable.font=[UIFont fontWithName:@"PingFang SC" size:16];
    NumUnitLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 40)/2,106,40,20)];
    NumUnitLable.textColor=[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];
    [self addSubview:NumUnitLable];
    
    
    
    //显示尺子背景图片
//    UIImageView* rulerBg=[[UIImageView alloc] initWithFrame:CGRectMake(7, RULER_TOPOFFSET, 355, 111)];
//    rulerBg.image=[UIImage imageNamed:@"Ruler_bg"];
//    [self addSubview:rulerBg];
    
    
    rulerBg = [[UIView alloc]initWithFrame:CGRectMake(7, RULER_TOPOFFSET, SCREEN_WIDTH-20, 111)];
    rulerBg.backgroundColor=[UIColor colorWithRed:80/255.0 green:176/255.0 blue:255/255.0 alpha:1];
    rulerBg.layer.cornerRadius = 5;

    
    [self addSubview:rulerBg];
    //添加滚动视图
    //校准尺子对其0 只要修改CGRectMake的 x
    RulerScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(50, RULER_TOPOFFSET, SCREEN_WIDTH-100, 111)];
    RulerScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:RulerScrollView];
    RulerScrollView.delegate=self;
    //添加尺子中间线
    UIImageView* rulerMidLine=[[UIImageView alloc] initWithFrame:CGRectMake(178, RULER_TOPOFFSET-19, 16, 16)];
    rulerMidLine.image=[UIImage imageNamed:@"Triangle"];
    [self addSubview:rulerMidLine];
}

-(void)setNumValue:(float) newNumValue
{
    fNumValue=newNumValue-fMinNumValue;
    [RulerScrollView setContentOffset:CGPointMake(fNumValue*10/fMinScale-145-55, 0)];
}
//获得结果
-(float)getScrollResult
{
    return [NumLable.text floatValue]/WEIGHT;
}

//获得结果
-(float)getResult
{
    return [NumLable.text floatValue];
}

-(void)setColor:(UIColor *)color{
    rulerBg.backgroundColor = color;
    NumLable.textColor = color;
}

-(void)setfLable:(NSString *)str{
    fLable.text = str;
}

-(double)returnWeight{
    return WEIGHT;
}


-(void)setWeight:(double)w{
    WEIGHT = w;
    if (w>10) {
        NumLable.text = [NSString stringWithFormat:@"%.0f",w];
    }
    else{
        NumLable.text = [NSString stringWithFormat:@"%0.2f",w];
    }
}


#pragma mark 绘制尺子
-(void)initRuler_MinScale:(float) minScale minNumValue:(float) minNumValue NumValue:(float) numValue NumUnit:(NSString *) numUnit Precision :(int) Precision MaxNumValue:(float) maxNumValue
{
    RulerScrollView.contentSize=CGSizeMake(maxNumValue/minScale*10, 87);
    NumUnitLable.text=numUnit;
    fNumValue=numValue;
    fMinScale=minScale;
    fMinNumValue=minNumValue-20*minScale;
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, maxNumValue+300, 87)];
    intPrecision=Precision;
    if(Precision==0)
        NumLable.text=[[NSString alloc] initWithFormat:@"%.0f",fNumValue*WEIGHT];
    if(Precision==1)
        NumLable.text=[[NSString alloc] initWithFormat:@"%.1f",fNumValue*WEIGHT];
    if(Precision==2)
        NumLable.text=[[NSString alloc] initWithFormat:@"%.2f",fNumValue*WEIGHT];
    
    //动态位置显示单位
    CGSize titleSize = [NumLable.text sizeWithFont:NumLable.font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    NumUnitLable.font=[UIFont systemFontOfSize:18];
    //NumUnitLable.frame=CGRectMake(NumLable.center.x+titleSize.width/2+8, 15, 71, 21);
    
    NumUnitLable.frame=CGRectMake((SCREEN_WIDTH -40)/2,106,40,20);

    NumUnitLable.textColor=[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];
    
    fNumValue-=fMinNumValue;
    [RulerScrollView setContentOffset:CGPointMake(fNumValue*10/fMinScale-145-55, 0)];
    float n=-5;
   
    //刻度
    for(int i=4;i>-20;i--)
    {
        UIImageView *Line;
        UIImageView *Line2;

        UILabel *Num;
        if(i%10==0)
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"long"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"long"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 40)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 71, 10, 40)];

            
            
            Num=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
            Num.textAlignment=NSTextAlignmentCenter;
            [Num setCenter:CGPointMake(Line.center.x, 53)];
            Num.text=[[NSString alloc]initWithFormat:@"%.0f",i*fMinScale+fMinNumValue];
            Num.textColor=[UIColor whiteColor];
            Num.font=[UIFont fontWithName:@"Haettenschweiler" size:25];

            [lineView addSubview:Num];
            
        }
        else if(i%5==0)
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"middle"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"middle"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 30)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 81, 10, 30)];

        }
        else
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"short"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"short"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 20)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 91, 10, 20)];

        }
        [lineView addSubview:Line];
        [lineView addSubview:Line2];

    }
    for(int i=5;i<maxNumValue/minScale+300;i++)
    {
        UIImageView *Line;
        UIImageView *Line2;

        UILabel *Num;
        if(i%10==0)
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"long"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"long"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 40)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 71, 10, 40)];

            
            Num=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
            Num.textAlignment=NSTextAlignmentCenter;
            [Num setCenter:CGPointMake(Line.center.x, 53)];
            Num.text=[[NSString alloc]initWithFormat:@"%.0f",i*fMinScale+fMinNumValue];
            Num.textColor=[UIColor whiteColor];
            Num.font=[UIFont fontWithName:@"Haettenschweiler" size:25];

            [lineView addSubview:Num];
        }
        else if(i%5==0)
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"middle"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"middle"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 30)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 82, 10, 30)];
        }
        else
        {
            Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"short"]];
            Line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"short"]];
            [Line setFrame:CGRectMake((i-5)*10+n, 0, 10, 20)];
            [Line2 setFrame:CGRectMake((i-5)*10+n, 91, 10, 20)];

        }
        [lineView addSubview:Line];
        [lineView addSubview:Line2];

    }
    [RulerScrollView addSubview:lineView];
    
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    fNumValue=(RulerScrollView.contentOffset.x+145)*fMinScale/10.0;
    if(intPrecision==0)
    NumLable.text=[[NSString alloc] initWithFormat:@"%.0f",(fNumValue+fMinNumValue+5.5*fMinScale)*WEIGHT];
    if(intPrecision==1)
        NumLable.text=[[NSString alloc] initWithFormat:@"%.1f",(fNumValue+fMinNumValue+5.5*fMinScale)*WEIGHT];
    if(intPrecision==2)
        NumLable.text=[[NSString alloc] initWithFormat:@"%.2f",(fNumValue+fMinNumValue+5.5*fMinScale)*WEIGHT];
    CGSize titleSize = [NumLable.text sizeWithFont:NumLable.font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    //[NumUnitLable setFrame:CGRectMake(NumLable.center.x+titleSize.width/2+8, 15, 71, 21)];
    
    [NumUnitLable setFrame:CGRectMake((SCREEN_WIDTH - 40)/2,106,40,20)];

}
@end
