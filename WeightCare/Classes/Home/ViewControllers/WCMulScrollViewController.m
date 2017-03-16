//
//  WCMulScrollViewController.m
//  WeightCare
//
//  Created by 吴戈 Wougle on 16/8/29.
//  Copyright © 2016年 ZUSTDMT. All rights reserved.
//

#import "WCMulScrollViewController.h"
#import "RulerView.h"
#import "LocalDBManager.h"
#import "CollectionPhotoController.h"
@interface WCMulScrollViewController ()<UIScrollViewDelegate,UISearchBarDelegate>{
    UIScrollView *scrollView;
    UIScrollView *scrollViewX;
    UILabel *dateLabel;
    NSDate *nowDate;
    
    NSInteger addInterval;
    NSInteger subInterval;
    
    UISearchBar *localSearchBar;
    UIButton *searchBarButton;
    RulerView *rulerView;
    UILabel *unitLabel;
    UILabel *aUnitLabel;
    int foodTag;
    NSString *dateString;
    double amount;
}
@property (weak, nonatomic) NSArray* scrollImageArray;
@property (weak, nonatomic) NSArray* calorieArray;
@property (weak, nonatomic) NSArray* unitArray;

@end

@implementation WCMulScrollViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    foodTag = 1;
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    dateString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: currentDate]];
    //日期增减的初始化
    addInterval = 0;
    subInterval = 0;
    
    //设置ScrollView
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 635.f);
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];

    //根据push进来时传的不同type来执行不同的代码
    
    NSLog(@"%li",(long)self.viewType);
    switch (self.viewType) {
        case 1:
            [self setSportView];
            break;
        case 2:
            [self setFoodView];
            break;
        case 3:
            [self setWeightView];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setSearchBar

- (void)setSearchBar{
    //点击搜索时出现的淡黑色整个view 并对这个view设置action：点击后失去焦点
    searchBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    searchBarButton.backgroundColor = [UIColor blackColor];
    searchBarButton.alpha = 0.25;
    [searchBarButton addTarget:self action:@selector(isSearchBarHide) forControlEvents:UIControlEventTouchUpInside];
    searchBarButton.hidden = YES;
    [scrollView addSubview:searchBarButton];
    
    //searchBar后面的view
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(54, 72, SCREEN_WIDTH - 108, 40)];
    searchView.backgroundColor = LIGHTGRAY_COLOR;
    searchView.layer.cornerRadius = 20.f;
    searchView.layer.masksToBounds = YES;
    searchView.layer.borderWidth = 1.f;
    searchView.layer.borderColor = DEEPGRAY_COLOR.CGColor;
    
    //searchBar
    localSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 108, 40)];
    localSearchBar.barTintColor = LIGHTGRAY_COLOR;
    
    //设置searchBar的样式
    UIImage* clearImg = [WCMulScrollViewController imageWithColor:[UIColor clearColor] andHeight:32.0f];
    // 2
    [localSearchBar setBackgroundImage:clearImg];
    // 3
    [localSearchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];
    // 4
    [localSearchBar setBackgroundColor:[UIColor clearColor]];
    
    localSearchBar.placeholder = @"搜索";
    localSearchBar.delegate = self;
    [searchView addSubview:localSearchBar];
    [scrollView addSubview:searchView];
    
}

//设置searchBar内部的颜色
+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark  searchBarDelegate

//点击键盘上的search按钮时调用
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
//输入文本实时更新时调用
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}
//点击键盘上的取消按钮时调用
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"searchBar");
    searchBarButton.hidden = NO;
    
}

#pragma mark - setView


