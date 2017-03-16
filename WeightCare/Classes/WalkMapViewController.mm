//
//  WalkMapViewController.m
//  WeightCare
//
//  Created by GO on 16/9/7.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WalkMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "WalkInfoAnnotation.h"

#define MAX_RECORD_POINT_COUNT 10000

@interface WalkMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* mapView;
    BMKLocationService* locService;
    NSTimer *timer;
    CLLocationCoordinate2D coors[MAX_RECORD_POINT_COUNT];//历史轨迹点集合
    NSInteger pointIndex; //当前记录点序号
    BMKPolyline* polyline;
    CLLocationDistance totalDis; //总距离
    WalkInfoAnnotation* startAnnotation;//起点地图标注
    WalkInfoAnnotation* endAnnotation;  //终点地图标注
    NSDate *startDate;//跑步开始的时间
    NSDate *stopDate;//跑步结束的时间
    
    UILabel *endLbl;//结束泡泡上的时间label
    UILabel *averageV;//结束泡泡上的平均速度label
    UILabel *distanceLabel;//总公里label
    UILabel *wasteLabel;//消耗卡路里label
    UILabel *startLbl;//开始泡泡上的时间label
    
    double average;//平均速度
    BOOL showDate;//用于判断泡泡上显示的是历史的还是现在的内容
}
@end



@implementation WalkMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"跑步路线";
    startDate = [NSDate date];
    
    //显示跑步地图
    if([[NSUserDefaults valueWithKey:@"isMapHistory"] isEqualToString:@"0"]){
        [self currectMap];
    }
    //显示历史地图
    else if([[NSUserDefaults valueWithKey:@"isMapHistory"] isEqualToString:@"1"]){
        [self historyMap];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    CGPoint pt = CGPointMake(SCREEN_WIDTH - 20 - 30, SCREEN_HEIGHT - 180);
    //设置指南针位置
    [mapView setCompassPosition:pt];
    //设置指南针图片
    [mapView setCompassImage:[UIImage imageNamed:@"map_local"]];
    locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
    locService.delegate = nil;
    [timer invalidate]; //关闭定时
    //存储运动轨迹数组coors
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)currectMap{
    showDate = 0;//当前
    pointIndex=-1;
    totalDis=0;
    //每隔10秒刷新下地理位置
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                             target:self
                                           selector:@selector(timerFire:)
                                           userInfo:nil
                                            repeats:YES];
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = mapView;
    locService = [[BMKLocationService alloc]init];
    //设置定位精确度，默认：kCLLocationAccuracyBest
    locService.desiredAccuracy = kCLLocationAccuracyBest;
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    //locService.distanceFilter = 100.0f;
    
    mapView.showsUserLocation = NO;
    mapView.zoomLevel=21;
    //动态定制我的位置样式
    BMKLocationViewDisplayParam* param = [[BMKLocationViewDisplayParam alloc] init];//用户位置类
    param.isAccuracyCircleShow = NO;//设置是否显示定位的那个精度圈
    param.isRotateAngleValid = YES;//跟随态旋转角度生效
    [mapView updateLocationViewWithParam:param];//将样式赋给mapview
    mapView.userTrackingMode = BMKUserTrackingModeFollow;//设定定位模式：跟随模式
    
    //开启定位服务
    mapView.showsUserLocation = YES;
    
    //设置地图层上的button view
    [self setButtonAndLabel];
    [timer fire];
}

