//
//  CitySelectTableViewController.m
//  017天气预报
//
//  Created by hanfeng on 15/7/2.
//  Copyright (c) 2015年 hanfeng. All rights reserved.
//

#import "CitySelectTableViewController.h"

@interface CitySelectTableViewController ()

@end

@implementation CitySelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[UITableView alloc]
    initWithFrame:CGRectMake(0, 44, DD_WIDTH, DD_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.view.backgroundColor=[UIColor purpleColor];
    
    
    
    [self.view addSubview:self.tableView];
    
    self.searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, DD_WIDTH, 44)];
    [self.view addSubview:self.searchbar];
    self.searchbar.delegate=self;
    self.searchbar.backgroundColor=[UIColor redColor];
    
    
    
    /**
     *设置CitySelectTableViewController的背景图片
     */
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DD_WIDTH, DD_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"天气背景"];
    [self.tableView setBackgroundView:imageView];
    
//    self.tableView.backgroundView=imageView;
//    self.tableView.backgroundColor = [UIColor orangeColor];
    
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景长的"]];
//    [self.tableView setBackgroundView:imageView];

    
    /**
     *设置导航条的状态
     */
//    self.navigationController.navigationBarHidden = NO;
    /**
     *设置导航条的文字
     */
    self.title = @"选择城市";
    /**
     *设置导航条的文字
     */
//    UIBarButtonItem *tmpbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    
    
    
    UIButton *xx=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [xx setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [xx addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *tmpbutton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"]     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
] style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    self.navigationItem.leftBarButtonItem =tmpbutton;
    
    
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:xx];
    //隐藏按钮
//    self.navigationItem.hidesBackButton = YES;
    /**
     *设置导航条的背景图片
     */
//    UIImage *image = [UIImage imageNamed:@"clearbg"];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    
    
    /**
     *  初始化
     */
    self.isSearching = NO;
    /**
    *获取plist文件的文件包
    */
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *tmppath = [bundle pathForResource:@"citydict" ofType:@"plist"];
    /**
     *转成字典模型来读取
     */
    self.citiesdict = [[NSDictionary alloc]initWithContentsOfFile:tmppath];
    /**
     *再根据字典用数组读取里面allkeys
     */
    self.allkeys = self.citiesdict.allKeys;
    
    /**
     *  字典排序用得方法,compare:
     *  @param compare:系统自带的不同实现<升序，降序>
     */
    self.allkeys = [self.allkeys sortedArrayUsingSelector:@selector(compare:)];
    /**
     *  改变边栏上(索引)的字母的颜色
     */
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    /**
     *  设置边栏上(索引)的背景的颜色
     */
    self.tableView.sectionIndexBackgroundColor =[UIColor clearColor];
}
/**
 *退出这个界面调用这个方法
 */
-(void)closeView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/**
 *一共有多少列
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.allkeys.count;
}
/**
 *  第Section列一共有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *tmpstr = [self.allkeys objectAtIndex:section];
    NSArray *tmparray = [self.citiesdict objectForKey:tmpstr];
    return tmparray.count;//返回数组的数量
}

/**
 *这个方法是用来设置你的TableView中每一行显示的内容和格式的,indexPath 用来指示当前单元格，它的row方法可以获得这个单元格的行号，section方法可以获得这个单元格所处的区域号
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifer=@"cell";//显示手机号
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"styleBasic" forIndexPath:indexPath];
    
    //stylebasic是自定义cell的窗口的identifier名称
    NSInteger tmpsection = indexPath.section;
    NSInteger tmprow = indexPath.row;
    
    NSString *currentsectionname =[self.allkeys objectAtIndex:tmpsection];
    NSArray *tmpcityarray = [self.citiesdict objectForKey:currentsectionname];
    NSString *cityname = [tmpcityarray objectAtIndex:tmprow];//设置当前单元格的显示内容
    cell.textLabel.text =cityname;//针对系统预定义样式
    cell.textLabel.textColor = [UIColor whiteColor];//设置当前单元格的显示字体的颜色
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
/**
 *设置边栏(索引)提示功能
 */
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //判断输入是否边栏消失
    if (self.isSearching == YES){
        return nil;
    }else {
        return self.allkeys;
    }
}

