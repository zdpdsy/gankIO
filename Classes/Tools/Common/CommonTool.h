//
//  CommonTool.h
//  gankIO
//
//  Created by 曾大鹏 on 16/4/27.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject
+(UIColor *)translateHexStringToColor:(NSString *)hexColor;

+(BOOL)isIOS7;

+(float)IOSVersion;

/**
 *  日期转换
 *
 *  @param value     <#value description#>
 *  @param formatter <#formatter description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getStrWithValue:(NSString *)value Fomatter:(NSString *)formatter;

@end
