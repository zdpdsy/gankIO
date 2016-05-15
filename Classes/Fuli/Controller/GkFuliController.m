//
//  GkFuliController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkFuliController.h"

#import "GkFuliCollectionViewCell.h"

#import "GkStatusTool.h"
#import "GkStatus.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "DKNightVersion.h"
@interface GkFuliController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView * collectionV;

@property (strong,nonatomic) NSMutableArray * dataList;
@end

@implementation GkFuliController

//懒加载
-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    //self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self setUpCollectionView];
    
    //添加下拉刷新控件
    [self.collectionV addHeaderWithTarget:self action:@selector(loadNewStatus)];
    //开始自动刷新
    [self.collectionV headerBeginRefreshing];    
    //添加上拉加载更多控件
    [self.collectionV addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma mark - 下拉刷新 上拉加载更多
- (void)refresh{
    
    // 自动下拉刷新
    [self.collectionV headerBeginRefreshing];
    
}

/**
 *  下拉刷新
 */
-(void) loadNewStatus
{
    
    NSString * pageIndex = @"1";
    
    [GkStatusTool loadStatusWithType:@"福利" pageIndex:pageIndex success:^(NSArray *statuses) {
        
       // NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.collectionV headerEndRefreshing];
        
        //吧数据加到最前面
        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.dataList insertObjects:statuses atIndexes:indexSet];
        
        //重新加载
        [self.collectionV reloadData];
    } failure:^(NSError *error) {
        //停止下拉刷新控件
        //[self.tableView headerEndRefreshing];
        [MBProgressHUD showError:@"啊哦，鹏哥加载不出来新数据，sorry"];
        [self.collectionV headerEndRefreshing];

        NSLog(@"error ,msg = %@",error);
    }];
}

//拉上加载以前的
-(void)loadMoreStatus{
    NSString *current= @"2";
    NSString * old =[GkUserDefaults objectForKey:[NSString stringWithFormat:@"currentPage_%@",@"福利"]];
    
    if (old.length>0) {
        current = old;
    }
    [GkStatusTool loadStatusWithType:@"福利" pageIndex:current  success:^(NSArray *statuses) {
        
        //NSLog(@"%@",statuses);
        //停止下拉刷新控件
        [self.collectionV footerEndRefreshing];
        
        [self.dataList addObjectsFromArray:statuses];

        NSInteger nextPage  = [current integerValue]+1;
        
        [GkUserDefaults setObject:[NSString stringWithFormat:@"%ld",nextPage] forKey:[NSString stringWithFormat:@"currentPage_%@",@"福利"]];
        
        [GkUserDefaults synchronize];
        
        //重新加载
        [self.collectionV reloadData];
    } failure:^(NSError *error) {
        //停止下拉刷新控件
        [self.collectionV footerEndRefreshing];
        [MBProgressHUD showError:@"啊哦，鹏哥加载不出来旧数据，sorry"];
        NSLog(@"error ,msg = %@",error);
    }];
}

#pragma mark - 设置collectionView
-(void)setUpCollectionView{
    
    //1.设置布局
    UICollectionViewFlowLayout * layout  = [[UICollectionViewFlowLayout alloc] init];
    
    //itemSize
    layout.itemSize = CGSizeMake((GkSreenW-4*GkCellStatusMargin)/3, 200);
    
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(GkCellStatusMargin, GkCellStatusMargin, GkCellStatusMargin, GkCellStatusMargin);

    //设置item最小列间距
    layout.minimumInteritemSpacing = GkCellStatusMargin;
    layout.minimumLineSpacing =GkCellStatusMargin;
  
    
    //创建collectionView
    UICollectionView * collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, GkSreenW, GkSreenH) collectionViewLayout:layout];
    
    //设置代理
    collectionV.delegate= self;
    collectionV.dataSource = self;

    [collectionV registerClass:[GkFuliCollectionViewCell class] forCellWithReuseIdentifier:@"MainCell"];
   // collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    _collectionV = collectionV;
    [self.view addSubview:_collectionV];
}

#pragma mark - UICollectionView的代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GkFuliCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    NSDictionary * dict =  self.dataList[indexPath.row];
    GkStatus * model = [[GkStatus alloc] initWithDictionary:dict];
    NSString * middleUrl = [model.url stringByReplacingOccurrencesOfString:@"large" withString:@"bmiddle"];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:middleUrl]];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //http://ww3.sinaimg.cn/large/7a8aed7bjw1f2h04lir85j20fa0mx784.jpg
   
    GkFuliCollectionViewCell * cell = (GkFuliCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    NSMutableArray * arrM =[NSMutableArray array];
    int k=0;
    
    //GkStatus 转MJPhoto
    for (NSDictionary * photoDic in self.dataList) {
        /*
         @property (nonatomic, strong) NSURL *url;
         @property (nonatomic, strong) UIImage *image; // 完整的图片
         
         @property (nonatomic, strong) UIImageView *srcImageView; // 来源view
         */
        GkStatus * model = [[GkStatus alloc] initWithDictionary:photoDic];

        MJPhoto * mphoto = [[MJPhoto alloc] init];
        NSString * photostr = model.url;
        //高清图片路径
        photostr = [photostr stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        mphoto.url  = [NSURL URLWithString:photostr];
        
        mphoto.srcImageView =cell.imageV;
        mphoto.index =k;
        [arrM addObject:mphoto];
        k++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser * browser = [[MJPhotoBrowser alloc] init];
    browser.photos = arrM;
    browser.currentPhotoIndex = indexPath.row;
    [browser show];
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
