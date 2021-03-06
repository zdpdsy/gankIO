//
//  GkHomeViewController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkHomeViewController.h"
#import "GkStatusTool.h"
#import "MBProgressHUD+MJ.h"
#import "GkTableViewCell.h"
#import "GkStatus.h"
#import "GkStatusFrame.h"
#import "GkWebViewController.h"
#import "GkNavgationController.h"
#import "MJRefresh.h"
#import "GkFavDbTool.h"
#import "DKNightVersion.h"


#import "UIBarButtonItem+Item.h"
@interface GkHomeViewController ()
/*
 Model:DpStatusFrame
 */
@property (strong,nonatomic) NSMutableArray * statusFrameList;
@end

@implementation GkHomeViewController

-(instancetype)initWithType:(NSString *)requestType titleName:(NSString *)titleName
{
    _requestType = requestType;
    _titleName  = titleName;
    if (self = [super init]) {
        
    }
    return self;
}

//懒加载
-(NSMutableArray *)statusFrameList
{
    if (!_statusFrameList) {
        _statusFrameList = [NSMutableArray array];
    }
    return _statusFrameList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.backgroundColor =[UIColor blackColor];
    //self.tableView.backgroundColor = [UIColor colorWithRed:211/225.0  green:211/225.0 blue:211/225.0 alpha:1];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    //去掉tableview自带的分割线
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    //添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    //开始自动刷新
    [self.tableView headerBeginRefreshing];
    
    //添加上拉加载更多控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    [self refresh];
    
    [self setUpNavgationBar];
    // Do any additional setup after loading the view.
}
-(void)setUpNavgationBar
{
    //common_nav_icon_navigation
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"common_nav_icon_navigation"  target:(GkNavgationController *)self.navigationController action:@selector(showMenu)];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新最新的微博
- (void)refresh{
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 上下加载更多下拉刷新
/**
 *  下拉刷新
 */
-(void) loadNewStatus
{
    
    NSString * pageIndex = @"1";
    
    [GkStatusTool loadStatusWithType:_requestType pageIndex:pageIndex success:^(NSArray *statuses) {
       
        //NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 GkStatus -> GkStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (NSDictionary *status in statuses) {
            GkStatus* model = [[GkStatus alloc] initWithDictionary:status];
            GkStatusFrame *statusF = [[GkStatusFrame alloc] init];
            statusF.status = model;
            [statusFrames addObject:statusF];
        }
               
        //吧数据加到最前面
        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
         [self.statusFrameList insertObjects:statusFrames atIndexes:indexSet];
        
        //重新加载
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //停止下拉刷新控件
        [self.tableView headerEndRefreshing];
        [MBProgressHUD showError:@"啊哦，鹏哥加载不出来新数据，sorry"];
        NSLog(@"error ,msg = %@",error);
    }];
}

//拉上加载以前的
-(void)loadMoreStatus{
    NSString *current= @"2";
    NSString * old =[GkUserDefaults objectForKey:[NSString stringWithFormat:@"currentPage_%@",_requestType]];
    
    if (old.length>0) {
        current = old;
    }
    [GkStatusTool loadStatusWithType:_requestType pageIndex:current  success:^(NSArray *statuses) {
        
        //NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 GkStatus -> GkStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (NSDictionary *status in statuses) {
            GkStatus* model = [[GkStatus alloc] initWithDictionary:status];
            GkStatusFrame *statusF = [[GkStatusFrame alloc] init];
            statusF.status = model;
            [statusFrames addObject:statusF];
        }
        
        
        [self.statusFrameList addObjectsFromArray:statusFrames];
        
        NSInteger nextPage  = [current integerValue]+1;
        
        [GkUserDefaults setObject:[NSString stringWithFormat:@"%ld",nextPage] forKey:[NSString stringWithFormat:@"currentPage_%@",_requestType]];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //重新加载
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //停止下拉刷新控件
        [self.tableView footerEndRefreshing];
        [MBProgressHUD showError:@"啊哦，鹏哥加载不出来旧数据，sorry"];
        NSLog(@"error ,msg = %@",error);
    }];
}

#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrameList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前model
    GkStatusFrame * cellFrame = self.statusFrameList[indexPath.row];
    GkTableViewCell * cell = [GkTableViewCell cellWithTableView:tableView];
    cell.statusFrame = cellFrame;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     GkStatusFrame * cellFrame = self.statusFrameList[indexPath.row];
    return cellFrame.cellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GkStatusFrame * cellFrame = self.statusFrameList[indexPath.row];
    GkWebViewController * webView = [[GkWebViewController alloc] init];
    webView.status = cellFrame.status;
    NSInteger isFav = [GkFavDbTool GetFavStatusWithKey:cellFrame.status._id];
    webView.isFav = isFav;
    [self.navigationController pushViewController:webView animated:YES];
}
@end
