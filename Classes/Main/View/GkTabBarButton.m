//
//  GkTabBarButton.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkTabBarButton.h"
#define imageRadio 0.7
@implementation GkTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置字体颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:GkColor(41, 175, 236) forState:UIControlStateSelected];
        
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}

// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    //kvo
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮

    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听的属性一有新值，就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

//调整子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * imageRadio;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleX = 0;
    CGFloat titleY = imageH-3;
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);    
}
@end
