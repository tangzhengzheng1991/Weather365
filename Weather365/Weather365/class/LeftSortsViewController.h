//
//  LeftSortsViewController.h
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"
//#import "AppDelegate.h"
#define LEFT_FontSize 15

@interface LeftSortsViewController : UIViewController
{
    UILabel  *_phoneLabel;
    UIButton *_headBtn;
    UIButton *_loginBtn;

}
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSMutableDictionary *userDictionary;

/** 搜索的数据 */
@property (nonatomic, strong) NSMutableArray *datas;
/** 历史搜索数据 */
@property (nonatomic, strong) NSMutableArray *hisDatas;


-(void)refresh;

@property int arrowsX;
@property CGFloat headWidthHeight;

@end
