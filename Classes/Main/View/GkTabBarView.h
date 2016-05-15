//
//  GkTabBarView.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GkTabBarView;

//定义一个协议
@protocol GkTabBarDelegate <NSObject>

@optional
- (void)tabBar:(GkTabBarView *)tabBar didClickButton:(NSInteger)index;

@end
/**
 *  自定义uitabbar控件
 */
@interface GkTabBarView : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray * items;

//代理属性
@property (strong,nonatomic) id<GkTabBarDelegate> delegate;
@end
