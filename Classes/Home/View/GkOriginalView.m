//
//  GkOriginalView.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/21.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkOriginalView.h"

#import "GkStatusFrame.h"
#import "GkStatus.h"
#import "UIImageView+WebCache.h"
#import "CommonTool.h"
@interface GkOriginalView()

/**
 *  文章title
 */
@property (weak,nonatomic) UILabel * titleView;

/**
 *  文章来源
 */
@property (weak,nonatomic) UILabel * sourceView;

/**
 *  头像
 */
@property (weak,nonatomic) UIImageView * iconView;

/**
 *  时间
 */
@property (weak,nonatomic) UILabel * timeView;

/**
 *  妹子
 */
@property (weak,nonatomic) UIImageView * girlView;

/**
 *  类型
 */
@property (weak,nonatomic) UILabel * typeView;

@end

@implementation GkOriginalView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
         self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

#pragma mark - 添加子控件
-(void)setUpAllChildView
{
    //title
    UILabel * titleView = [[UILabel alloc] init];
    _titleView = titleView;
    titleView.font = GkTextFont;
    titleView.numberOfLines = 0;//多行
    [self addSubview:titleView];
    
    //source
    UILabel * sourceView = [[UILabel alloc] init];
    _sourceView =sourceView;
    _sourceView.font = [UIFont systemFontOfSize:12];
    _sourceView.textColor = [UIColor darkGrayColor];
    [self addSubview:_sourceView];
    
    
    //image
    UIImageView * iconView = [[UIImageView alloc] init];
    _iconView = iconView;
    [self addSubview:_iconView];
    
    UILabel * typeView = [[UILabel alloc] init];
    typeView.font  =[UIFont systemFontOfSize:12];
    typeView.textColor = nativeColor;
    _typeView = typeView;
    [self addSubview:_typeView];
    
    //time
    UILabel * timeView = [[UILabel alloc] init];
    _timeView = timeView;
    _timeView.font = [UIFont systemFontOfSize:13];
    _timeView.textColor = [UIColor darkGrayColor];
    [self addSubview:_timeView];
    
    //girl
    UIImageView * girlView = [[UIImageView alloc] init];
    _girlView = girlView;
    [self addSubview:_girlView];
    
}

-(void)setStatusFrame:(GkStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    _titleView.frame = _statusFrame.titleFrame;
    _titleView.text = _statusFrame.status.desc;
    
    _sourceView.frame = _statusFrame.socureFrame;
    _sourceView.text = [NSString stringWithFormat:@"选自 %@",_statusFrame.status.who];
    
    _iconView.frame = _statusFrame.iconFrame;
    NSString * type = _statusFrame.status.type;
    if ([type isEqualToString:@"Android"]) {
        _iconView.image = [UIImage imageNamed:@"android"];
    }else if ([type isEqualToString:@"App"]) {
        _iconView.image = [UIImage imageNamed:@"app"];
    }else if ([type isEqualToString:@"iOS"]) {
        _iconView.image = [UIImage imageNamed:@"ios"];
    }else if ([type isEqualToString:@"前端"]) {
        _iconView.image = [UIImage imageNamed:@"js"];
    }else if ([type isEqualToString:@"福利"]) {
        _iconView.image = [UIImage imageNamed:@"girls"];
    }else if ([type isEqualToString:@"拓展资源"]) {
        _iconView.image = [UIImage imageNamed:@"expand"];
    }else if([type isEqualToString:@"休息视频"]){
         _iconView.image = [UIImage imageNamed:@"fun"];
    }else{
        _iconView.image = [UIImage imageNamed:@"others"];
    }
    _iconView.layer.cornerRadius = _statusFrame.iconFrame.size.width/2;
    _iconView.layer.masksToBounds = YES;
  
    _typeView.frame = _statusFrame.typeFrame;
    _typeView.text = _statusFrame.status.type;
    
    _girlView.frame = _statusFrame.girlFrame;
    [_girlView sd_setImageWithURL:[NSURL URLWithString:[_statusFrame.status.url stringByReplacingOccurrencesOfString:@"large" withString:@"bmiddle"]]];
    
    _timeView.frame =  _statusFrame.timeFrame;
    _timeView.text =[CommonTool getStrWithValue:_statusFrame.status.publishedAt Fomatter:@"yyyyMMdd"];
    
}
@end