- (void)setSportView{
    //baseView
    UIView *baseGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 273.f)];
    baseGrayView.backgroundColor = LIGHTGRAY_COLOR;
    [scrollView addSubview:baseGrayView];
    
    [self setReturnButtonAndTrashButton];
    [self setDateView];
    [self setScrollView];
    [baseGrayView addSubview:scrollViewX];
    
    _scrollImageArray = [NSArray arrayWithObjects:@"longrun", @"longfastrun", @"longwalk",@"longfastwalk",@"longbicycle",@"longswim",@"longbadminton",@"longropeskipping",@"longpingpong",@"longbasketball",@"longsoccer",@"longtennis",@"longpushup",@"longpullups",@"longsitup",@"longdance",@"longhulahoop",@"longbodymechanics",@"longclimb",@"longYoga",nil];
    _calorieArray = [NSArray arrayWithObjects:@"11", @"22", @"33", nil];
    for (int i = 0; i < _scrollImageArray.count; i ++){
        UIImage *image = [UIImage imageNamed:_scrollImageArray[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectMake(i*250+80, 0, 220, 120);//这里可以设置ScrollView之间的距离
        //80是第一个图片距离左边的距离     250 = 220 + 30  220是一个图片的宽度 30是两张图片之间的距离
        [scrollViewX addSubview:imageView];
    }
    
    
    
    //设置尺子  setfLable setWeight 应该要根据选了不同的运动而改变
    rulerView=[[RulerView alloc]initWithFrame:CGRectMake(4, SCREEN_HEIGHT - 384, SCREEN_WIDTH-10, 283)];
    [rulerView setColor:DEEPBLUE_COLOR];
    [rulerView setfLable:@"预计消耗"];
    
    if (self.waste) {
        [rulerView setWeight:[self.waste floatValue]];
    }
    else{
        [rulerView setWeight:1];
    }
    
    rulerView.clipsToBounds=YES;
    [rulerView initRuler_MinScale:0.1 minNumValue:1 NumValue:0 NumUnit:@"大卡" Precision:1 MaxNumValue:100];
    [scrollView addSubview:rulerView];
    
    //设置单位  sportUnit应该要根据选了不同的运动而改变
    unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 22- 222, 180, 22)];
    unitLabel.attributedText = [self sportUnit:@"公里"];
    [scrollView addSubview:unitLabel];
    
    //设置标尺
    UIImageView *scaleView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 8, SCREEN_HEIGHT-234, 16, 16)];
    scaleView.image = [UIImage imageNamed:@"blue_Triangle 3"];
    [scrollView addSubview:scaleView];
    
    //设置底下按钮
    UIButton *sportBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 117.5, SCREEN_HEIGHT - 80, 235, 60)];
    [sportBtn addTarget:self action:@selector(sportBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *sportBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(87.5, 16, 50, 28)];
    sportBtnLabel.textColor = DEEPBLUE_COLOR;
    sportBtnLabel.text = @"确定";
    sportBtnLabel.font = [UIFont systemFontOfSize:20];
    sportBtnLabel.textAlignment = NSTextAlignmentCenter;
    [sportBtn addSubview:sportBtnLabel];
    sportBtn.backgroundColor = [UIColor whiteColor];
    sportBtn.layer.cornerRadius = 10.f;
    sportBtn.layer.masksToBounds = YES;
    sportBtn.layer.borderWidth = 1.f;
    sportBtn.layer.borderColor = DEEPBLUE_COLOR.CGColor;
    [scrollView addSubview:sportBtn];
    
    [self setSearchBar];
}


