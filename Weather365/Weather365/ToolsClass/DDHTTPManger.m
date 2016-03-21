//
//  DDHTTPManger.m
//  ddhyShipper
//
//  Created by 岳俊杰 on 15/12/2.
//  Copyright © 2015年 tdhy. All rights reserved.
//

#import "DDHTTPManger.h"
#import "LCProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"
#import "DDWiFiViewController.h"
@implementation DDHTTPManger
+ (void)GET:(NSString *)url  completionBlock:(void(^)(NSDictionary *dictionary))block
{
    if (![DDHTTPManger isEnableWIFI]&&![DDHTTPManger isEnable3G])
    {

        DDWiFiViewController *wifi = [[DDWiFiViewController alloc]init];
    
        NSArray * arr = [[UIApplication sharedApplication] windows];
        UIWindow * window = arr[0];
        [window.rootViewController presentViewController:wifi animated:YES completion:nil];
        
        return;
    }
    
    [LCProgressHUD showLoading:@"正在加载"];
    //++再
    [LCProgressHUD sharedHUD].successCount ++;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"0e12e18c642d7cd0c69042fb752b6dd5"  forHTTPHeaderField:@"apikey"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/html",nil];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"\n--\noperation.responseString----\n%@",operation.responseString);
//        NSLog(@"\n--\responseObject----\n%@",responseObject);
        //--
        [LCProgressHUD sharedHUD].successCount --;
        
        if ([LCProgressHUD sharedHUD].successCount == 0)
        {
            [LCProgressHUD hide];
        }
        
        
//        if ([[operation.responseObject objectForKey:@"errNum"] intValue ]==-1) {
//            [LCProgressHUD hide];
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"retMsg"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            return ;
//        }
        if ([[operation.responseObject objectForKey:@"errNum"] intValue ]==-1) {
            [LCProgressHUD hide];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"errMsg"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        
        
        
        
        
        
        
        
        
//        if ([[operation.responseObject objectForKey:@"retMsg"] length]>0)
//        {
//            [LCProgressHUD hide];
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"retMsg"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            return ;
//        }
        
        
        
        
        
        
        
        

//        if ([[operation.responseObject objectForKey:@"errorCode"]isEqualToString:@"1"])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"errorMessage"]delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            if ([[operation.responseObject objectForKey:@"errorMessage"] isEqualToString:@"账号未登录"])
//            {
//                [USER_D removeObjectForKey:@"back"];
//                [USER_D removeObjectForKey:@"FirstLogin"];
//                [USER_D setObject:@"isLoginBtn" forKey:@"LoginBtn"];
//                LogInViewController *loginVC = [[LogInViewController alloc]init];
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//                [[UIApplication sharedApplication].windows[0] setRootViewController:nav];
//                
//            }
//            return;
//        }
    
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@",operation.responseString);

        [LCProgressHUD sharedHUD].successCount --;
        [LCProgressHUD showFailure:@"加载失败"];
        if ([[operation.responseObject objectForKey:@"retMsg"] length]>0)
        {
                [LCProgressHUD hide];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"retMsg"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
          }
    }];
}
+ (void)POST:(NSMutableDictionary *)requestBody withURL:(NSString *)url completionBlock:(void(^)(NSDictionary *dictionary))block
{
    if (![DDHTTPManger isEnableWIFI]&&![DDHTTPManger isEnable3G])
    {
        
        DDWiFiViewController *wifi = [[DDWiFiViewController alloc]init];
        
        NSArray * arr = [[UIApplication sharedApplication] windows];
        UIWindow * window = arr[0];
        [window.rootViewController presentViewController:wifi animated:YES completion:nil];
        
        return;
    }
    [LCProgressHUD showLoading:@"正在加载"];
    //++再
    [LCProgressHUD sharedHUD].successCount ++;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//     manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    
    
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    

    
    
//    [manager.requestSerializer setValue:[USER_D objectForKey:@"loginId"] forHTTPHeaderField:@"loginId"];
    
    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];

    [manager POST:url parameters:requestBody success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"解析的东西%@",operation.responseString);
//         NSLog(@"解析的东西%@",responseObject);
        
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUnicodeStringEncoding];
        
        
        //--
        [LCProgressHUD sharedHUD].successCount --;
        
        if ([LCProgressHUD sharedHUD].successCount == 0)
        {
            [LCProgressHUD hide];
        }
//        if ([[operation.responseObject objectForKey:@"errorCode"]isEqualToString:@"1"])
//        {
//            
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"errorMessage"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            if ([[operation.responseObject objectForKey:@"errorMessage"] isEqualToString:@"账号未登录"])
//            {
//                
//                LogInViewController *loginVC = [[LogInViewController alloc]init];
//                 UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//                [[UIApplication sharedApplication].windows[0] setRootViewController:nav];
//                
//            }
//            return;
//        }
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD sharedHUD].successCount --;
        [LCProgressHUD showFailure:@"加载失败"];
        
        NSLog(@"error====%@",error);
        
        
        
        //                NSLog(@"%@",operation.responseString);
        if ([[operation.responseObject objectForKey:@"errorMessage"] length]>0)
        {
            [LCProgressHUD hide];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[operation.responseObject objectForKey:@"errorMessage"]delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }];
}





+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
   
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    
    
    
}
//系统的东西 钥匙串 获取
+(NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+(void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}


+ (BOOL)isBlankString:(NSString*)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSValue class]]) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}
// 是否WIFI
+ (BOOL)isEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL)isEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
@end
