//
//  CitySelectTableViewController.h
//  017天气预报
//
//  Created by hanfeng on 15/7/2.
//  Copyright (c) 2015年 hanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySelectTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

/**把plist文件转换成字典模型*/
@property (strong, nonatomic) NSDictionary *citiesdict;

/**取出键值*/
@property (strong, nonatomic) NSArray *allkeys;

/**中间变量*/
@property (nonatomic) BOOL isSearching;
@property (strong, nonatomic) UITableView *tableView;

/**为searchbar创建Outlet输出口*/
@property (strong, nonatomic) UISearchBar *searchbar;

@end
