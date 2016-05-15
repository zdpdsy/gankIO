//
//  GkHttpTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GkHttpTool : NSObject


typedef void (^sblock) (id responseObject);
typedef void (^eblock) (NSError * error);

/**
 *  Get请求
 *
 *  @param url     请求地址
 *  @param param   请求参数
 *  @param success  请求成功的回调函数
 *  @param failure 请求失败的回调函数
 */
+(void)Get:(NSString *) url pramaters:(id) param success:(sblock)success failure:(eblock)failure;

/**
 *  Post请求
 *
 *  @param url     请求地址
 *  @param param   请求参数
 *  @param success 请求成功的回调函数
 *  @param failure 请求失败的回调函数
 */
+(void)Post:(NSString *)url pramaters:(id) param success:(sblock)success failure:(eblock)failure;

@end
