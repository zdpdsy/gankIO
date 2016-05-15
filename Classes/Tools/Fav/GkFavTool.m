//
//  GkFavTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/5/5.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkFavTool.h"
#import "GkFavDbTool.h"
@implementation GkFavTool
+(void)loadFavDataWithIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSArray * list = [GkFavDbTool getFavListWithPageIndex:pageIndex pageSize:pageSize];
    if (success) {
        success(list);
    }
    
    
}

+(void)loadFavDataWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSArray * list = [GkFavDbTool getFavListWithSinceId:sinceId MaxId:nil];

        if (success) {
            success(list);
        }    
}

+(void)loadFavDataWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSArray * list = [GkFavDbTool getFavListWithSinceId:nil MaxId:maxId];
        if (success) {
            success(list);
        }
}
@end
