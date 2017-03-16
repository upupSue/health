//
//  RulerView.h
//  WeightCare
//
//  Created by GO on 14-7-18.
//  Copyright (c) 2014年 DreamTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulerView : UIView<UIScrollViewDelegate>{
    double WEIGHT;
}

-(void)initRuler_MinScale:(float) minScale minNumValue:(float) minNumValue NumValue:(float) numValue NumUnit:(NSString *) numUnit Precision :(int) Precision MaxNumValue:(float) maxNumValue;
/**
 * 更新尺子当前显示值
 **/
-(void)setNumValue:(float) newNumValue;;
-(float)getScrollResult;
-(void)setColor:(UIColor *)color;
-(void)setfLable:(NSString *)str;
-(void)setWeight:(double)w;
-(double)returnWeight;

-(float)getResult;

@end
