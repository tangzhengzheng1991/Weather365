//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "addCityViewController.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate* appDelegate;
}


@end

@implementation LeftSortsViewController


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview  = [[UITableView alloc] init];
    _tableview.frame = CGRectMake(0, 0, DD_WIDTH-50, DD_HEIGHT);
    _tableview.dataSource = self;
    _tableview.delegate  = self;
    
    
    //分割线类型
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    _tableview.separatorColor = [UIColor orangeColor];
    
    [self.view addSubview:_tableview];
    self.imageArray=@[[UIImage imageNamed:@"00"],[UIImage imageNamed:@"00"],[UIImage imageNamed:@"00"],[UIImage imageNamed:@"00"]];
    

    if (_hisDatas == nil) {
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"上海", nil];
            [_hisDatas writeToFile:SearchHistoryPath atomically:YES];
            
        }
    }

    
    
//    self.titleArray =@[@"我的交易",@"身份认证",@"一键客服",@"设置"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.navigationItem.hidesBackButton = YES;

#pragma mark --占位按钮
    UIButton *nullButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nullButton.frame=CGRectMake(0, 0, 40, 26);
//    [addbutton addTarget:self action:@selector(addCity) forControlEvents:UIControlEventTouchUpInside];
    [nullButton setBackgroundImage:[UIImage imageNamed:@"addCity44444"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:nullButton];
    
#pragma mark -- 添加常用城市
    UIButton *addbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame=CGRectMake(0, 0, 26, 26);
    [addbutton addTarget:self action:@selector(addCity) forControlEvents:UIControlEventTouchUpInside];
    [addbutton setBackgroundImage:[UIImage imageNamed:@"addCity"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:addbutton];
    
    self.navigationItem.rightBarButtonItems = @[right1,right2];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.title = @"编辑";
    
    
    
    
}

-(void)addCity{
    NSLog(@"查询可用城市天气跳转");
    addCityViewController *vc=[[addCityViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
-(void)refresh{
    _hisDatas = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];

    [self.tableview reloadData];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_hisDatas.count);
    return _hisDatas.count;
    
}
#pragma mark - Table view delegate  每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DD_WIDTH==414) {
        return 64;
    }else if (DD_WIDTH==375){
        return 54;
    }else{
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }

    
    
//    cell.selectionStyle=UITableViewCellEditingStyleNone;
    NSLog(@"_hisDatas%@",_hisDatas);
    cell.textLabel.text=_hisDatas[indexPath.row];
    
    //设置先前选择城市的cell为的选中状态
    if ([_hisDatas[indexPath.row] isEqualToString:[NSString stringWithFormat:@"%@",[USER_D objectForKey:@"previouslySelectedCities"]]]) {
        
        NSInteger i=[_hisDatas indexOfObject:[USER_D objectForKey:@"previouslySelectedCities"]];
        NSIndexPath *fistPath = [NSIndexPath indexPathForRow:i inSection:0];
        [_tableview selectRowAtIndexPath:fistPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [NOTI_CENTENT postNotificationName:@"selectAddress" object:_hisDatas[indexPath.row]];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark--允许编辑

//允许编辑  如果设置为NO 将不能删除移动等，无法侧拉出“删除”按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


//////开始编辑时调用的两个方法
////- ( void )tableView:( UITableView *)tableView willBeginEditingRowAtIndexPath:( NSIndexPath *)indexPath{
////    
////}
//////完成 编辑时调用的两个方法
////- ( void )tableView:( UITableView *)tableView didEndEditingRowAtIndexPath:( NSIndexPath *)indexPath{
////    
////}

#pragma mark-- 移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES; //可以移动
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath   toIndexPath:(NSIndexPath *)toIndexPath {
//    NSLog(@"%@===",_datas);
    NSUInteger fromRow = [fromIndexPath row];  //要移动的那个cell integer
    NSUInteger toRow = [toIndexPath row]; //要移动位置的那个clell integer
    //arrayValue 添加数据的那个可变数组
    id object = [_hisDatas objectAtIndex:fromRow]; // 获取数据
    [_hisDatas removeObjectAtIndex:fromRow];  //在当前位置删除
    [_hisDatas insertObject:object atIndex:toRow]; //插入的位置
    [_hisDatas writeToFile:SearchHistoryPath atomically:YES];
    [NOTI_CENTENT postNotificationName:@"EditComplete" object:@"页面更改"];
    
    [self.tableview reloadData];
    
    
}


#pragma mark--  删除 

//指定编辑模式，插入，删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单插入
    //    return UITableViewCellEditingStyleInsert ;
    //多选删除
//        return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
//    return UITableViewCellEditingStyleNone || UITableViewCellEditingStyleDelete;
    
//    return    UITableViewCellEditingStyleNone; // 不编辑
    return UITableViewCellEditingStyleDelete;
}

#pragma mark-- 更改删除按钮上的文本
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删掉我吧";
}

#pragma mark--  点击删除调用的方法
//触发编辑方法；根据editingStyle来判断时那种类型  //
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"点击删除调用的方法");
    //删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSLog(@"点击删除调用的方法");
        
        if ([_hisDatas count]==1) {
            SHOW_ALERT(@"无法删除,请至少保留一个城市")
        } else {
            //先从数组删除
            [_hisDatas removeObjectAtIndex:indexPath.row];
            
            //再从表格删除
            //删除行，可以单行，也可以多行
            [_hisDatas writeToFile:SearchHistoryPath atomically:YES];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_tableview reloadData];
            
            [NOTI_CENTENT postNotificationName:@"EditComplete" object:@"页面更改"];

        }
        
        
        
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //先插入数组
        //        [_tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}






#pragma mark--  点击编辑按钮
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{ [super setEditing:editing animated:animated];
    // Don't show the Back button while editing.
//    [self.navigationItem setHidesBackButton:editing animated:YES];
    if (editing)
    {
       
        [_tableview setEditing:YES animated:YES];
        
        self.navigationItem.leftBarButtonItem.title = @"完成";
        //编辑完成后发通知给天气预报页面,刷新页面
        
        [NOTI_CENTENT postNotificationName:@"EditComplete" object:@"页面更改"];
        
        
        
    }else {
        [_tableview setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
}











@end
