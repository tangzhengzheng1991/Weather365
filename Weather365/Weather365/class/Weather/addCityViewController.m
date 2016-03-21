//
//  addCityViewController.m
//  HowFarToGo
//
//  Created by tangzhengzheng on 16/2/23.
//  Copyright © 2016年 TianDiHuaYu. All rights reserved.
//

#import "addCityViewController.h"
#import "ChineseString.h"
#import "pinyin.h"
#import "AppDelegate.h"

@interface addCityViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_provinceArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_countyArr;
    NSString *_flagString;
    NSMutableArray *areaIdArr;
}
/**   城市列表数组 */
@property (nonatomic,strong) NSMutableArray *cityArray;
///** 历史搜索数据 */
//@property (nonatomic, strong) NSMutableArray *hisDatas;
@end

@implementation addCityViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64,DD_WIDTH, DD_HEIGHT-70) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self; //代理
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *cancelbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelbutton.frame=CGRectMake(30, 30, 30, 30);
    [cancelbutton addTarget:self action:@selector(cancelMethod) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.view addSubview:cancelbutton ];
    
    
    _provinceArr=[NSMutableArray arrayWithObjects:@"北京市",@"天津市",@"上海市",@"重庆市",@"河北省",@"山西省",@"陕西省",@"山东省 ",@"河南省",@"辽宁省",@"吉林省",@"黑龙江省 ",@"江苏省",@"浙江省",@"安徽省",@"江西省",@"福建省",@"湖北省",@"湖南省",@"四川省",@"贵州省",@"云南省",@"广东省",@"海南省",@"甘肃省",@"青海省",@"台湾省",@"内蒙古自治区",@"新疆维吾尔自治区",@"西藏自治区",@"广西壮族自治区",@"宁夏回族自治区 ",@"香港特别行政区",@"澳门特别行政区", nil];
    _provinceArr=[self ChineseArrayToSort:_provinceArr];
    
    self.cityArray=[[NSMutableArray alloc] init];
    _flagString=@"查询市区";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [NOTI_CENTENT removeObserver:self];
}
-(void)cancelMethod{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Table view data source 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - Table view data source  每组分几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_provinceArr count];
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
    return 44;
}


