//
//  CommonTool.m
//  gankIO
//
//  Created by 曾大鹏 on 16/4/27.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+(float)IOSVersion
{
    static float _iOSVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _iOSVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return _iOSVersion;
}
+(BOOL)isIOS7
{
    if ([CommonTool IOSVersion]>=7.0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(UIColor *)translateHexStringToColor:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])  cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])   cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rColorValue = [cString substringWithRange:range];
    range.location = 2;
    NSString *gColorValue = [cString substringWithRange:range];
    range.location = 4;
    NSString *bColorValue = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rColorValue] scanHexInt:&r];
    [[NSScanner scannerWithString:gColorValue] scanHexInt:&g];
    [[NSScanner scannerWithString:bColorValue] scanHexInt:&b];
    return [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat) b / 255.0f) alpha:1.0f];
}

+(NSString *)getStrWithValue:(NSString *)value Fomatter:(NSString *)formatter
{
    //获取微博创建时间
    //1.创建日期格式化器
    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
    // fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [fm setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    NSDate * createDate  = [fm dateFromString:value];
    //NSLog(@"originaldate = %@ 。。。。createdate=%@",_created_at,createDate);
    
    fm.dateFormat = formatter;
    NSString * time = [fm stringFromDate:createDate];
    return time;
}

@end
