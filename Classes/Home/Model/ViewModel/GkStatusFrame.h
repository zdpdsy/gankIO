//
//  GkStatusFrame.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/21.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class GkStatus;
@interface GkStatusFrame : NSObject
/**
 *  干货数据
 */

@property (strong,nonatomic) GkStatus * status;

@property (assign, nonatomic) CGRect originialFrame;
//title frame
@property (assign, nonatomic) CGRect titleFrame;

//source frame
@property (assign, nonatomic) CGRect socureFrame;

//time frame
@property (assign, nonatomic) CGRect timeFrame;

//icon frame
@property (assign, nonatomic) CGRect iconFrame;

//imgFrame 妹子
@property (assign,nonatomic) CGRect  girlFrame;

//typeFrame 干货类型
@property (assign, nonatomic) CGRect typeFrame;

//行高
@property (assign, nonatomic) CGFloat cellHeight;
@end
