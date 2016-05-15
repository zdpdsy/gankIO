//
//  GkProfileController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkProfileController.h"
#import "DKNightVersion.h"
#import "UIImageView+WebCache.h"
@interface GkProfileController ()

/**
 *  夜间模式
 */
@property (nonatomic, weak) UISwitch *changeSkinSwitch;

/**
 *  摇一摇模式
 */
@property (nonatomic, weak) UISwitch *shakeCanChangeSkinSwitch;

@property (assign,nonatomic) CGFloat cacheSize;

@end

CGFloat const footViewHeight = 30;

@implementation GkProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self caculateCacheSize];
}
#pragma mark - 计算缓存
-(void)caculateCacheSize {
    float imageCache = [[SDImageCache sharedImageCache] getSize];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接路径
    NSString * filePath = [cachePath stringByAppendingPathComponent:@"status.db"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float sqliteCache = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
    self.cacheSize = imageCache + sqliteCache;
}

#pragma mark - 夜间模式
- (void)night {
    self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)normal {
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)switchColor {
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [self.dk_manager dawnComing];
    } else {
        [self.dk_manager nightFalling];
    }
}

#pragma mark -uitableView方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return footViewHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 100;
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footViewHeight);
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
    [footView addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.frame = CGRectMake(0, footViewHeight - 1, [UIScreen mainScreen].bounds.size.width, 1);
    [footView addSubview:lineView2];
    
    footView.dk_backgroundColorPicker =DKColorPickerWithKey(BG);
    lineView1.backgroundColor =  GkColor(242, 242, 245);
     lineView2.backgroundColor = GkColor(242, 242, 245);
    if (section==2) {
        [lineView2 removeFromSuperview];
    }
    return footView;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * reuserId =@"GkProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuserId];
    }
    if(indexPath.section == 0) {
        CGFloat cellHeight = 100;
        CGFloat margin = 10;
        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
        [cell addSubview:lineView];
        
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.frame =CGRectMake(margin, margin, cellHeight - 2*margin, cellHeight - 2*margin);
        avatarImageView.image = [UIImage imageNamed:@"img_headportrait_normal_bak"];
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width * 0.5;
        avatarImageView.layer.masksToBounds = YES;
        [cell addSubview:avatarImageView];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        CGFloat nameLabelHeight = 21.5;
        nameLabel.text = @"干货";
        nameLabel.font = [UIFont systemFontOfSize:18];
        
        nameLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + margin, avatarImageView.frame.origin.y +avatarImageView.frame.size.height*0.5 - nameLabelHeight-0.5*margin, kScreenWidth - 3*margin -avatarImageView.frame.size.width, nameLabelHeight);
        [cell addSubview:nameLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        CGFloat contentLabelHeight = 17.5;
        contentLabel.text =@"这家伙很懒,什么也没留下";
        
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + margin, avatarImageView.frame.origin.y +avatarImageView.frame.size.height*0.5+0.5*margin, kScreenWidth - 3*margin -avatarImageView.frame.size.width, contentLabelHeight);
        contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [cell addSubview:contentLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"夜间模式";
            if (cell.accessoryView == nil) {
                UISwitch *changeSkinSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
                self.changeSkinSwitch = changeSkinSwitch;
                [changeSkinSwitch addTarget:self action:@selector(switchColor) forControlEvents:UIControlEventValueChanged];
                
                cell.accessoryView = changeSkinSwitch;
            }
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"清除缓存";
            CGFloat fileSize= self.cacheSize/1024.0;
           NSString * detailText =[NSString stringWithFormat:@"%.fKB",fileSize];
            
            if (fileSize >1024){
                fileSize =  fileSize/1024.0;
                detailText= [NSString stringWithFormat:@"%.1fM",fileSize];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f MB",fileSize];
        }
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    cell.dk_backgroundColorPicker =DKColorPickerWithKey(BG);
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma makr - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
