//
//  GkFuliCollectionViewCell.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/23.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkFuliCollectionViewCell.h"
@implementation GkFuliCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
        self.imageV.layer.cornerRadius =GkCellStatusMargin/2;
        self.imageV.layer.masksToBounds = YES;
    }
    return self;
}

-(void)setUpAllChildView
{
    CGFloat w = self.bounds.size.width;
    CGFloat h  = self.bounds.size.height;
    UIImageView * imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, w ,h)];
    //[imgV sizeToFit];
    _imageV=imgV;
    [self addSubview:imgV];
}
@end