- (void)setFoodView{
    //baseView
    UIView *baseGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 273.f)];
    baseGrayView.backgroundColor = LIGHTGRAY_COLOR;
    [scrollView addSubview:baseGrayView];
    
    [self setReturnButtonAndTrashButton];
    [self setDateView];
    [self setScrollView];
    [baseGrayView addSubview:scrollViewX];
    _scrollImageArray = [NSArray arrayWithObjects:@"肉包子", @"longpancake", @"longsteamedbun",@"longbreadroll",@"longsmallbun", @"longdumpling", @"longvegetablebun", @"longcurrydumpling", @"longeggcake",@"longbeanbun",@"longcharsiubun",@"longsandwich",@"longchaohefen",@"longherbalifeshake",@"longmilk",@"longoatmeal",@"longapple",@"longpotato",@"longbroccoli",@"longsalad",nil];
    for (int i = 0; i < _scrollImageArray.count; i ++){
        UIImage *image = [UIImage imageNamed:_scrollImageArray[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.layer.cornerRadius = 10.f;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectMake(i*250+80, 0, 220, 120);
        [scrollViewX addSubview:imageView];
    }
    
    //设置尺子
    rulerView=[[RulerView alloc]initWithFrame:CGRectMake(4, SCREEN_HEIGHT - 384, SCREEN_WIDTH-10, 283)];
    [rulerView setColor:GREEN_COLOR];
    [rulerView setfLable:@"预计摄入"];
    
    if (self.fIntake) {
        [rulerView setWeight:[self.fIntake floatValue]];
    }
    else{
        [rulerView setWeight:1];
    }
    
    rulerView.clipsToBounds=YES;
    [rulerView initRuler_MinScale:0.1 minNumValue:0 NumValue:0 NumUnit:@"大卡" Precision:1 MaxNumValue:100];
    [scrollView addSubview:rulerView];
    
    //设置单位
    unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 22- 222, 180, 22)];
    unitLabel.attributedText = [self foodUnit:@"个"];
    [scrollView addSubview:unitLabel];
    
    //设置标尺
    UIImageView *scaleView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 8, SCREEN_HEIGHT-234, 16, 16)];
    scaleView.image = [UIImage imageNamed:@"green_Triangle 3"];
    [scrollView addSubview:scaleView];
    
    //设置底下按钮
    UIButton *breakfastBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.5 - 11 - 101, SCREEN_HEIGHT - 80, 101, 60)];
    [breakfastBtn addTarget:self action:@selector(breakfastBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *breakfastBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 16, 51, 28)];
    breakfastBtnLabel.textColor = GREEN_COLOR;
    breakfastBtnLabel.text = @"早餐";
    breakfastBtnLabel.font = [UIFont systemFontOfSize:20];
    breakfastBtnLabel.textAlignment = NSTextAlignmentCenter;
    [breakfastBtn addSubview:breakfastBtnLabel];
    breakfastBtn.backgroundColor = [UIColor whiteColor];
    breakfastBtn.layer.cornerRadius = 10.f;
    breakfastBtn.layer.masksToBounds = YES;
    breakfastBtn.layer.borderWidth = 1.f;
    breakfastBtn.layer.borderColor = GREEN_COLOR.CGColor;
    [scrollView addSubview:breakfastBtn];
    
    UIButton *lunchBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50.5, SCREEN_HEIGHT - 80, 101, 60)];
    [lunchBtn addTarget:self action:@selector(lunchBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lunchBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 16, 51, 28)];
    lunchBtnLabel.textColor = GREEN_COLOR;
    lunchBtnLabel.text = @"中餐";
    lunchBtnLabel.font = [UIFont systemFontOfSize:20];
    lunchBtnLabel.textAlignment = NSTextAlignmentCenter;
    [lunchBtn addSubview:lunchBtnLabel];
    lunchBtn.backgroundColor = [UIColor whiteColor];
    lunchBtn.layer.cornerRadius = 10.f;
    lunchBtn.layer.masksToBounds = YES;
    lunchBtn.layer.borderWidth = 1.f;
    lunchBtn.layer.borderColor = GREEN_COLOR.CGColor;
    [scrollView addSubview:lunchBtn];
    
    UIButton *dinnerBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 50.5 + 11, SCREEN_HEIGHT - 80, 101, 60)];
    [dinnerBtn addTarget:self action:@selector(dinnerBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *dinnerBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 16, 51, 28)];
    dinnerBtnLabel.textColor = GREEN_COLOR;
    dinnerBtnLabel.text = @"晚餐";
    dinnerBtnLabel.font = [UIFont systemFontOfSize:20];
    dinnerBtnLabel.textAlignment = NSTextAlignmentCenter;
    [dinnerBtn addSubview:dinnerBtnLabel];
    dinnerBtn.backgroundColor = [UIColor whiteColor];
    dinnerBtn.layer.cornerRadius = 10.f;
    dinnerBtn.layer.masksToBounds = YES;
    dinnerBtn.layer.borderWidth = 1.f;
    dinnerBtn.layer.borderColor = GREEN_COLOR.CGColor;
    [scrollView addSubview:dinnerBtn];
    
    [self setSearchBar];
}

