//
//  DDHTTPManger.h
//  ddhyShipper
//
//  Created by 岳俊杰 on 15/12/2.
//  Copyright © 2015年 tdhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "LogInViewController.h"
@interface DDHTTPManger : NSObject<UIAlertViewDelegate>

+ (void)GET:(NSString *)url  completionBlock:(void(^)(NSDictionary *dictionary))block;
+ (void)POST:(NSMutableDictionary *)requestBody withURL:(NSString *)url completionBlock:(void(^)(NSDictionary *dictionary))block;
+(NSString *)md5:(NSString *)str;
+(NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+(void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
+ (BOOL)isBlankString:(NSString*)string;
/**
 *  是否WIFI
 */
+ (BOOL)isEnableWIFI;
/**
 *  是否3G
 */
+ (BOOL)isEnable3G;
@end
