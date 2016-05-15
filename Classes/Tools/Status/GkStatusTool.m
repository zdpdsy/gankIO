//
//  GkStatusTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkStatusTool.h"
#import "GkHttpTool.h"
#import "MJExtension.h"
#import "GkStatus.h"
#import "GkStatusCacheTool.h"
#import "GkStatusResult.h"
#import "NSString+string.h"
@implementation GkStatusTool
+(void)loadNewStatusWithSinceId:(int)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    if (sinceId ==0) {
        sinceId = 1;
    }
    NSString * url = [NSString stringWithFormat:@"http://gank.io/api/data/all/20/%d",sinceId];
    [GkHttpTool Get:url pramaters:nil success:^(id responseObject) {
        
        //GkStatusResult * result = [GkStatusResult objectWithKeyValues:responseObject];
         //1.获取字典数据
         NSArray * dictArr  = responseObject[@"results"];
        
        //2.字典转模型
         NSArray * status = (NSMutableArray *)[GkStatus objectArrayWithKeyValuesArray:dictArr];
        if (success) {
            success(status);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadMoreStatusWithMaxId:(int)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSString * url = [NSString stringWithFormat:@"http://gank.io/api/data/all/20/%d",maxId];
    [GkHttpTool Get:url pramaters:nil success:^(id responseObject) {
        
        //GkStatusResult * result = [GkStatusResult objectWithKeyValues:responseObject];
        //1.获取字典数据
        NSArray * dictArr  = responseObject[@"results"];
        
        //2.字典转模型
        NSArray * status = (NSMutableArray *)[GkStatus objectArrayWithKeyValuesArray:dictArr];
        if (success) {
            success(status);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadNewStatusWithSinceId:(int)sinceId type:(NSString *)type success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    if (sinceId==0) {
        sinceId=1;
    }
    type= [type stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url = [NSString stringWithFormat:@"http://gank.io/api/data/%@/20/%d",type,sinceId];
    [GkHttpTool Get:url pramaters:nil success:^(id responseObject) {
        
        //GkStatusResult * result = [GkStatusResult objectWithKeyValues:responseObject];
        //1.获取字典数据
        NSArray * dictArr  = responseObject[@"results"];
        
        //2.字典转模型
        NSArray * status = (NSMutableArray *)[GkStatus objectArrayWithKeyValuesArray:dictArr];
        if (success) {
            success(status);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadStatusWithType:(NSString *)requestType pageIndex:(NSString *)pageIndex  success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString * nowdate = [NSString getStrByFormatter:[NSDate date] formatter:@"yyyy-MM-dd"];
    NSString * dateKey = [NSString stringWithFormat:@"%@-%@-%@",requestType,nowdate,pageIndex];
    
    NSArray * list = [GkStatusCacheTool getStatusList:dateKey];
    
    if (list.count>0) {
        if (success) {
            success(list);
            return;
        }
    }
    requestType = [requestType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url = [NSString stringWithFormat:@"http://gank.io/api/data/%@/20/%@",requestType,pageIndex];
    
    [GkHttpTool Get:url pramaters:nil success:^(id responseObject) {
        if (success) {

            NSArray * result =responseObject[@"results"];
            success(result);
            
            [GkStatusCacheTool saveWithStatus:result dateKey:dateKey];
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