- (void)setWeightView{
    //baseView
    UIView *baseGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 306.f)];
    baseGrayView.backgroundColor = LIGHTGRAY_COLOR;
    [scrollView addSubview:baseGrayView];
    
    [self setReturnButtonAndTrashButton];
    [self setDateView];
    
    UIButton *addPhotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 306)];
    [addPhotoBtn setImage:[UIImage imageNamed:@"未输入照片"] forState:UIControlStateNormal];
    [addPhotoBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [baseGrayView addSubview:addPhotoBtn];
    
    //设置尺子
    rulerView=[[RulerView alloc]initWithFrame:CGRectMake(4, SCREEN_HEIGHT - 384, SCREEN_WIDTH-10, 283)];
    [rulerView setColor:RED_COLOR];
    [rulerView setfLable:@""];
    [rulerView setWeight:1];
    rulerView.clipsToBounds=YES;
    [rulerView initRuler_MinScale:0.1 minNumValue:0 NumValue:0 NumUnit:@"Kg" Precision:1 MaxNumValue:100];
    [scrollView addSubview:rulerView];
    
    //设置单位
    aUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 22- 222, 180, 22)];
    aUnitLabel.attributedText = [self weightUnit:@"Kg"];
    [scrollView addSubview:aUnitLabel];
    
    //设置标尺
    UIImageView *scaleView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 8, SCREEN_HEIGHT-234, 16, 16)];
    scaleView.image = [UIImage imageNamed:@"red_Triangle 3"];
    [scrollView addSubview:scaleView];
    
    //设置底下按钮
    UIButton *recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 117.5, SCREEN_HEIGHT - 80, 235, 60)];
    [recordBtn addTarget:self action:@selector(weightBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel *recordBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 16, 55, 28)];
    recordBtnLabel.textColor = RED_COLOR;
    recordBtnLabel.text = @"记录";
    recordBtnLabel.font = [UIFont systemFontOfSize:20];
    recordBtnLabel.textAlignment = NSTextAlignmentCenter;
    [recordBtn addSubview:recordBtnLabel];
    recordBtn.backgroundColor = [UIColor whiteColor];
    recordBtn.layer.cornerRadius = 10.f;
    recordBtn.layer.masksToBounds = YES;
    recordBtn.layer.borderWidth = 1.f;
    recordBtn.layer.borderColor = RED_COLOR.CGColor;
    [scrollView addSubview:recordBtn];
}

//
- (void)setReturnButtonAndTrashButton{
    //button
    //返回上一页button
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 33, 25, 22)];
    [returnBtn setImage:[UIImage imageNamed:@"arrow-thin-left_gray"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToView) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:returnBtn];
    
    //垃圾箱button
    UIButton *trashBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-25, 33, 25, 22)];
    [trashBtn setImage:[UIImage imageNamed:@"trash_gray"] forState:UIControlStateNormal];
    [trashBtn addTarget:self action:@selector(moveToTrash) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:trashBtn];
}

//
- (void)setDateView{
    
    /******************  设置日期  *********************/
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    nowDate = [NSDate date];
    [dateFormatter setDateFormat:@"yy·MM·dd"];
    
    //日期label
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 32, 100, 20)];
    dateLabel.font = [UIFont fontWithName:PINGFANG size:18.f];
    dateLabel.textColor = DEEPGRAY_COLOR;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nowDate]];
    [scrollView addSubview:dateLabel];
    
    UIButton *subDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50 -20, 35, 10, 15)];
    [subDateBtn setImage:[UIImage imageNamed:@"subDate"] forState:UIControlStateNormal];
    [subDateBtn addTarget:self action:@selector(subDate) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:subDateBtn];
    
    UIButton *addDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 50 +10, 35, 10, 15)];
    [addDateBtn setImage:[UIImage imageNamed:@"addDate"] forState:UIControlStateNormal];
    [addDateBtn addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addDateBtn];
}

//
- (void)setScrollView{
    scrollViewX = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 132, SCREEN_WIDTH, 120)];
    //scrollViewX.pagingEnabled = YES;
    scrollViewX.backgroundColor = [UIColor clearColor];
    scrollViewX.showsVerticalScrollIndicator = NO;
    scrollViewX.showsHorizontalScrollIndicator = NO;
    scrollViewX.delegate = self;
    
    scrollViewX.alwaysBounceVertical = NO;
    
    CGSize newSize = CGSizeMake(160 + 250*20, 120);
    [scrollViewX setContentSize:newSize];
    if (self.fNo) {
        [scrollViewX setContentOffset:CGPointMake(250*[self.fNo intValue]-250, 0)];
    }
    
}