#pragma mark -Section的Header的值
#pragma ---------------
/**
 设置Header提示功能
 */

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.allkeys objectAtIndex:section];
}
/**
 *实现委托方法- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor orangeColor];//设置Header的颜色
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor whiteColor];//设置子母的颜色
    titleLabel.backgroundColor = [UIColor clearColor];//设置字母的边框的颜色
    titleLabel.text=[self.allkeys objectAtIndex:section];
    [myView addSubview:titleLabel];
    
    return myView;
}
/**
 *Header高度
 */
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}
/**
 *  ---searchBar搜索功能---
 */
#pragma searchBar的方法
#pragma --------------
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText{
    /**
     *  获取plist文件的包(路径),访问时每次都调用
     */
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *tmppath = [bundle pathForResource:@"citydict" ofType:@"plist"];
    /**
     *  为字典开辟空间
     */
    self.citiesdict = [[NSDictionary alloc]initWithContentsOfFile:tmppath];
    /**
     *  取出字典的对应元素并传给当前的数组
     */
    self.allkeys = self.citiesdict.allKeys;
    /**
     *  字典排序用的方法
     *  @param compare: 系统自带的方法不用实现<用来比较升序，降序也就是大小>
     */
    self.allkeys = [self.allkeys sortedArrayUsingSelector:@selector(compare:)];
    /**
     *  获得searcher里面用户正在输入的信息(文本)
     */
    NSString *searchstr = self.searchbar.text;
    if (searchstr.length < 1) { // 获取searcherstr的长度,小于1也就是等于0
        [self.searchbar endEditing:YES];
        self.isSearching  = NO;
        return [self.tableView reloadData];
    }else {
        self.isSearching = YES;
    }
    /**
     * 把之前的allkeys备份一下
     */
    NSArray *tmpkeys = [NSArray arrayWithArray:self.allkeys];
    /**
     *  改变当前的allkeys的内容
     */
    self.allkeys =[NSArray arrayWithObject:searchstr];
    /**
     *  把之前的citiesdict备份
     */
    NSDictionary *tmpdict = [NSDictionary dictionaryWithDictionary:self.citiesdict];
    /**
     *  创建一个可变的字典
     */
    self.citiesdict =[[NSMutableDictionary alloc]init];
    /**
     *  创建一个可变的数组
     */
    NSMutableArray *searcharray = [[NSMutableArray alloc]init];
    
    /**
     *  用for in 来遍历查找之前备份的数组
     */
    for (NSString *tmpstr in tmpkeys) {
        NSArray *tmparray = [tmpdict objectForKey:tmpstr];//在之前备份的字典里查找用户输出的字符并返还给新创建的数组
        for (NSString *tmpcityname in tmparray) {
            //如果想知道字符串内的某处是否包含其他的字符串，使用rangeOfString:这个方法
            NSRange tmprange = [tmpcityname rangeOfString:searchstr];
            /**
             * location位置
             * 判断是否相等，不相等返回输出的字符
             */
            if (tmprange.location != NSNotFound) {
                
                [searcharray addObject:tmpcityname];
            }
        }
    }
    /**
     *  更新字典
     */
    [self.citiesdict setValue:searcharray forKey:searchstr];
    /**
     *  会触发上面的方法和协议函数在重新调用一次
     */
    [self.tableView reloadData];
}
/**
 * 让软键盘消失
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchbar endEditing:YES];
}
#pragma -----------通知-----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *页面跳转传值方法：利用notification
     *创建一个通知，在里面放入通知名称和通知所包含的对象(第一步)
     */
    NSInteger tmpsection = indexPath.section;
    NSInteger tmprow = indexPath.row;
    
    NSString *currentsectionname = [self.allkeys objectAtIndex:tmpsection];
    NSArray *tmpcityarray = [self.citiesdict objectForKey:currentsectionname];
   
    NSNotification *notification = [NSNotification notificationWithName:@"changeCityName" object:[tmpcityarray objectAtIndex:tmprow]];
    /**
     * 发送通知(第二步)
     */
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    /**
     * 移除这个界面
     */
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark tableview滑动时收起键盘

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



@end
