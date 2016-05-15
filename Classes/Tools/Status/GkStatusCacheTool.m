//
//  GkStatusCacheTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/4/27.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkStatusCacheTool.h"
#import "GkStatus.h"
#import "FMDB.h"
#import "NSString+string.h"
@implementation GkStatusCacheTool

 static FMDatabase * _db;
+(void)initialize
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //拼接路径
    NSString * filePath = [cachePath stringByAppendingPathComponent:@"status.db"];
    
    //创建一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL isOpen = [_db open];
    if (isOpen) {
        GkLog(@"数据库开启成功");
    }else{
        GkLog(@"数据库开启失败");
    }
    
    //创建table
    BOOL falg= [_db executeUpdate:@"create table if not exists gk_status(id integer primary key autoincrement,key text,dict blob);"];
    if (falg) {
        GkLog(@"创建table 成功");
    }else{
        GkLog(@"创建table 失败");
    }
}
+(void)saveWithStatus:(NSArray *)status dateKey:(NSString *)dateKey
{
    //遍历模型数据
    for (NSDictionary * statusDict in status) {
        
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        BOOL isAddSucceed = [_db executeUpdate:@"insert into gk_status(key,dict) values(?,?)",dateKey,data];
        if (isAddSucceed) {
            GkLog(@"插入 table gk_status success");
        }else{
            GkLog(@"插入 table gk_status failure");
        }
    }
}

+(NSArray *)getStatusList:(NSString *)key
{
    NSString * sqlStr =[NSString stringWithFormat:@"select * from gk_status where key = '%@'",key];
    
    FMResultSet * set = [_db executeQuery:sqlStr];
    NSMutableArray * arrM = [NSMutableArray array];
    while ([set next]) {
        NSData * dictData =[set dataForColumn:@"dict"];
        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        //字典转模型
        //GkStatus * status = [[GkStatus alloc] initWithDictionary:dict];
        
        [arrM addObject:dict];
    }
    return arrM;
}
@end
