//
//  DpStatusResult.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "GkStatusResult.h"
#import "GkStatus.h"
#import "MJExtension.h"


@implementation GkStatusResult
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+(NSDictionary *)objectClassInArray
{
    return @{@"results":[GkStatus class]};
}
@end
