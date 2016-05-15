//
//  GkTableViewCell.h
//  gankIO
//
//  Created by 曾大鹏 on 16/3/16.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GkStatusFrame;
@interface GkTableViewCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView *) tableView;

@property (strong,nonatomic) GkStatusFrame * statusFrame;

@end