#pragma mark --- scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollViewxx{
    
    float number = scrollViewxx.contentOffset.x;
    NSLog(@"%f",number);
    if (self.viewType == 1) {
        if(0 <= number && number<= 30){
            [rulerView setWeight:73];
            unitLabel.attributedText = [self sportUnit:@"公里"];
            foodTag = 1;
        }
        else if(220 <= number && number<= 280){
            [rulerView setWeight:58];
            unitLabel.attributedText = [self sportUnit:@"公里"];
            foodTag = 2;
        }
        else if(470 <= number && number<= 530){
            [rulerView setWeight:255];
            unitLabel.attributedText = [self sportUnit:@"公里"];
            foodTag = 3;
        }
        else if(720 <= number && number<= 780){
            [rulerView setWeight:69];
            unitLabel.attributedText = [self sportUnit:@"公里"];
            foodTag = 4;
        }
        else if(970 <= number && number<= 1030){
            [rulerView setWeight:415];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 5;
        }
        else if(1220 <= number && number<= 1280){
            [rulerView setWeight:550];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 6;
        }
        else if(1470 <= number && number<= 1530){
            [rulerView setWeight:400];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 7;
        }
        else if(1720 <= number && number<= 1780){
            [rulerView setWeight:448];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 8;
        }
        else if(1970 <= number && number<= 2030){
            [rulerView setWeight:300];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 9;
        }
        else if(2220 <= number && number<= 2280){
            [rulerView setWeight:330];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 10;
        }
        else if(2470 <= number && number<= 2530){
            [rulerView setWeight:450];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 11;
        }
        else if(2720 <= number && number<= 2780){
            [rulerView setWeight:425];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 12;
        }
        else if(2970 <= number && number<= 3030){
            [rulerView setWeight:0.225];
            unitLabel.attributedText = [self sportUnit:@"个"];
            foodTag = 13;
        }
        else if(3220 <= number && number<= 3280){
            [rulerView setWeight:3.3];
            unitLabel.attributedText = [self sportUnit:@"分钟"];
            foodTag = 14;
        }
        else if(3470 <= number && number<= 3530){
            [rulerView setWeight:0.215];
            unitLabel.attributedText = [self sportUnit:@"个"];
            foodTag = 15;
        }
        else if(3720 <= number && number<= 3780){
            [rulerView setWeight:300];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 16;
        }
        else if(3970 <= number && number<= 4030){
            [rulerView setWeight:5];
            unitLabel.attributedText = [self sportUnit:@"公斤/小时"];
            foodTag = 17;
        }
        else if(4220 <= number && number<= 4280){
            [rulerView setWeight:300];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 18;
        }
        else if(4470 <= number && number<= 4530){
            [rulerView setWeight:480];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 19;
        }
        else if(4720 <= number && number<= 4780){
            [rulerView setWeight:240];
            unitLabel.attributedText = [self sportUnit:@"小时"];
            foodTag = 20;
        }
        else if(4970 <= number && number<= 5030){
            
        }

    }
    else if(self.viewType ==2){
        if(0 <= number && number<= 30){
            [rulerView setWeight:250];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 1;
        }
        else if(220 <= number && number<= 280){
            [rulerView setWeight:333];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 2;
        }
        else if(470 <= number && number<= 530){
            [rulerView setWeight:233];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 3;
        }
        else if(720 <= number && number<= 780){
            [rulerView setWeight:217];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 4;
        }
        else if(970 <= number && number<= 1030){
            [rulerView setWeight:40];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 5;
        }
        else if(1220 <= number && number<= 1280){
            [rulerView setWeight:42];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 6;
        }
        else if(1470 <= number && number<= 1530){
            [rulerView setWeight:200];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 7;
        }
        else if(1720 <= number && number<= 1780){
            [rulerView setWeight:245];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 8;
        }
        else if(1970 <= number && number<= 2030){
            [rulerView setWeight:255];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 9;
        }
        else if(2220 <= number && number<= 2280){
            [rulerView setWeight:215];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 10;
        }
        else if(2470 <= number && number<= 2530){
            [rulerView setWeight:160];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 11;
        }
        else if(2720 <= number && number<= 2780){
            [rulerView setWeight:278];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 12;
        }
        else if(2970 <= number && number<= 3030){
            [rulerView setWeight:588];
            unitLabel.attributedText = [self foodUnit:@"份"];
            foodTag = 13;
        }
        else if(3220 <= number && number<= 3280){
            [rulerView setWeight:2.42];
            unitLabel.attributedText = [self foodUnit:@"g"];
            foodTag = 14;
        }
        else if(3470 <= number && number<= 3530){
            [rulerView setWeight:0.38];
            unitLabel.attributedText = [self foodUnit:@"g"];
            foodTag = 15;
        }
        else if(3720 <= number && number<= 3780){
            [rulerView setWeight:3.77];
            unitLabel.attributedText = [self foodUnit:@"g"];
            foodTag = 16;
        }
        else if(3970 <= number && number<= 4030){
            [rulerView setWeight:54];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 17;
        }
        else if(4220 <= number && number<= 4280){
            [rulerView setWeight:102];
            unitLabel.attributedText = [self foodUnit:@"个"];
            foodTag = 18;
        }
        else if(4470 <= number && number<= 4530){
            [rulerView setWeight:0.36];
            unitLabel.attributedText = [self foodUnit:@"g"];
            foodTag = 19;
        }
        else if(4720 <= number && number<= 4780){
            [rulerView setWeight:0.39];
            unitLabel.attributedText = [self foodUnit:@"g"];
            foodTag = 20;
        }
        else if(4970 <= number && number<= 5030){
            
        }
        amount = [rulerView returnWeight];
    }
    
}

