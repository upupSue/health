//
//  WCEnumerationConstant.h
//  WeightCare
//
//  Created by KentonYu on 16/7/10.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#ifndef WCEnumerationConstant_h
#define WCEnumerationConstant_h

#pragma mark - Home

typedef NS_ENUM(NSUInteger, WCHomeCardManagerEnum) {
    WCHomeCardManagerEnumAdd    = 0,
    WCHomeCardManagerEnumSport  = 1,
    WCHomeCardManagerEnumFood   = 2,
    WCHomeCardManagerEnumWeight = 3
};

//确认顶单订单详情页
typedef NS_ENUM(NSInteger, OrderType)
{
    //确认订单
    checkOrder,
    //订单详情
    orderDetail,
};

//饮食方案运动方案
typedef NS_ENUM(NSInteger, DesignType)
{
    //饮食方案
    dietDesign,
    //运动方案
    sportDesign,
};

//订单列表购物车列表
typedef NS_ENUM(NSInteger, ListType)
{
    //订单列表
    orderList,
    //购物车列表
    cartList,
};

//订单状态
typedef NS_ENUM(NSInteger , OrderStatus)
{
    //已付款
    orderStatusPaid,
    //已发货
    orderStatusSended,
    //全部
    orderStatusAll,
};

//登录注册
typedef NS_ENUM(NSInteger , LoginType)
{
    //已付款
    login,
    //已发货
    regis,
};

#endif /* WCEnumerationConstant_h */
