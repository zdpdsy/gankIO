//
//  GkHomeViewController.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GkHomeViewController : UITableViewController

@property (strong,nonatomic) NSString * requestType;

@property (strong,nonatomic) NSString  * titleName;

-(instancetype)initWithType:(NSString *)requestType titleName:(NSString *)titleName;

@end
