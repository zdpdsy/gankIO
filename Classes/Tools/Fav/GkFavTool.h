//
//  GkFavTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/5/5.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GkFavTool : NSObject

/**
 *  获取订阅列表
 *
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
+(void)loadFavDataWithIndex:(NSString *)pageIndex pageSize:(NSString *) pageSize success:(void(^)(NSArray * statuses))success
                  failure:(void(^)(NSError * error)) failure;

/**
 *  根据sinceId加载最新的订阅列表
 *
 *  @param sinceId   <#sinceId description#>
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
+(void)loadFavDataWithSinceId:(NSString* )sinceId  success:(void(^)(NSArray * statuses))success
                    failure:(void(^)(NSError * error)) failure;

/**
 *  根据maxId加载之前的获取订阅列表
 *
 *  @param maxId     <#maxId description#>
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
+(void)loadFavDataWithMaxId:(NSString* )maxId success:(void(^)(NSArray * statuses))success
                      failure:(void(^)(NSError * error)) failure;

@end
