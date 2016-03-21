//
//  DDWiFiViewController.m
//  ddhyShipper
//
//  Created by 岳俊杰 on 15/12/11.
//  Copyright © 2015年 tdhy. All rights reserved.
//

#import "DDWiFiViewController.h"
@interface DDWiFiViewController ()
@end

@implementation DDWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dismiss.clipsToBounds = YES;
    self.dismiss.layer.cornerRadius = 3;
    self.dismiss.layer.borderWidth = 0.5;
    self.dismiss.layer.borderColor = [UIColor orangeColor].CGColor;

}
- (IBAction)dismiss:(id)sender {
    if ([DDHTTPManger isEnableWIFI]) {
        NSLog(@"WIFI环境");
        [self dismissViewControllerAnimated:YES completion:nil];

    } else if ([DDHTTPManger isEnable3G]) {
        NSLog(@"手机自带网络");
        [self dismissViewControllerAnimated:YES completion:nil];

    } else {
        
    }
    
}
@end
