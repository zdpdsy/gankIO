//
//  GkHttpTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkHttpTool.h"
#import "AFNetworking.h"
@implementation GkHttpTool

+(void)Get:(NSString *)url pramaters:(id)param success:(sblock)success failure:(eblock)failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)Post:(NSString *)url pramaters:(id)param success:(sblock)success failure:(eblock)failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
