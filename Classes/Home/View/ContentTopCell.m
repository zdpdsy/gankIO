//
//  ContentTopCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "ContentTopCell.h"
#import  "UIImageView+WebCache.h"
#import "GkStatus.h"
#import "GkFavDbTool.h"

@interface ContentTopCell ()

@property (weak, nonatomic)  UILabel *descLabel;

@property (weak, nonatomic)  UILabel *sourceLabel;
@property (weak, nonatomic)  UIView *seperatView;

@property (weak, nonatomic)  UILabel *summaryLabel;

@property (weak, nonatomic)  UIButton *FavBtn;

@property (weak,nonatomic) UIImageView * iconView;


@end


@implementation ContentTopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpAllChildView];
    }
    return self;
}

-(void)setUpAllChildView{
    
    //icon
    CGFloat iconX = GkCellStatusMargin;
    CGFloat iconY =4;
    CGFloat iconWH=40;
    
    UIImageView * iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    iconView.image = [UIImage imageNamed:@"img_headportrait_normal"];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = iconView.frame.size.width / 2;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    //desc
    CGFloat descX = CGRectGetMaxX(iconView.frame)+GkCellStatusMargin;
    CGFloat descY = iconY;
    CGFloat descW = 40;
    CGFloat descH =19;
    UILabel * descLabel = [[UILabel alloc] init];
    descLabel.font =[UIFont systemFontOfSize:12];
    descLabel.textColor = [UIColor darkGrayColor];
    descLabel.frame = CGRectMake(descX, descY, descW, descH);
    [self addSubview:descLabel];
    self.descLabel = descLabel;
    
    //source
    CGFloat sourceX = CGRectGetMaxX(descLabel.frame)+GkCellStatusMargin/2;
    CGFloat sourceY = iconY;
    CGFloat sourceW = 80;
    CGFloat sourceH =19;
    UILabel * sourceLabel = [[UILabel alloc] init];
    sourceLabel.font =[UIFont systemFontOfSize:12];
    sourceLabel.textColor = nativeColor;
    sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    //summary
    CGFloat summaryX = descX;
    CGFloat summaryY = CGRectGetMaxY(descLabel.frame)+GkCellStatusMargin;
    CGFloat summaryW = 250;
    CGFloat summaryH =19;
    UILabel * summaryLabel = [[UILabel alloc] init];
    summaryLabel.font =[UIFont systemFontOfSize:12];
    summaryLabel.textColor = nativeColor;
    summaryLabel.frame = CGRectMake(summaryX, summaryY, summaryW, summaryH);
    [self addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;

    
    //author
    UIView * sView = [[UIView alloc] init];
    sView.frame = CGRectMake(0, CGRectGetMaxY(summaryLabel.frame)-2, GkSreenW, 1);
    sView.backgroundColor = GkColor(242, 242, 245);
    [self addSubview:sView];
    self.seperatView = sView;
    
    //favBtn
    CGFloat btnH =25;
    CGFloat btnW = 60;
    CGFloat btnY = (self.bounds.size.height-btnH)/2;
    CGFloat btnX = GkSreenW - btnW-20;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (_isFav==0) {
        [btn setTitle:@"订阅" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:nativeColor];
    }else{
        [btn setTitle:@"已订阅" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor blackColor]];
        [btn setBackgroundColor: GkColor(242, 242, 245)];
    }
   
    [btn addTarget:self action:@selector(clickBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btn.tag = _isFav;
    [self addSubview:btn];
    self.FavBtn = btn;
    
    
}

//点击事件
-(void)clickBtnEvent:(UIButton *)favBtn{
    
   // NSString * key = status._id;
    if ([self.delegate respondsToSelector:@selector(didFavBtnClick)]) {
        GkLog(@"执行代理事件");
        [self.delegate didFavBtnClick];
        
        NSInteger Fav = 1-favBtn.tag;
        if (Fav ==1) {
            [favBtn setTitle:@"已订阅" forState:UIControlStateNormal];
            [favBtn setTintColor:[UIColor blackColor]];
            [favBtn setBackgroundColor: GkColor(242, 242, 245)];
        }else{
            [favBtn setTitle:@"订阅" forState:UIControlStateNormal];
            [favBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [favBtn setBackgroundColor:nativeColor];
        }
        favBtn.tag = Fav;        
    }
}
- (void)setModel:(GkStatus *)model {
    _model = model;
    self.descLabel.text =@"来自";
    self.summaryLabel.text =[NSString stringWithFormat:@"欢迎交流和拍砖 | 作者:%@",model.who];
    
    self.sourceLabel.text = model.type;
}

-(void)setIsFav:(NSInteger)isFav
{
    _isFav = isFav;
    
    if (isFav ==1) {
        [self.FavBtn setTitle:@"已订阅" forState:UIControlStateNormal];
        [self.FavBtn setTintColor:[UIColor blackColor]];
        [self.FavBtn setBackgroundColor: GkColor(242, 242, 245)];
    }else{
        [self.FavBtn setTitle:@"订阅" forState:UIControlStateNormal];
        [self.FavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * reuseId =@"topCell";
    
    id cell =[tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        
    }
    return cell;
}


@end
