//
//  AppDelegate.h
//  Weather365
//
//  Created by tangzhengzheng on 16/3/17.
//  Copyright © 2016年 TianDiHuaYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"


#import  <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong,nonatomic) LeftSortsViewController *leftVC;


@end

