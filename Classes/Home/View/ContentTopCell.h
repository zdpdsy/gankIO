//
//  ContentTopCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
@class  GkStatus;

@protocol ContentTopCellDelegate <NSObject>

@optional
-(void)didFavBtnClick;

@end

@interface ContentTopCell : UITableViewCell

@property (nonatomic, strong) GkStatus *model;

@property (assign, nonatomic) NSInteger isFav;

@property (strong,nonatomic) id<ContentTopCellDelegate>  delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end



