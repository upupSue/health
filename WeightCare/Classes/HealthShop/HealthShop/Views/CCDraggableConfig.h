//
//  CCDraggableConfig.h
//  CCDraggableCard-Master
//
//  Created by jzzx on 16/7/6.
//  Copyright © 2016年 Zechen Liu. All rights reserved.
//

#ifndef CCDraggableConfig_h
#define CCDraggableConfig_h

//  -------------------------------------------------
//  MARK: 拽到方向枚举
//  -------------------------------------------------
typedef NS_OPTIONS(NSInteger, CCDraggableDirection) {
    CCDraggableDirectionDefault     = 0,
    CCDraggableDirectionLeft        = 1 << 0,
    CCDraggableDirectionRight       = 1 << 1
};

typedef NS_OPTIONS(NSInteger, CCDraggableStyle) {
    CCDraggableStyleUpOverlay   = 0,
    CCDraggableStyleDownOverlay = 1
};

#define CCWidth  [UIScreen mainScreen].bounds.size.width
#define CCHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat kBoundaryRatio = 0.5f;
// static const CGFloat kSecondCardScale = 0.98f;
// static const CGFloat kTherdCardScale  = 0.96f;

static const CGFloat kFirstCardScale  = 1.2f;
static const CGFloat kSecondCardScale = 1.1f;
static const CGFloat kThirdCardScale = 1.0f;
static const CGFloat kLastCardScale = 0.9f;


static const CGFloat kCardEdage = 34.0f;
static const CGFloat kContainerEdage = 50.0;
static const CGFloat kVisibleCount = 4;

#endif /* CCDraggableConfig_h */
