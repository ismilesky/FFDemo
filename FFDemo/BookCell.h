//
//  BookCell.h
//  FFDemo
//
//  Created by VS on 2017/5/3.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestModel;

@interface BookCell : UITableViewCell

@property (nonatomic, strong) TestModel *book;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
