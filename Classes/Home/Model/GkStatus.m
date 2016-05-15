//
//  GkStatus.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkStatus.h"

@implementation GkStatus

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

//-(NSString *)createdAt
//{
//    //获取微博创建时间
//    //1.创建日期格式化器
//    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
//   // fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
//    [fm setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//    
//    NSDate * createDate  = [fm dateFromString:_createdAt];
//    //NSLog(@"originaldate = %@ 。。。。createdate=%@",_created_at,createDate);
//    
//    fm.dateFormat = @"yyyy-MM-dd";
//    NSString * time = [fm stringFromDate:createDate];
//    return time;
//}
//
//-(NSString *)publishedAt
//{
//    //获取微博创建时间
//    //1.创建日期格式化器
//    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
//    // fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
//    [fm setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//    
//    NSDate * createDate  = [fm dateFromString:_publishedAt];
//    //NSLog(@"originaldate = %@ 。。。。createdate=%@",_created_at,createDate);
//    
//    fm.dateFormat = @"yyyyMMdd";
//    NSString * time = [fm stringFromDate:createDate];
//    return time;
//}
@end
