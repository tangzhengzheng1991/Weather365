//
//  WeatherTableViewController.m
//  HowFarToGo
//
//  Created by tangzhengzheng on 15/12/27.
//  Copyright © 2015年 TianDiHuaYu. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "WeatherTableViewCell.h"
#import "CitySelectTableViewController.h"
#import "Reachability.h"
#import "MJRefresh.h"
#import "CitySelectRequestViewController.h"
#import "AppDelegate.h"


@interface WeatherTableViewController ()
{
    /**   未来四天的天气 */
    NSMutableArray *_forecastWeatherArr;
    /**   当天的天气 */
    //    NSMutableArray *todayWeatherArr;
    NSMutableDictionary *_todayWeatherDic;
    /**  未来四天的天气控件  */
    NSMutableArray *_forecastWeatherWidget;
    
    UIView           *_reachbilitView;
    UITableView *_tableView;
    NSInteger _currentPageNum;
    
    
}
//网络
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, assign) int citycount;
@property (strong,nonatomic) todayDetailsBaseClass *todayDetails;
@property (strong,nonatomic) WeakWeatherBaseClass *weakWeather;
@property (nonatomic,strong) UIButton *menuBtn;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) AppDelegate *tempAppDelegate;
@property (nonatomic,strong) UIPageControl *pageControl;

//历史搜索记录
@property (nonatomic, strong) NSMutableArray *hisDatas;


@end

@implementation WeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"天气预报";
    _tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _tempAppDelegate.LeftSlideVC.pan.enabled=NO;
    
    
    _forecastWeatherArr=[[NSMutableArray alloc] init];
    _todayWeatherDic=[[NSMutableDictionary alloc] init];
    _forecastWeatherWidget=[[NSMutableArray alloc] init];
    
    


    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,DD_WIDTH, DD_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self; //代理
    _tableView.dataSource = self;
    
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, DD_WIDTH, DD_HEIGHT-64-49)];
    imageview.image=[UIImage imageNamed:@"天气背景"];
    
    _tableView.backgroundView=imageview;

    
    
#pragma mark--通知
    [self Notification];
    
#pragma mark----- 自定义 navigationItem
    [self customNavigationItem];
    
#pragma mark----- 下拉刷新
    [self setUpRefresh];

 #pragma mark--数据初始化
    [self DataInitialization];
 
#pragma mark 手势操作
    [self SwipeGestureRecognizer];
    
}

-(void)Notification{
#pragma mark--左侧编辑完成通知
    
    [NOTI_CENTENT addObserver:self selector:@selector(leftSortsViewEditComplete:) name:@"EditComplete" object:nil];
    
#pragma mark --获得选择城市的天气 (天气通知)
    
    /** 接受端：接受（第一步） 创建通知中心 */
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    /** center addObserver:添加通知接收的观察者 */
    [center addObserver:self selector:@selector(receiveNote:)name:@"selectAddress" object:nil];
    
    
#pragma mark --检测网络 (网络通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    // 获得Reachability对象
    self.reachability = [Reachability reachabilityForInternetConnection];
    // 开始监控网络
    [self.reachability startNotifier];
    
    [self reachabilitView];
    [self networkStateChange];
}




-(void)customNavigationItem{
    
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame=CGRectMake(0, 0, 25, 25);
    [searchButton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    //    [searchButton setBackgroundImage:] forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchButton.contentMode = UIViewContentModeScaleAspectFit;
    
    //查找城市
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    
    
    //分享
    //    UIButton *shareButton=[UIButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, 0, 30, 22) backgroundImage:[UIImage imageNamed:@"share"] target:self action:@selector(shareView)];
    //    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItem=right1;
    
    //    self.navigationItem.rightBarButtonItems = @[right2, right1];
    
    
    
    self.navigationItem.hidesBackButton = YES;
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame = CGRectMake(0, 0, 26, 26);
    _menuBtn.backgroundColor = [UIColor clearColor];
    [_menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [_menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_menuBtn];
}



-(void)DataInitialization{
    if (_hisDatas == nil) {
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"上海", nil];
        }
    }else{
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
    }
    
    
    
    //    NSInteger i = 0;
    
    
    if ([_hisDatas containsObject:[USER_D objectForKey:@"previouslySelectedCities"]]) {
        
        _currentPageNum=[_hisDatas indexOfObject:[USER_D objectForKey:@"previouslySelectedCities"]];
        
        //        cell2.pageControl.currentPage =i;
        
        
        
        
        //        NSIndexPath *fistPath = [NSIndexPath indexPathForRow:i inSection:0];
        //        [_tableView selectRowAtIndexPath:fistPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

-(void)SwipeGestureRecognizer{
    //1.创建一个清扫手势
    UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
    horizontal.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:horizontal];
    
    UISwipeGestureRecognizer *horizontal2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
    horizontal2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:horizontal2];
}