- (void)historyMap{
    showDate = 1;
    //停止定时器和定位服务
    if (timer!=nil)
        [timer invalidate];
    if (locService!=nil)
        [locService stopUserLocationService];

    totalDis=0;
    
    //读取coors
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSArray* history=[defaults objectForKey:@"history"];
    //清空坐标数组
    for(int i=0;i<MAX_RECORD_POINT_COUNT;i++){
        coors[i].latitude = 0.0f;//纬度
        coors[i].longitude = 0.0f;//经度
    }
    pointIndex=[history count];
    
    if (pointIndex<=0)
        return; //无历史数据
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = mapView;
    mapView.showsUserLocation = NO;
    mapView.delegate = self;
    
    //设置地图层上的button view
    [self setButtonAndLabel];
    
    double maxlt=0,maxlg=0,minlt=180,minlg=180; //用于限定地图范围
    for(int j=0;j<[history count];j++)
    {
        NSString* lat=history[j][@"lat"];
        NSString* lng=history[j][@"lng"];
        coors[j].latitude =[lat doubleValue] ;
        coors[j].longitude =[lng doubleValue] ;
        //计算最大最小经纬度，用于控制地图一开始的显示范围，使地图恰好显示整条轨迹
        if (coors[j].latitude>maxlt) {
            maxlt=coors[j].latitude;
        }
        if (coors[j].latitude<minlt) {
            minlt=coors[j].latitude;
        }
        if (coors[j].longitude>maxlg) {
            maxlg=coors[j].longitude;
        }
        if (coors[j].longitude<minlg) {
            minlg=coors[j].longitude;
        }
        if (j>0)
        {
            //计算距离
            BMKMapPoint pStart=BMKMapPointForCoordinate(coors[j-1]);
            BMKMapPoint pEnd=BMKMapPointForCoordinate(coors[j]);
            CLLocationDistance dis=BMKMetersBetweenMapPoints(pStart,pEnd);
            totalDis+=dis;
        }
    }
    //自动决定地图缩放范围
    BMKCoordinateRegion region;
    region.center.latitude = (maxlt+minlt)/2;
    region.center.longitude = (maxlg+minlg)/2;
    region.span.latitudeDelta = fabs(maxlt-minlt) * 1.0;//纬度范围
    region.span.longitudeDelta = fabs(maxlg- minlg) * 1.0;//经度范围
    BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];//根据当前地图View的窗口大小调整传入的region，返回适合当前地图窗口显示的region，调整过程会保证中心点不改变
    [mapView setRegion:adjustedRegion animated:YES];//设定当前地图的显示范围
    //绘制地图历史轨迹和信息
    if (startAnnotation==nil) {
        startAnnotation = [[WalkInfoAnnotation alloc]init];
    }
    startAnnotation.coordinate = coors[0];
    startAnnotation.displayInfo=@"运动起点";
    startAnnotation.infoImage=[UIImage imageNamed:@"startAnnotationImage"];
    startAnnotation.title=@"运动起点";
    if (startAnnotation!=nil){
        [mapView removeAnnotation:startAnnotation];
        [mapView addAnnotation:startAnnotation];
    }
    if (polyline!=nil){
            [mapView removeOverlay:polyline];
    }
        
    //根据指定坐标点生成一段折线
    polyline = [BMKPolyline polylineWithCoordinates:coors count:pointIndex];
    [mapView addOverlay:polyline];
    
    if (endAnnotation==nil) {
      endAnnotation = [[WalkInfoAnnotation alloc]init];
    }
    endAnnotation.coordinate = coors[pointIndex-1];
    endAnnotation.displayInfo=@"运动终点";
    endAnnotation.infoImage=[UIImage imageNamed:@"stopAnnotationImage"];
    endAnnotation.title=@"运动终点";
    if (endAnnotation!=nil){
        [mapView removeAnnotation:endAnnotation];
        [mapView addAnnotation:endAnnotation];
    }
    //取出储存的运动距离 消耗卡路里 开始时间 结束时间 平均速度
    NSUserDefaults *historyDefaults =[NSUserDefaults standardUserDefaults];
    NSDictionary *historyData = [[NSDictionary alloc] init];
    historyData = [historyDefaults objectForKey:@"historyData"];
    
    startLbl.text = historyData[@"startTime"];
    endLbl.text = historyData[@"endTime"];
    averageV.attributedText = [self averageV:[historyData[@"average"] doubleValue]];
    distanceLabel.text = historyData[@"distance"];
    wasteLabel.text = historyData[@"waste"];
}

-(void)timerFire:(id)userinfo {
    pointIndex++;
    [self startLocation];
}

