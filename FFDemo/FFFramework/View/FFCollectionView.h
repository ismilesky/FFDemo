//
//  FFCollectionView.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFConst.h"

@class FFCollectionView;
@protocol FFCollectionViewDelegate <NSObject>
- (void)collectionViewRefresh:(FFCollectionView *)collectionView;
- (void)collectionViewLoadMore:(FFCollectionView *)collectionView;
@end

@interface FFCollectionView : UICollectionView
@property (nonatomic, weak) id<FFCollectionViewDelegate> loadDelegate;
@property (nonatomic, assign) float footHeight;
@property (nonatomic, readonly) RefreshViewState state;
- (void)setRefreshHeaderViewBottom:(float)bottom;
- (void)isHiddenHeaderRefreshView:(BOOL)isHidden;
- (void)isDisplayMoreView:(BOOL)isDisplay;
- (void)didFinishedLoading;
- (void)startRefresh;
@end