-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}






#pragma mark----- 打开或关闭侧拉窗
- (void)openOrCloseLeftList
{
    
    if (_tempAppDelegate.LeftSlideVC.closed==YES)
    {
        [_tempAppDelegate.LeftSlideVC openLeftView];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [_tempAppDelegate.LeftSlideVC closeLeftView];
 
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----- 下拉刷新
-(void)setUpRefresh{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self initData];
//        [self request:self.cityName];
        if ([USER_D objectForKey:@"previouslySelectedCities"]) {
            [self request:[USER_D objectForKey:@"previouslySelectedCities"]];
        }else{
            self.cityName=@"上海";
            [self request:self.cityName];
        }

    }];
    [_tableView.header beginRefreshing];
}

-(void)dealloc
{
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark----- 天气通知处理方法
- (void) receiveNote:(NSNotification *) notification{
    //替换字符串
       NSString *selectedCityname = notification.object;
    selectedCityname = [selectedCityname stringByReplacingOccurrencesOfString:@"市" withString:@""];
    
    [self request:selectedCityname];
    
}




-(void)reachabilitView
{
    _reachbilitView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, DD_WIDTH, 90/2)];
    _reachbilitView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _reachbilitView.userInteractionEnabled = YES;
    [self.view addSubview:_reachbilitView];
    
    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(50, 8, DD_WIDTH - 20-50, 30)];
    label.text = @"网络请求失败，请检查你的网络";
    label.textColor = [UIColor whiteColor];
    [_reachbilitView addSubview:label];
    
    UIImageView *wifiImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_wifi2"]];
    wifiImageView.frame = CGRectMake(10, 15, 18, 18);
    [_reachbilitView addSubview:wifiImageView];
    
    UIButton *reachabilit = [UIButton buttonWithType:UIButtonTypeCustom];
    reachabilit.frame = CGRectMake(0, 0, DD_WIDTH, 98/2);
    reachabilit.backgroundColor = [UIColor clearColor];
    [reachabilit addTarget:self action:@selector(reachabilitClick) forControlEvents:UIControlEventTouchUpInside];
    [_reachbilitView  addSubview:reachabilit];
    [self.view addSubview:_reachbilitView];
    
}
-(void)reachabilitClick
{
    NSLog(@"sdas进了");
}
- (void)networkStateChange
{
    
    if ([DDHTTPManger isEnableWIFI]) {
        NSLog(@"WIFI环境");
        _reachbilitView.hidden = YES;
        if ([USER_D objectForKey:@"previouslySelectedCities"]) {
            [self request:[USER_D objectForKey:@"previouslySelectedCities"]];
        }else{
            self.cityName=@"上海";
            [self request:self.cityName];
        }

    } else if ([DDHTTPManger isEnable3G]) {
        NSLog(@"手机自带网络");
        _reachbilitView.hidden = YES;
        if ([USER_D objectForKey:@"previouslySelectedCities"]) {
            [self request:[USER_D objectForKey:@"previouslySelectedCities"]];
        }else{
            self.cityName=@"上海";
            [self request:self.cityName];
        }

        
    } else {
        
        _reachbilitView.hidden = NO;
    }
    
}