//普通态
-(void)startLocation
{
    [locService startUserLocationService];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"%ld",pointIndex);
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //定位失败
    if (userLocation.location.coordinate.latitude<=0)
        return;
    
    if (pointIndex<MAX_RECORD_POINT_COUNT)
    {
        coors[pointIndex].latitude = userLocation.location.coordinate.latitude;
        coors[pointIndex].longitude = userLocation.location.coordinate.longitude;
    }
    
    if (pointIndex==0){
        //设置并给地图添加起点标注Annotation
        if (startAnnotation==nil) {
            startAnnotation = [[WalkInfoAnnotation alloc]init];
        }
        startAnnotation.coordinate = userLocation.location.coordinate;
        startAnnotation.displayInfo=@"运动起点";
        startAnnotation.infoImage=[UIImage imageNamed:@"startAnnotationImage"];
        startAnnotation.title=@"运动起点";
        [mapView addAnnotation:startAnnotation];
    }
    
    if (pointIndex>0){
        if (polyline!=nil){
            [mapView removeOverlay:polyline];
        }
        
        //动态绘制线段
        polyline = [BMKPolyline polylineWithCoordinates:coors count:pointIndex+1];
        [mapView addOverlay:polyline];
        
        //计算距离
        BMKMapPoint pStart=BMKMapPointForCoordinate(coors[pointIndex-1]);
        BMKMapPoint pEnd=BMKMapPointForCoordinate(coors[pointIndex]);
        CLLocationDistance dis=BMKMetersBetweenMapPoints(pStart,pEnd);
        
        totalDis+=dis;
        
        if (endAnnotation==nil) {
            endAnnotation = [[WalkInfoAnnotation alloc]init];
        }
        endAnnotation.coordinate = userLocation.location.coordinate;
        endAnnotation.displayInfo=@"运动终点";
        endAnnotation.infoImage=[UIImage imageNamed:@"stopAnnotationImage"];
        endAnnotation.title=@"运动终点";
        [mapView addAnnotation:endAnnotation];

    }
    
    //刷新结束泡泡上的数据
    stopDate = [NSDate date];
    NSTimeInterval aTime = [stopDate timeIntervalSinceDate:startDate];
    long long  tim = aTime;
    double hour = (tim / 3600);
    double min = ((tim % 3600) / 60);
    double sec = tim%60;
    endLbl.text = [NSString stringWithFormat:@"%.0f:%.0f:%.0f",hour,min,sec];
    if(hour == 0){
        hour = min/60;
    }
    average = (double)totalDis/hour/1000;
    averageV.attributedText = [self averageV:average];

    distanceLabel.text = [NSString stringWithFormat:@"%.2f",totalDis/1000];
    wasteLabel.text = [NSString stringWithFormat:@"%.1f",totalDis/1000*70];
    
    NSLog(@"%f",totalDis);
    [mapView updateLocationData:userLocation];
    [self stopLocation];
}

//停止定位
-(void)stopLocation
{
    [locService stopUserLocationService];
    mapView.showsUserLocation = NO;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 // *@param userLocation 新的用户位置
 // */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = BLUE_COLOR;
        polylineView.lineWidth = 5.0;
        return polylineView;
    }
    return nil;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //起点和终点标注
    if ([annotation.title isEqualToString:@"运动起点"]) {
        //改变标注图片和自定义气泡
        BMKAnnotationView *annotationView=[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        annotationView.image =[UIImage imageNamed:@"startAnnotationImage"];
        
        //自定义内容气泡
        UIView *areaPaoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 205, 125)];
        areaPaoView.layer.cornerRadius=8;
        areaPaoView.layer.masksToBounds=YES;
        areaPaoView.layer.contents =(id)[UIImage imageNamed:@"backGround"].CGImage;//这张图片是做好的透明

        if ([annotation.title isEqualToString:@"运动起点"]) { //假设title的标题为1，那么就把添加上这个自定义气泡内容
            UIImageView *startAreaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 200, 115)];
            startAreaImageView.image = [UIImage imageNamed:@"startAnnotationView"];
            [areaPaoView addSubview:startAreaImageView];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm:ss"];
            NSString *dateTime = [formatter stringFromDate:startDate];
            startLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 37.5, 80, 30)];
            startLbl.font = [UIFont fontWithName:NUM_FONT_NAME size:30];
            startLbl.textColor = BLUE_COLOR;
            startLbl.text = dateTime;
            startLbl.textAlignment = NSTextAlignmentCenter;
            [startAreaImageView addSubview:startLbl];
            
        }
        //百度map自带的一种显示泡泡的类 将我们写的areaPaoView添加到paopao并设置为paopaoView
        BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:areaPaoView];
        annotationView.paopaoView=paopao;
        
        
        return annotationView;
    }
    
    else{
        //改变标注图片和自定义气泡
        BMKAnnotationView *annotationView=[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        annotationView.image =[UIImage imageNamed:@"stopAnnotationImage"];
        
        //自定义内容气泡
        UIView *areaPaoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 125)];
        areaPaoView.layer.cornerRadius=8;
        areaPaoView.layer.masksToBounds=YES;
        areaPaoView.layer.contents =(id)[UIImage imageNamed:@"backGround"].CGImage;//这张图片是做好的透明
        //areaPaoView.backgroundColor=[UIColor whiteColor];
        if ([annotation.title isEqualToString:@"运动终点"]) { //假设title的标题为1，那么就把添加上这个自定义气泡内容
            UIImageView *stopAreaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 20, 230, 115)];
            stopAreaImageView.image = [UIImage imageNamed:@"stopAnnotationView"];
            [areaPaoView addSubview:stopAreaImageView];
            

            endLbl = [[UILabel alloc] initWithFrame:CGRectMake(25, 37.5, 80, 30)];
            endLbl.font = [UIFont fontWithName:NUM_FONT_NAME size:30];
            endLbl.textColor = RED_COLOR;
            endLbl.text = @"00:00:00";
            endLbl.textAlignment = NSTextAlignmentCenter;
            [stopAreaImageView addSubview:endLbl];
        
            averageV = [[UILabel alloc] initWithFrame:CGRectMake(125, 37.5, 100, 30)];
            averageV.attributedText = [self averageV:0.0];
            averageV.textAlignment = NSTextAlignmentCenter;
            [stopAreaImageView addSubview:averageV];

            
        }
        //百度map自带的一种显示泡泡的类 将我们写的areaPaoView添加到paopao并设置为paopaoView
        BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:areaPaoView];
        annotationView.paopaoView=paopao;
        
        
        return annotationView;

    }
    
    return nil;
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (mapView) {
        mapView = nil;
    }
}

