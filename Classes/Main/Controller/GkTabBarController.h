//
//  GkTabBarController.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GkTabBarController : UITabBarController

-(instancetype)initWithType:(NSString *)requestType titleName:(NSString *)titleName;

@property (copy, nonatomic) NSString *requestType;

@property (copy, nonatomic) NSString *titleName;

@end
