//
//  APIMacro.h
//  DDHaoYun
//
//  Created by developer on 15-9-15.
//  Copyright (c) 2015年 developer. All rights reserved.
//

#define StringFromInteger(i) [NSString stringWithFormat:@"%@",@(i)]

#define APP_WINDOW [[[UIApplication sharedApplication] delegate] window]
#define SHOW_ALERT(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];
#define COMMON_FONT [UIFont fontWithName:@"MicrosoftYaHei" size:15]
#define SHOW [ProgressHUD show:@"加载中..."]
#define DISMISS [ProgressHUD dismiss]
#define USER_D [NSUserDefaults standardUserDefaults]

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
/** 当前屏幕中心点 */
#define kScreen_CenterX  kScreen_Width/2
#define kScreen_CenterY  kScreen_Height/2

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define NavBG_RGB rgba(18, 171, 154, 0.9);
//按钮-绿色
#define COLOR [UIColor colorWithRed:40.0/255 green:170.0/255 blue:153.0/255 alpha:1]
#define VCBG_RGB rgba(247, 249, 249, 1.0);

//用户信息字体颜色
#define USER_INFO_COLOR [UIColor colorWithRed:87.0/255 green:87.0/255 blue:87.0/255 alpha:1]
//背景主题颜色
#define DD_BACK_COLOR [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]
/** 设置RGB颜色 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/** 十六进制颜色 */
#define UIColorFromHEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

//#define SERVER_REQUEST_URL @"http://114.141.133.231:8080/app" //生产地址
#define SERVER_REQUEST_URL @"http://10.39.251.134:8080/app"//测试地址
//#define SERVER_REQUEST_URL @"http://10.39.117.143:8080/app"
//#define SERVER_REQUEST_URL @"http://10.39.117.82:8080/app"
//登录
#pragma mark - HTTP
#define Request_HttpMethod_Post @"POST"
#define Request_HttpMethod_Get @"GET"
#define Request_TimeOut 10.0f
//ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)


/** LOG */
#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

#pragma mark - 枚举
typedef enum
{
    AlertView_Logout = 100100,//登出
    AlertView_MakeOrder,//下单
    AlertView_ForceVersionUpdate,//强制更新
    AlertView_SelectVersionUpdate,//选择更新
    AlertView_ForgetPassword//忘记密码
}AlertViewTag;

typedef enum
{
    ManagerTabSwitch_ResearchPosition = 100200,
    ManagerTabSwitch_Notification,
    ManagerTabSwitch_Summary
}ManagerTabSwitchTag;

typedef enum
{
    ResearchTabSwitch_Position = 100300,
    ResearchTabSwitch_Notification
}ResearchTabSwitchTag;