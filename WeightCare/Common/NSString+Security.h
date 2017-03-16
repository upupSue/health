//
//  NSString+Security.h
//  WeightCare
//
//  Created by GO on 14-7-21.
//  Copyright (c) 2014年 DreamTouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Security)

- (NSString *)  sha1Hash;
- (NSString *)  md5to16Hash;
- (NSData   *)  tripleDesWithKey:(NSString *)key ;
- (NSData   *)  desWithKey:(NSString *)key ;
@end