-(void)selectCity{
    NSLog(@"查询可用城市天气跳转");
    
//    CitySelectTableViewController *vc=[[CitySelectTableViewController alloc] init];
    CitySelectRequestViewController *vc=[[CitySelectRequestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)shareView{
    //分享
    NSLog(@"分享");
}



-(void)request:(NSString *)cityName{
    
//    NSString *cityNameUTF8=[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//转换成UTF8编码
//    NSLog(@"cityNameUTF8%@",cityNameUTF8);
//    //    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityinfo";
//    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityname";
//    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@?cityname=%@",url,cityNameUTF8];
    
    //    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityinfo";
    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityname";
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@?cityname=%@",url,cityName];
    
    
   urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    
    [DDHTTPManger GET:urlStr completionBlock:^(NSDictionary *dictionary){
        NSLog(@"dictionary==%@",dictionary);
        
        
        
        self.todayDetails=[todayDetailsBaseClass modelObjectWithDictionary:dictionary];
        
        int cityid = [self.todayDetails.retData.citycode intValue];
        
        
        

        
//        [[[dictionary objectForKey:@"retData"] objectForKey:@"latitude"] intValue];//纬度
//        [[[dictionary objectForKey:@"retData"] objectForKey:@"longitude"] intValue];//经度
        
        [self WeatherrequestCityId:cityid CityName:cityName];
    }];
    
}



-(void)WeatherrequestCityId:(int)cityId CityName:(NSString *)cityName{
    
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/recentweathers";
    NSString *urlStr=[NSString stringWithFormat:@"%@?cityname=%@&cityid=%d",httpUrl,cityName,cityId];
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [DDHTTPManger GET:urlStr completionBlock:^(NSDictionary *dictionary){
        
        
        [_tableView.header endRefreshing];
        
    
        [_forecastWeatherArr removeAllObjects];
        //         NSLog(@"天气预报的内容为%@",dictionary);
        
        self.weakWeather= [WeakWeatherBaseClass modelObjectWithDictionary:dictionary];
        for (WeakWeatherForecast * model in self.weakWeather.retData.forecast)
        {
            [_forecastWeatherArr addObject:model];
        }
        
        [USER_D setObject:[NSString stringWithFormat:@"%@",self.weakWeather.retData.city] forKey:@"previouslySelectedCities"];
        
        self.cityName=[NSString stringWithFormat:@"%@",self.weakWeather.retData.city];
        self.citycount=(int)(_forecastWeatherArr.count-3);
        
        
        
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
            if (_hisDatas == nil) {
                _hisDatas = [NSMutableArray arrayWithObjects:@"上海", nil];
            }
        }else{
            _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        }
        
        NSLog(@"%@",self.cityName);
        NSLog(@"%@",_hisDatas);

        
        
        if (![_hisDatas containsObject:self.cityName]) {
            [self.hisDatas insertObject:self.cityName atIndex:0];
            [self.hisDatas writeToFile:SearchHistoryPath atomically:YES];
        }
        
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.leftVC refresh];
        
        
        [_tableView reloadData];
        
        
     }];
    
}





