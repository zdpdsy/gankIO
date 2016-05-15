//
//  GkFavDbTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/5/5.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GkStatus;

@interface GkFavDbTool : NSObject

/**
 *  insert model
 *
 *  @param status <#status description#>
 */
+(void)saveWithFavstatus:(GkStatus*)status;

/**
 *  根据id 获取收藏状态
 *
 *  @param Key <#Key description#>
 *
 *  @return 1:已订阅 0:没订阅
 */
+(NSInteger)GetFavStatusWithKey:(NSString *)Key;

/**
 *  根据干货id 获取收藏状态的autoid
 *
 *  @param Key <#Key description#>
 *
 *  @return <#return value description#>
 */
+(NSInteger)GetFavAutoIdWithKey:(NSString *)Key;

/**
 *  更新model
 *
 *  @param status <#status description#>
 */
+(void)UpdateFavStatus:(GkStatus *)status;


/**
 *  获取订阅列表
 *
 *  @return <#return value description#>
 */
+(NSArray *)getFavList;

/**
 *  获取订阅列表分页数据
 *
 *  @param pageIndex <#pageIndex description#>
 *  @param pageSize  <#pageSize description#>
 *
 *  @return <#return value description#>
 */
+(NSArray *)getFavListWithPageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize;


+(NSArray *)getFavListWithSinceId:(NSString *)sinceId MaxId:(NSString *)maxId;

@end
