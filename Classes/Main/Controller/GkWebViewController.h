//
//  GkWebViewController.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/21.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GkStatus;
@interface GkWebViewController : UIViewController
/**
 *  干货model
 */
@property (nonatomic, strong) GkStatus * status;

/**
 *  是否已收藏
 */
@property (assign, nonatomic) NSInteger isFav;


@end
