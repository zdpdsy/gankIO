//
//  GkStatus.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface GkStatus : NSObject<MJKeyValue>

/**
 *  文章ID
 */
@property (copy, nonatomic) NSString * _id;

/**
 *  used
 */
@property (copy, nonatomic) NSString * used;

/**
 *  创建时间
 */
@property (copy, nonatomic) NSString * createdAt;

/**
 *  发布时间
 */
@property (copy, nonatomic) NSString *publishedAt;

/**
 *  来源
 */
@property (copy, nonatomic) NSString *source;

/**
 *  文章type : ios android 福利等
 */
@property (copy, nonatomic) NSString * type;

/**
 *  文章链接或者福利链接
 */
@property (copy, nonatomic) NSString *url;

/**
 *  文章title
 */
@property (copy, nonatomic) NSString *desc;

/**
 *  文章作者
 */
@property (copy, nonatomic) NSString *who;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
