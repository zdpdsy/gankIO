//
//  GkTableViewCell.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkTableViewCell.h"
#import "GkStatusFrame.h"
#import "GkStatus.h"

#import "GkOriginalView.h"
@interface GkTableViewCell()



/**
 *
 */
@property (weak,nonatomic) GkOriginalView * originalView;

@end

@implementation GkTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * reuseId =@"cell";
    
    id cell =[tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        
    }
    return cell;
}

#pragma mark - 添加子控件
-(void)setUpAllChildView
{
    GkOriginalView * originalView = [[GkOriginalView alloc] init];
    _originalView = originalView;
    [self addSubview:_originalView];
    
}

#pragma mark - 计算frame

-(void)setStatusFrame:(GkStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    _originalView.frame = _statusFrame.originialFrame;
    _originalView.statusFrame = statusFrame;
}

@end