#pragma mark - Table view delegate  cell选中后
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *city=[[_provinceArr[indexPath.row] stringByReplacingOccurrencesOfString:@"市" withString:@""] stringByReplacingOccurrencesOfString:@"省" withString:@""];
    NSRange range=[city rangeOfString:@"区"];
    if (!(range.location == NSNotFound)) {
        if ([city isEqualToString:@"内蒙古自治区"]) {
            city=@"内蒙古";
        }else{
            city=[city substringToIndex:2];
        }
    }
    
    if ([_flagString isEqualToString:@"查询市区"]) {
        [self requestCityList:city];
        _flagString=@"查询县区";
    } else if([_flagString isEqualToString:@"查询县区"]){
        [self requestCountyList:city];
        _flagString=@"最终选择的地区";
    }else{
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        NSLog(@"查询的 县区");

        
        [NOTI_CENTENT postNotificationName:@"selectAddress" object:city];

        
        [tempAppDelegate.leftVC refresh];
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        //        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer0=@"cell0";
    UITableViewCell *cell0=[tableView dequeueReusableCellWithIdentifier:cellIdentifer0];
    if (cell0==nil) {
        cell0=[[UITableViewCell alloc] init];
    }
    if ([_flagString isEqualToString:@"最终选择的地区"]) {
        
    } else {
        cell0.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    cell0.textLabel.text=_provinceArr[indexPath.row];
    return cell0;
    
}


#pragma mark--数组排序
-(NSMutableArray *)ChineseArrayToSort :(NSArray *)stringsArrayToSort{
    
    
    //    NSArray *stringsArrayToSort=_provinceArr;
    
    //Step1输出
    //    NSLog(@"尚未排序的NSString数组:");
    //    for(int i=0;i<[stringsArrayToSort count];i++){
    //        NSLog(@"%@",[stringsArrayToSort objectAtIndex:i]);
    //    }
    
    
    
    //Step2:获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringsArrayToSort count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string=[NSString stringWithString:[stringsArrayToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin=pinYinResult;
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    
    
    //Step2输出
    //    NSLog(@"\n\n\n转换为拼音首字母后的NSString数组");
    //    for(int i=0;i<[chineseStringsArray count];i++){
    //        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
    //        NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
    //    }
    
    
    
    //Step3:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    //    //Step3输出
    //    NSLog(@"\n\n\n按照拼音首字母后的NSString数组");
    //    for(int i=0;i<[chineseStringsArray count];i++){
    //        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
    //        NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
    //    }
    
    // Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[chineseStringsArray count];i++){
        [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
    }
    
    //    //Step4输出
    //    NSLog(@"\n\n\n最终结果:");
    //    for(int i=0;i<[result count];i++){
    //        NSLog(@"%@",[result objectAtIndex:i]);
    //    }
    
    //程序结束
    
    //    NSLog(@"\n\n\nDemo By Hxy060799");
    
    
    return result;
}





//查询可用城市列表
-(void)requestCityList:(NSString *)cityName{
    
    NSString *cityNameUTF8=[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//转换成UTF8编码
    
    NSLog(@"cityNameUTF8%@",cityNameUTF8);
    //    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityinfo";
    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/citylist";
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@?cityname=%@",url,cityNameUTF8];
    [self.cityArray removeAllObjects];
    
    [DDHTTPManger GET:urlStr completionBlock:^(NSDictionary *dictionary){
        NSLog(@"dictionary%@",dictionary);
        NSArray *arr=[dictionary objectForKey:@"retData"];
        _cityArr=[[NSMutableArray alloc] init];
        
        for (int i=0; i<arr.count; i++) {
            NSString *district=[arr[i] objectForKey:@"district_cn"];
            
            if (![_cityArr containsObject:district]) {
                [_cityArr addObject:district];
            }
        }
        NSLog(@"市区=======%@",_cityArr);
        _cityArr=[self ChineseArrayToSort:_cityArr];
        NSLog(@"市区=======%@",_cityArr);
        
        _provinceArr=_cityArr;
        [_tableView reloadData];
        
        //        CityListBaseClass *cityList=[CityListBaseClass modelObjectWithDictionary:dictionary];
        //
        //        for (CityListRetData *mode in cityList.retData) {
        //            [self.cityArray addObject:mode];
        //        }
        
        
    }];
    
    
    
    
}






//查询城市包含的区的列表
-(void)requestCountyList:(NSString *)cityName{
    NSString *cityNameUTF8=[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//转换成UTF8编码
    
    NSLog(@"cityNameUTF8%@",cityNameUTF8);
    //    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/cityinfo";
    NSString *url=@"http://apis.baidu.com/apistore/weatherservice/citylist";
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@?cityname=%@",url,cityNameUTF8];
    [self.cityArray removeAllObjects];
    
    [DDHTTPManger GET:urlStr completionBlock:^(NSDictionary *dictionary){
        NSLog(@"dictionary%@",dictionary);
        NSArray *arr=[dictionary objectForKey:@"retData"];
        _cityArr=[[NSMutableArray alloc] init];
        
        for (int i=0; i<arr.count; i++) {
            NSString *district=[arr[i] objectForKey:@"name_cn"];
            
            if (![_cityArr containsObject:district]) {
                [_cityArr addObject:district];
            }
        }
        
        
//        NSLog(@"市区=======%@",_cityArr);
        _cityArr=[self ChineseArrayToSort:_cityArr];
//        NSLog(@"市区=======%@",_cityArr);
        
        _provinceArr=_cityArr;
        [_tableView reloadData];
        
        //        CityListBaseClass *cityList=[CityListBaseClass modelObjectWithDictionary:dictionary];
        //
        //        for (CityListRetData *mode in cityList.retData) {
        //            [self.cityArray addObject:mode];
        //        }
        
        
    }];
    
    
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