//天气图片展示
-(void)weatherIcon:(UIImageView *)weatherIcon WeatherInfo:(NSString *)WeatherInfo{
    
    weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    
////    这个居中是包括了，横向和纵向都是居中。图片不会拉伸或者压缩，就是按照imageView的frame和图片的大小来居中显示的。
//    weatherIcon.contentMode = UIViewContentModeCenter;
//    
//    
////    如果在默认情况，图片的多出来的部分还是会显示屏幕上。如果不希望超过frame的区域显示在屏幕上要设置。clipsToBounds属性
//    weatherIcon.clipsToBounds  = YES;
    //    if ([WeatherInfo rangeOfString:@"多云"].location != NSNotFound) {
    //        weatherIcon.image=[UIImage imageNamed:@"weather_多云"];
    //
    //    }
    
    
    
    if ([WeatherInfo isEqualToString:@"晴"]) {
        weatherIcon.image=[UIImage imageNamed:@"00"];
        
    }else if([WeatherInfo isEqualToString:@"多云"]) {
        weatherIcon.image=[UIImage imageNamed:@"01"];
        
    }else if([WeatherInfo isEqualToString:@"阴"]) {
        weatherIcon.image=[UIImage imageNamed:@"02"];
        
    }else if([WeatherInfo isEqualToString:@"阵雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"03"];
        
    }else if([WeatherInfo isEqualToString:@"雷阵雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"04"];
        
    }else if([WeatherInfo isEqualToString:@"雷阵雨伴有冰雹"]) {
        weatherIcon.image=[UIImage imageNamed:@"05"];
        
    }else if([WeatherInfo isEqualToString:@"雨夹雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"06"];
        
    }else if([WeatherInfo isEqualToString:@"小雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"07"];
        
    }else if([WeatherInfo isEqualToString:@"中雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"08"];
        
    }else if([WeatherInfo isEqualToString:@"大雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"09"];
        
    }else if([WeatherInfo isEqualToString:@"暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"10"];
        
    }else if([WeatherInfo isEqualToString:@"大暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"11"];
        
    }else if([WeatherInfo isEqualToString:@"特大暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"12"];
        
    }else if([WeatherInfo isEqualToString:@"阵雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"13"];
        
    }else if([WeatherInfo isEqualToString:@"小雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"14"];
        
    }else if([WeatherInfo isEqualToString:@"中雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"15"];
        
    }else if([WeatherInfo isEqualToString:@"大雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"16"];
        
    }else if([WeatherInfo isEqualToString:@"暴雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"17"];
        
    }else if([WeatherInfo isEqualToString:@"雾"]) {
        weatherIcon.image=[UIImage imageNamed:@"18"];
        
    }else if([WeatherInfo isEqualToString:@"冻雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"19"];
        
    }else if([WeatherInfo isEqualToString:@"沙尘暴"]) {
        weatherIcon.image=[UIImage imageNamed:@"20"];
        
    }else if([WeatherInfo isEqualToString:@"小到中雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"21"];
        
    }else if([WeatherInfo isEqualToString:@"中到大雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"22"];
        
    }else if([WeatherInfo isEqualToString:@"大到暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"23"];
        
    }else if([WeatherInfo isEqualToString:@"暴雨到大暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"24"];
        
    }else if([WeatherInfo isEqualToString:@"大暴雨到特大暴雨"]) {
        weatherIcon.image=[UIImage imageNamed:@"25"];
        
    }else if([WeatherInfo isEqualToString:@"小到中雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"26"];
        
    }else if([WeatherInfo isEqualToString:@"中到大雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"27"];
        
    }else if([WeatherInfo isEqualToString:@"大到暴雪"]) {
        weatherIcon.image=[UIImage imageNamed:@"28"];
        
    }else if([WeatherInfo isEqualToString:@"浮尘"]) {
        weatherIcon.image=[UIImage imageNamed:@"29"];
        
    }else if([WeatherInfo isEqualToString:@"扬沙"]) {
        weatherIcon.image=[UIImage imageNamed:@"30"];
        
    }else if([WeatherInfo isEqualToString:@"强沙尘暴"]) {
        weatherIcon.image=[UIImage imageNamed:@"31"];
        
    }else if([WeatherInfo isEqualToString:@"霾"]) {
        weatherIcon.image=[UIImage imageNamed:@"53"];
        
    }else{
        weatherIcon.image=[UIImage imageNamed:@"undefined"];
        
    }
    
    
}






#pragma mark - Table view data source 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - Table view data source  每组分几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.citycount;
}

#pragma mark - Table view delegate   //section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00000001;
}
#pragma mark - Table view delegate  //section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001;
}


#pragma mark - Table view delegate  cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DD_HEIGHT-64-49;
}

#pragma mark - Table view delegate  cell选中后
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentifer=@"cell";//显示手机号
//    WeatherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
//    if (cell==nil) {
//        cell=[[WeatherTableViewCell alloc] init];
//    }

    
    
    static NSString *CellIdentifier2 = @"CellIdentifier2";
    WeatherTableViewCell *cell2 = (WeatherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (cell2 == nil) {
        //根据nib，实例化cell
        NSArray *nib = [[UINib nibWithNibName:@"WeatherTableViewCell" bundle:nil] instantiateWithOwner:self options:nil];
        cell2= (WeatherTableViewCell *)[nib objectAtIndex:0];
    }
    
    
    cell2.backgroundColor=[UIColor clearColor];
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    [cell2.currentCityButton setTitle:[NSString stringWithFormat:@"当前城市:  %@",self.weakWeather.retData.city] forState:UIControlStateNormal];
    
    [cell2.currentCityButton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    
//    cell2.currentCityButton.text = [NSString stringWithFormat:@"当前城市:  %@",self.weakWeather.retData.city];
    
    
//    cell2.cityName=[NSString stringWithFormat:@"%@",self.weakWeather.retData.city];
    
    
    cell2.currentTemperature.text=[NSString stringWithFormat:@"当前温度: %@",self.weakWeather.retData.today.curTemp];
    cell2.currentWindDirection.text=[NSString stringWithFormat:@"当前风向: %@",self.weakWeather.retData.today.fengxiang];
    cell2.currentWindPower.text = [NSString stringWithFormat:@"当前风力: %@",self.weakWeather.retData.today.fengli];
    
    
    
    
    cell2.TodayDate.text = self.weakWeather.retData.today.date;
    cell2.TodayWeather.text = self.weakWeather.retData.today.type;
    cell2.TodayTemperature.text = [NSString stringWithFormat:@"%@ ~ %@",self.weakWeather.retData.today.lowtemp,self.weakWeather.retData.today.hightemp];
    cell2.TodayWeek.text = self.weakWeather.retData.today.week;
    cell2.sunriseTime.text=self.todayDetails.retData.sunrise;
    cell2.sunsetTime.text=self.todayDetails.retData.sunset;
//    cell2.sunriseAndSunsetImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self weatherIcon:cell2.TodayWeatherIcon WeatherInfo:cell2.TodayWeather.text];
    
//    NSString *s=@"2016-02-23";
//    NSLog(@"%lu",(unsigned long)s.length);
    //未来第1天
    
    if([[_forecastWeatherArr[0] valueForKey:@"date"] length]!=10){
        
        cell2.secondDateWeak.text=[NSString stringWithFormat:@"%@ %@",[_forecastWeatherArr[0] valueForKey:@"date"],[_forecastWeatherArr[0] valueForKey:@"week"]];
    }else{
        cell2.secondDateWeak.text=[NSString stringWithFormat:@"%@ %@",[[[_forecastWeatherArr[0] valueForKey:@"date"]stringByReplacingOccurrencesOfString:@"-" withString:@"" ] substringWithRange:NSMakeRange (4, 4)],[_forecastWeatherArr[0] valueForKey:@"week"]];
    }
    
    cell2.secondWeather.text=[_forecastWeatherArr[0] valueForKey:@"type"];
    cell2.secondTemperature.text=[NSString stringWithFormat:@"%@ ~ %@",[_forecastWeatherArr[0] valueForKey:@"lowtemp"],[_forecastWeatherArr[0] valueForKey:@"hightemp"]];
//    cell2.secondTemperature.text=@"-39℃ ~ -34℃";
    [self weatherIcon:cell2.secondWeatherIcon WeatherInfo:cell2.secondWeather.text];
    
    
    
    //未来第2天
    
    if([[_forecastWeatherArr[1] valueForKey:@"date"] length]!=10){
        
        cell2.thirdDateWeak.text=[NSString stringWithFormat:@"%@ %@",[_forecastWeatherArr[1] valueForKey:@"date"],[_forecastWeatherArr[1] valueForKey:@"week"]];
    }else{
        cell2.thirdDateWeak.text=[NSString stringWithFormat:@"%@ %@",[[[_forecastWeatherArr[1] valueForKey:@"date"]stringByReplacingOccurrencesOfString:@"-" withString:@"" ] substringWithRange:NSMakeRange (4, 4)],[_forecastWeatherArr[1] valueForKey:@"week"]];
    }
    

    cell2.thirdWeather.text=[_forecastWeatherArr[1] valueForKey:@"type"];
    cell2.thirdTemperature.text=[NSString stringWithFormat:@"%@ ~ %@",[_forecastWeatherArr[1] valueForKey:@"lowtemp"],[_forecastWeatherArr[1] valueForKey:@"hightemp"]];
    [self weatherIcon:cell2.thirdWeatherIcon WeatherInfo:cell2.thirdWeather.text];
    
    
    
    //未来第3天
    
    if([[_forecastWeatherArr[2] valueForKey:@"date"] length]!=10){
        
        cell2.fourthDateWeak.text=[NSString stringWithFormat:@"%@ %@",[_forecastWeatherArr[2] valueForKey:@"date"],[_forecastWeatherArr[2] valueForKey:@"week"]];
    }else{
        cell2.fourthDateWeak.text=[NSString stringWithFormat:@"%@ %@",[[[_forecastWeatherArr[2] valueForKey:@"date"]stringByReplacingOccurrencesOfString:@"-" withString:@"" ] substringWithRange:NSMakeRange (4, 4)],[_forecastWeatherArr[2] valueForKey:@"week"]];
    }
    
    cell2.fourthWeather.text=[_forecastWeatherArr[2] valueForKey:@"type"] ;
    cell2.fourthTemperature.text=[NSString stringWithFormat:@"%@ ~ %@",[_forecastWeatherArr[2] valueForKey:@"lowtemp"],[_forecastWeatherArr[2] valueForKey:@"hightemp"]];
    [self weatherIcon:cell2.fourthWeatherIcon WeatherInfo:cell2.fourthWeather.text];
    
    
    
    //未来第4天
    if([[_forecastWeatherArr[3] valueForKey:@"date"] length]!=10){
        
        cell2.fifthDateWeak.text=[NSString stringWithFormat:@"%@ %@",[_forecastWeatherArr[3] valueForKey:@"date"],[_forecastWeatherArr[3] valueForKey:@"week"]];
    }else{
       cell2.fifthDateWeak.text=[NSString stringWithFormat:@"%@ %@",[[[_forecastWeatherArr[3] valueForKey:@"date"]stringByReplacingOccurrencesOfString:@"-" withString:@""] substringWithRange:NSMakeRange (4, 4)],[_forecastWeatherArr[3] valueForKey:@"week"]];
    }

       
    cell2.fifthWeather.text=[_forecastWeatherArr[3] valueForKey:@"type"] ;
    cell2.fifthTemperature.text=[NSString stringWithFormat:@"%@ ~ %@",[_forecastWeatherArr[3] valueForKey:@"lowtemp"],[_forecastWeatherArr[3] valueForKey:@"hightemp"]];
    [self weatherIcon:cell2.fifthWeatherIcon WeatherInfo:cell2.fifthWeather.text];
    
//    cell2.secondTemperature.text=@"-15℃ ~ -50℃";
    if (DD_WIDTH==414) {
        
        cell2.secondTemperature.font=[UIFont systemFontOfSize:13];
        cell2.thirdTemperature.font=[UIFont systemFontOfSize:13];
        cell2.fourthTemperature.font=[UIFont systemFontOfSize:13];
        cell2.fifthTemperature.font=[UIFont systemFontOfSize:13];
        
        
    }
    if ([_hisDatas count]==1) {
        cell2.pageControl.hidden=YES;
    } else {
        cell2.pageControl.hidden=NO;
        cell2.pageControl.numberOfPages = [_hisDatas count];
        
        cell2.pageControl.tag = 10086;
        cell2.tag=10010;
    }
    
    
    
    
    
    
    
    if (_hisDatas == nil) {
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"上海", nil];
        }
    }else{
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
    }

    if ([_hisDatas containsObject:[USER_D objectForKey:@"previouslySelectedCities"]]) {
        
        NSInteger i=[_hisDatas indexOfObject:[USER_D objectForKey:@"previouslySelectedCities"]];
        
        cell2.pageControl.currentPage =i;
        
        
//        NSIndexPath *fistPath = [NSIndexPath indexPathForRow:i inSection:0];
//        [_tableView selectRowAtIndexPath:fistPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    
    
    
    
    return cell2;
}


//-(void)


#pragma mark ---手势操作

-(void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer {
    NSLog(@"===========");
    
    


    if ([_hisDatas containsObject:[USER_D objectForKey:@"previouslySelectedCities"]]) {
        
        _currentPageNum=[_hisDatas indexOfObject:[USER_D objectForKey:@"previouslySelectedCities"]];
        

    }else{
        _currentPageNum=0;
    }
    
    
    
    UISwipeGestureRecognizer *tmp=(UISwipeGestureRecognizer *)recognizer;
    if (tmp.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left");
        
        int tmp=(int)(_currentPageNum-1);
        if (tmp>=0) {
            _currentPageNum--;
            UITableViewCell *test=[_tableView viewWithTag:10010];
            UIPageControl *tmpPageControl = [test.contentView viewWithTag:10086];
            tmpPageControl.currentPage=tmp;
            NSLog(@"Left--temp%d",tmp);
            
            [self request:_hisDatas[_currentPageNum]];
            
//            [_tableView reloadData];
        }
    } else {
        NSLog(@"Right");
        int tmp=(int)(_currentPageNum+1);
        if (tmp<[_hisDatas count]) {
            _currentPageNum++;
            UITableViewCell *test=[_tableView viewWithTag:10010];
            UIPageControl *tmpPageControl = [test.contentView viewWithTag:10086];
            tmpPageControl.currentPage=tmp;
            NSLog(@"Right--temp%d",tmp);
            [self request:_hisDatas[_currentPageNum]];
//            [_tableView reloadData];
        }
    }
}





#pragma mark --- 左侧编辑完成后调用

- (void) leftSortsViewEditComplete:(NSNotification *) notification{
//    //替换字符串
//    NSString *selectedCityname = notification.object;
//    selectedCityname = [selectedCityname stringByReplacingOccurrencesOfString:@"市" withString:@""];
    
    
    if (_hisDatas == nil) {
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"上海", nil];
        }
    }else{
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
    }
    
    BOOL isDelet = ![_hisDatas containsObject:[USER_D objectForKey:@"previouslySelectedCities"]];
    
    if (isDelet) {
        
        [self request:_hisDatas[0]];
        
    } else {
        [_tableView reloadData];
    }
    
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
