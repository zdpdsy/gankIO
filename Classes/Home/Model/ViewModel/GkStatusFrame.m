//
//  GkStatusFrame.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/21.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkStatusFrame.h"
#import "GkStatus.h"
#import "CommonTool.h"
@implementation GkStatusFrame

-(void)setStatus:(GkStatus *)status
{
    _status = status;
    
    //设置所有子控件frame
    [self setUpAllFrame];
    
}


-(void)setUpAllFrame{
    
    
    
    
    //titleFrame
    
    CGFloat titleX = GkCellStatusMargin;
    CGFloat titleY = titleX;
    
    CGFloat titleW = GkSreenW - titleX;
    //CGSize titleSize = [_status.desc sizeWithFont:GkTextFont constrainedToSize:CGSizeMake(titleW, MAXFLOAT)];
    
    CGSize titleSize = [_status.desc boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:GkTextFont} context:nil].size;
    
    self.titleFrame = (CGRect){{titleX,titleY},titleSize};
    
    //iconFrame
   
    CGFloat iconY = CGRectGetMaxY(_titleFrame)+GkCellStatusMargin/3;
    CGFloat iconWH =40;
    CGFloat iconX = GkSreenW-iconWH-GkCellStatusMargin;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGRect headFrame = self.iconFrame;
    //imgFrame
    if ([_status.type isEqualToString:@"福利"]) {
        CGFloat imgX = 0;
        CGFloat imgY = 0;
        CGFloat imgW = GkSreenW;
        CGFloat imgH= 250;
        self.girlFrame = CGRectMake(imgX, imgY, imgW, imgH);
        headFrame = self.girlFrame;
    }
    //typeFrame
    
    CGFloat typeY = CGRectGetMaxY(headFrame)+GkCellStatusMargin/2;
    CGSize typeSize = [_status.type sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat typeX = GkSreenW-typeSize.width-GkCellStatusMargin;
    self.typeFrame = (CGRect){{typeX,typeY},typeSize};
    
    
    
    //soureframe
    
    CGFloat sourceY = CGRectGetMaxY(_typeFrame)+GkCellStatusMargin/2;
    //根据值自动算出最适合的
    CGSize sourceSize = [[NSString stringWithFormat:@"选自 %@",_status.who] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat sourceX = GkSreenW -GkCellStatusMargin-sourceSize.width;
    self.socureFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //timeframe
    NSString * publishTime = [CommonTool getStrWithValue:_status.publishedAt Fomatter:@"yyyyMMdd"];
    
    CGSize timeSize = [publishTime sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    CGFloat timeX = GkCellStatusMargin;
    CGFloat timeY = sourceY;
    self.timeFrame = (CGRect){{timeX,timeY},timeSize};
    if ([_status.type isEqualToString:@"福利"]) {
        self.iconFrame = CGRectMake(GkCellStatusMargin, typeY, iconWH, iconWH);
        self.timeFrame = (CGRect){{GkCellStatusMargin+iconWH+3,timeY},timeSize};

    }
    
    CGFloat originalX = 0;
    CGFloat originalY = GkCellStatusMargin/2;
    CGFloat originalW = GkSreenW;
    CGFloat originalH = CGRectGetMaxY(_socureFrame)+GkCellStatusMargin;
    
    self.originialFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    //行高
    self.cellHeight = CGRectGetMaxY(_originialFrame);//+1.5*GkCellStatusMargin;
}
@end
