//
//  SubscribeViewController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "SubscribeViewController.h"
#import "GkStatus.h"
#import "GkStatusFrame.h"
#import "GkTableViewCell.h"
#import "MJRefresh.h"
#import "GkFavTool.h"
#import "GkFavDbTool.h"
#import "GkWebViewController.h"
#import "MBProgressHUD+MJ.h"
#import "DKNightVersion.h"

#define requestType @"订阅"
@interface SubscribeViewController ()

/*
 Model:DpStatusFrame
 */
@property (strong,nonatomic) NSMutableArray * statusFrameList;

@end

@implementation SubscribeViewController

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
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
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
    NSString * since_id = nil;
    if (self.statusFrameList.count) {//有最新数据
        GkStatus * s = [self.statusFrameList[0] status];
        since_id = s._id;
        NSInteger sinId =[GkFavDbTool GetFavAutoIdWithKey:since_id];
        
        since_id = [NSString stringWithFormat:@"%ld",sinId];
    }
   
    [GkFavTool loadFavDataWithSinceId:since_id success:^(NSArray *statuses) {
        
        //NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 GkStatus -> GkStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (GkStatus *model in statuses) {
            //GkStatus* model = [[GkStatus alloc] initWithDictionary:status];
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

    NSString * max_Id = nil;
    if (self.statusFrameList.count) {//有最新数据
        GkStatus * s = [[self.statusFrameList lastObject] status];
        max_Id = s._id;
        NSInteger maxId =[GkFavDbTool GetFavAutoIdWithKey:max_Id];
        
        max_Id = [NSString stringWithFormat:@"%ld",maxId];
    }
   
    [GkFavTool loadFavDataWithMaxId:max_Id success:^(NSArray *statuses) {        
        //NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 GkStatus -> GkStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (GkStatus *model in statuses) {
           // GkStatus* model = [[GkStatus alloc] initWithDictionary:status];
            GkStatusFrame *statusF = [[GkStatusFrame alloc] init];
            statusF.status = model;
            [statusFrames addObject:statusF];
        }
        
        
        [self.statusFrameList addObjectsFromArray:statusFrames];
        
        //NSInteger nextPage  = [current integerValue]+1;
        
       // [GkUserDefaults setObject:[NSString stringWithFormat:@"%ld",nextPage] forKey:[NSString stringWithFormat:@"currentPage_%@",requestType]];
        
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
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
