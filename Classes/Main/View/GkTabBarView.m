//
//  GkTabBarView.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkTabBarView.h"

#import "GkTabBarButton.h"
@interface GkTabBarView()

/**
 *  当前选中的按钮
 */
@property (weak,nonatomic) UIButton * selectedBtn;

/**
 *  所有按钮
 */
@property (strong,nonatomic) NSMutableArray * buttons;

@end



@implementation GkTabBarView

//懒加载
-(NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    
    return _buttons;
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    //遍历模型数组，创建对应的button
    
    for (UITabBarItem * item in _items) {
        
        GkTabBarButton * button = [[GkTabBarButton alloc] init];
        
        //赋值
        button.item = item;
        
        button.tag = self.buttons.count;
        
        //添加点击事件
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        //如果是第一个
        if(button.tag == 0) {
            
            [self btnClick:button];
        }
        
        //添加到view中
        [self addSubview:button];
        
        [self.buttons addObject:button];
    }
    
}
#pragma mark - 按钮点击事件
-(void)btnClick:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    //执行代理方法 通知tabBarVc切换控制器
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:btn.tag];
    }
    
}

#pragma mark - 调整子空间的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat W= self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY =0;
    CGFloat btnW = W/(self.buttons.count);
    CGFloat btnH = H;
    
    int i= 0;
    for (UIView * tabBarButton in self.buttons) {
        btnX = i*btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}

@end
