//
//  CarInfoAnnotation.h
//  TLF
//
//  Created by GO on 15/3/7.
//  Copyright (c) 2015年 Friday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface WalkInfoAnnotation :  BMKPointAnnotation
    @property(nonatomic,strong) NSString *displayInfo;
    @property(nonatomic,strong) UIImage * infoImage;
@end
