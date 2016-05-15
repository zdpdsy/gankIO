//
//  GkFavDbTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/5/5.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkFavDbTool.h"
#import "FMDB.h"
#import "GkStatus.h"
#import "MJExtension.h"


@implementation GkFavDbTool

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
    BOOL falg= [_db executeUpdate:@"create table if not exists gk_favstatus(id integer primary key autoincrement,key text,isFav text,dict blob);"];
    if (falg) {
        GkLog(@"创建table gk_favstatus 成功");
    }else{
        GkLog(@"创建table gk_favstatus 失败");
    }
    
}
+(void)saveWithFavstatus:(GkStatus *)status
{
    NSDictionary * dict =status.keyValues;
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    BOOL isAddSucceed = [_db executeUpdate:@"insert into gk_favstatus(key,isFav,dict) values(?,?,?)",status._id,@"1",data];
    if (isAddSucceed) {
        GkLog(@"插入 table gk_favstatus success");
    }else{
        GkLog(@"插入 table gk_favstatus failure");
    }
}

+(void)UpdateFavStatus:(GkStatus *)status
{
    NSInteger isFav = [self GetFavStatusWithKey:status._id];
    if (isFav==-1) {
        [self saveWithFavstatus:status];
        return;
    }
    isFav = 1-isFav;
       
    BOOL isUpdate = [_db executeUpdate:@"update gk_favstatus set isFav=? where key =?",[NSString stringWithFormat:@"%ld",isFav],status._id];
    if (isUpdate) {
        GkLog(@"更新 table gk_favstatus success");
    }else{
        GkLog(@"更新 table gk_favstatus failure");
    }
}

+(NSArray *)getFavList
{
    NSString * sql = @"select * from gk_favstatus where isFav = '1' ";
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * arrM =[NSMutableArray array];
    while ([set next]) {
        NSData * dictData =[set dataForColumn:@"dict"];
        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        GkStatus * status = [[GkStatus alloc] initWithDictionary:dict];
        [arrM addObject:status];
    }
    return arrM;
}

+(NSInteger)GetFavStatusWithKey:(NSString *)Key
{
    NSInteger IsFavSatus=-1;
    NSString * sqlStr =[NSString stringWithFormat:@"select * from gk_favstatus where key = '%@' order by id desc limit 1;",Key];
    FMResultSet * set = [_db executeQuery:sqlStr];
    while ([set next]) {
        NSString * isFav = [set stringForColumn:@"isFav"];
        IsFavSatus = [isFav integerValue];
        break;
    }
    return IsFavSatus;
}

+(NSInteger)GetFavAutoIdWithKey:(NSString *)Key
{
    NSInteger autoId =-1;
    NSString * sqlStr =[NSString stringWithFormat:@"select * from gk_favstatus where key = '%@' order by id desc limit 1;",Key];
    FMResultSet * set = [_db executeQuery:sqlStr];
    while ([set next]) {
        NSString * idStr = [set stringForColumn:@"id"];
        autoId = [idStr integerValue];
        break;
    }
    return autoId;
}

+(NSArray *)getFavListWithPageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    NSInteger pIndex = [pageIndex integerValue];
    NSInteger pSize = [pageSize integerValue];
    NSInteger startIndex = pSize*(pIndex-1);
    
    NSString * sql = [NSString stringWithFormat:@"select * from gk_favstatus where isFav = '1' order by id desc limit %@ offset %ld ;",pageSize,startIndex];
    
    
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * arrM =[NSMutableArray array];
    while ([set next]) {
        NSData * dictData =[set dataForColumn:@"dict"];
        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        GkStatus * status = [[GkStatus alloc] initWithDictionary:dict];
        [arrM addObject:status];
    }
    return arrM;
}
+(NSArray *)getFavListWithSinceId:(NSString *)sinceId MaxId:(NSString *)maxId
{
     NSString * sql = [NSString stringWithFormat:@"select * from gk_favstatus where isFav = '1' order by id desc limit 20"];
    if (sinceId.length>0) { //获取最新订阅数据
        sql = [NSString stringWithFormat:@"select * from gk_favstatus where isFav = '1' and id>'%@' order by id desc limit 20 ",sinceId];
    }else if(maxId.length>0){ //获取更多订阅数据
         sql = [NSString stringWithFormat:@"select * from gk_favstatus where isFav = '1' and id<'%@' order by id desc limit 20 ",maxId];
    }
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * arrM =[NSMutableArray array];
    while ([set next]) {
        NSData * dictData =[set dataForColumn:@"dict"];
        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        GkStatus * status = [[GkStatus alloc] initWithDictionary:dict];
        [arrM addObject:status];
    }
    return arrM;
}

//+(NSArray *)statusedWithParam:(DpStatusParam *)param
//{
//    NSString * sql =[NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
//    if (param.since_id) { //获取最新微博
//        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@'order by idstr desc limit 20;",param.access_token,param.since_id];
//    }else if(param.max_id){ //获取更多微博
//        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@'order by idstr desc limit 20;",param.access_token,param.max_id];
//    }
//    //select * from t_status where access_token = param.accesstoekn order by idstr desc limit 20
//    FMResultSet * set = [_db executeQuery:sql];
//    NSMutableArray * arrM = [NSMutableArray array];
//    while ([set next]) {
//        NSData * dictData =[set dataForColumn:@"dict"];
//        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
//        //字典转模型
//        DpStatus * status = [DpStatus objectWithKeyValues:dict];
//        
//        [arrM addObject:status];
//    }
//    return arrM;
//}
@end
