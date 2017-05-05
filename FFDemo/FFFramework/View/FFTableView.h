//
//  FFTableView.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTableView : UITableView
- (void)setRefreshHeaderViewBottom:(float)bottom;

/**
 结束加载
 */
- (void)didFinishedLoading;

/**
 @param refreshBlock 刷新
 */
- (void)setRefreshBlock:(void (^)())refreshBlock;
/**
 *
 *  @param moreBlock 加载更多Block
 */
- (void)setMoreBlock:(void (^)())moreBlock;
@end
