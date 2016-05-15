//
//  GkStatusCacheTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/4/27.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GkStatusCacheTool : NSObject

+(void)saveWithStatus:(NSArray *)status dateKey:(NSString *)dateKey;

+(NSArray *)getStatusList:(NSString *)key;

@end
