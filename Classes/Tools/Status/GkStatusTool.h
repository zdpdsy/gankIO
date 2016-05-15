//
//  GkStatusTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GkStatusTool : NSObject
/**
 *  根据sinceId加载最新的干货数据
 *
 *  @param sinceId <#sinceId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadNewStatusWithSinceId:(int)sinceId success:(void(^)(NSArray * statuses))success
                        failure:(void(^)(NSError * error)) failure;

/**
 *  根据maxId加载之前的微博数据
 *
 *  @param maxId   <#maxId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadMoreStatusWithMaxId:(int)maxId success:(void(^)(NSArray * statuses)) success
                       failure:(void(^)(NSError * error)) failure;

/**
 *  根据sinceId加载最新的干货数据
 *
 *  @param sinceId pageSize
 *  @param type    干货类型
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadStatusWithType:(NSString *)requestType pageIndex:(NSString *)pageIndex success:(void(^)(NSArray * statuses))success
                        failure:(void(^)(NSError * error)) failure;




@end
