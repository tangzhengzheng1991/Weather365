//
//  AppDelegate.m
//  Weather365
//
//  Created by tangzhengzheng on 16/3/17.
//  Copyright © 2016年 TianDiHuaYu. All rights reserved.
//
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

#import "AppDelegate.h"
#import "WeatherTableViewController.h"

@interface AppDelegate ()
//@property (strong,nonatomic)CLLocationManager *locationManager;
//@property (nonatomic,strong) CLGeocoder *geo;
//@property (nonatomic, copy) NSString *locationCity;// 定位城市
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // Override point for customization after application launch.
    //更改时间颜色
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
//    [self location];
    
    WeatherTableViewController *vc=[[WeatherTableViewController alloc] init];
    
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.leftVC = [[LeftSortsViewController alloc] init];
    
    UINavigationController *leftNavigationController = [[UINavigationController alloc] initWithRootViewController:self.leftVC];
    
    
    
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftNavigationController andMainView: mainNavigationController];
    
    
    //    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    self.LeftSlideVC.pan.enabled=NO;
    
    self.window.rootViewController = self.LeftSlideVC;
    
    
    
    
    
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 4;
    
    [self.window makeKeyAndVisible];
    
    
 
    
    
    return YES;
}



//-(void)location{
//    //定位当前城市
//    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = 100.0f;
//    if (IS_IOS8) {
//        [self.locationManager requestAlwaysAuthorization];//iOS8新增API，，始终允许访问位置信息
//    }
//    [self.locationManager startUpdatingLocation];
//}
//
//
//
//
//#pragma mark - CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *currLocation = [locations lastObject];
//    //NSLog(@"经度＝%f 纬度＝%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude);
//    // 关闭定位
//    [self.locationManager stopUpdatingLocation];
//    // 根据经纬度 反向编码  获取详细地址
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:currLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error){
//                       for (CLPlacemark *place in placemarks) {
//                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
//                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
//                           NSLog(@"locality,%@",place.locality);               // 市
//                           NSLog(@"subLocality,%@",place.subLocality);         // 区
//                           NSLog(@"country,%@",place.country);                 // 国家
//                           NSString * cityName = [place.locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
//                           //                           ArgumentsHandle * handle = [ArgumentsHandle defaultArgumentsHandle];
//                           //                           handle.locationCity = cityName;
//                       }
//                   }];
//    //停止定位
//    [self.locationManager stopUpdatingLocation];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    if ([error code] == kCLErrorDenied)
//    {
//        //访问被拒绝
//        NSLog(@"访问被拒绝-----%@",error);
//    }
//    if ([error code] == kCLErrorLocationUnknown) {
//        //无法获取位置信息
//        NSLog(@"无法获取位置信息-----%@",error);
//    }
//}










- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
