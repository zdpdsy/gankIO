//
//  GkLeftMenuControlller.m
//  gankIO
//
//  Created by 曾大鹏 on 16/5/3.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkLeftMenuControlller.h"
#import "MenuViewCell.h"
#import "GkTabBarController.h"
#import "REFrostedViewController.h"
#import "UIViewController+REFrostedViewController.h"
@interface GkLeftMenuControlller ()

@end

@implementation GkLeftMenuControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 28, 25, 25)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"news_toolbar_icon_back"];

        [imageView addGestureRecognizer:singleFingerOne];
        [view addSubview:imageView];
        view;
    });

}
- (void)back {
    [self.frostedViewController hideMenuViewController];
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Android | iOS | 休息视频 | 福利 | 拓展资源 | 前端 | 瞎推荐 | App
    NSArray *titles = @[@"全部", @"福利",@"Android", @"iOS",@"休息视频", @"拓展资源", @"前端",@"瞎推荐",@"App"];
    NSArray *viewColor = @[@"#000000",@"#52AC41",@"#47B1E7",@"#2B88F5",@"#0045CA",@"#D6253A",@"#DF7515",@"#D62846",@"#D62846"];
    MenuViewCell *cell = [MenuViewCell cellWithTableView:tableView viewColor:viewColor[indexPath.row] nameLabel:titles[indexPath.row]];
   
    
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GkTabBarController *tabBar;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *titles = @[@"全部", @"福利",@"Android", @"iOS",@"休息视频", @"拓展资源", @"前端",@"瞎推荐",@"App"];
    
    tabBar = [[GkTabBarController alloc] initWithType:titles[indexPath.row] titleName:titles[indexPath.row]];
    
    self.frostedViewController.contentViewController = tabBar;
    [self.frostedViewController hideMenuViewController];

}
@end