/**
 *  button和view
 */

- (void)setButtonAndLabel{
    //返回按钮
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 33, 25, 22)];
    [returnBtn setImage:[UIImage imageNamed:@"arrow-thin-left_blue"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToLastview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    //切换历史地图按钮
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 60, SCREEN_HEIGHT - 250,80, 80)];
    [changeBtn setImage:[UIImage imageNamed:@"historyMap"] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];

    //蓝色那块
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 130, SCREEN_WIDTH-20, 120)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 120)];
    imageView.image = [UIImage imageNamed:@"map_data"];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, (120-50)/2, 80, 45)];
    distanceLabel.font = [UIFont fontWithName:NUM_FONT_NAME size:45];
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.text = [NSString stringWithFormat:@"%.2f",totalDis];
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:distanceLabel];
    
    wasteLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-40 - 80, (120-50)/2, 80, 45)];
    wasteLabel.font = [UIFont fontWithName:NUM_FONT_NAME size:45];
    wasteLabel.textColor = [UIColor whiteColor];
    wasteLabel.text = [NSString stringWithFormat:@"%.2f",totalDis*70];
    wasteLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:wasteLabel];
    
    [baseView addSubview:imageView];
    [self.view addSubview:baseView];
}

- (void)returnToLastview{
    
    //存储运动轨迹数组coors
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray* walks=[[NSMutableArray alloc] init];
    for (int i=0;i<pointIndex;i++){
        NSNumber *dLat = [NSNumber numberWithDouble:coors[i].latitude];
        NSNumber *dLng = [NSNumber numberWithDouble:coors[i].longitude];
        NSString* lat=[dLat stringValue];
        NSString* lng=[dLng stringValue];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",lng,@"lng", nil];
        [walks addObject:dic];
    }
    [defaults setObject:walks forKey:@"history"];
    
    //储存运动距离 消耗卡路里 开始时间 结束时间 平均速度
    NSUserDefaults *historyDeflaults =[NSUserDefaults standardUserDefaults];
    NSDictionary *historyData =[[NSDictionary alloc] init];
    //Protect
    if(pointIndex>0){
        historyData = @{
                        @"distance":distanceLabel.text,
                        @"waste":wasteLabel.text,
                        @"startTime":startLbl.text,
                        @"endTime":endLbl.text,
                        @"average":[NSNumber numberWithDouble:average],
                        };
    }
    
    [historyDeflaults setObject:historyData forKey:@"historyData"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeBtn{
    //点击切换历史和当前
    
    NSLog(@"changeBtn");
    if([[NSUserDefaults valueWithKey:@"isMapHistory"] isEqualToString:@"0"]){
        [NSUserDefaults saveValue:@"1" forKey:@"isMapHistory"];
        [self historyMap];

    }
    else if([[NSUserDefaults valueWithKey:@"isMapHistory"] isEqualToString:@"1"]){
        [NSUserDefaults saveValue:@"0" forKey:@"isMapHistory"];
        //[self currectMap];
    }
    
}

- (NSMutableAttributedString *)averageV:(double)way{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2fkm/H", way]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:12.f],
                             NSForegroundColorAttributeName : RED_COLOR
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:NUM_FONT_NAME size:30.f],
                             NSForegroundColorAttributeName : RED_COLOR
                             } range:NSMakeRange(0, attrStr.length-4)];
    return attrStr;
}



@end