#pragma mark - button action

- (void)returnToView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)moveToTrash{
    NSLog(@"moveToTrash");
    
    if(self.viewType == 2){
        [[LocalDBManager sharedManager] deleteTodayFood:[self.fcNo intValue]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(self.viewType == 1){
        [[LocalDBManager sharedManager] deleteTodaySport:[self.fcNo intValue]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)subDate{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)addDate{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];

}

- (void)addPhoto{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该功能即将推出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC setDismissInterval:ALERT_TIME];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)sportBtn{
    NSLog(@"sportBtn");
    self.sNo = [NSString stringWithFormat:@"%d",foodTag];
    BOOL scFlag = false;
    for (int i; i < self.ssNo.count; i++) {
        if (self.ssNo[i] == self.sNo) {
            scFlag = 1;
        }
    }
    if (scFlag == 0) {
        [[LocalDBManager sharedManager] insertTodaySport:foodTag date:dateString sTarget:[rulerView getScrollResult] sComplete:0.0 userId:[[NSUserDefaults valueWithKey:@"userId"] intValue]];
    }
    else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"该运动项目已存在，请在原项目中修改" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)breakfastBtn{
    NSLog(@"breakfastBtn");
    [[LocalDBManager sharedManager] insertTodayFood:foodTag date:dateString time:1 fAmount:[rulerView getScrollResult] userId:[[NSUserDefaults valueWithKey:@"userId"] intValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)lunchBtn{
    NSLog(@"lunchBtn");
    [[LocalDBManager sharedManager] insertTodayFood:foodTag date:dateString time:2 fAmount:[rulerView getScrollResult] userId:[[NSUserDefaults valueWithKey:@"userId"] intValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dinnerBtn{
    NSLog(@"dinnerBtn");
    [[LocalDBManager sharedManager] insertTodayFood:foodTag date:dateString time:3 fAmount:[rulerView getScrollResult] userId:[[NSUserDefaults valueWithKey:@"userId"] intValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)weightBtn{
    
    [NSUserDefaults saveValue:[NSNumber numberWithDouble:[rulerView getScrollResult]] forKey:@"currectWeight"];
    NSLog(@"%f",[[NSUserDefaults valueWithKey:@"currectWeight"] floatValue]);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)isSearchBarHide{
    [localSearchBar resignFirstResponder];
    searchBarButton.hidden = YES;
}

#pragma mark date
-(NSString*)getDate:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    
    //日期的增减 已经调整到东八区时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy·MM·dd"];
    NSDate *date = [dateFormatter dateFromString:dateLabel.text];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy·MM·dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateFromData = [formatter stringFromDate:newdate];
//    NSLog(@"dateFromData===%@",dateFromData);
    return dateFromData;
}

#pragma mark MutableAttributedString

- (NSMutableAttributedString *)sportUnit:(NSString*)sport{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"运动量(单位:%@)",sport]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:12.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(3, attrStr.length-3)];
    return attrStr;
}

- (NSMutableAttributedString *)foodUnit:(NSString*)food{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"食物分量(单位:%@)",food]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:12.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(4, attrStr.length-4)];
    return attrStr;
}

- (NSMutableAttributedString *)weightUnit:(NSString*)weight{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"体重(单位:%@)",weight]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:16.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont fontWithName:PINGFANG size:12.f],
                             NSForegroundColorAttributeName : DEEPGRAY_COLOR
                             } range:NSMakeRange(2, attrStr.length-2)];
    return attrStr;
}

@end
