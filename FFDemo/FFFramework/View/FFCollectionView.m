//
//  FFCollectionView.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFCollectionView.h"

#import "FFMoreFooterView.h"
#import "FFRefreshHeaderView.h"
#import "UIView+FFView.h"

@interface FFCollectionView ()<FFMoreFooterViewDelegate> {
    BOOL _isDisplay;
}
@property (nonatomic, strong) FFRefreshHeaderView *refreshView;
@property (nonatomic, strong) FFMoreFooterView *moreView;
@property (nonatomic, assign) BOOL isHiddenHeaderView;
@end

@implementation FFCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.refreshView = [FFRefreshHeaderView loadFromNib];
    self.refreshView.frame = CGRectMake(0, -self.refreshView.height, self.width, self.refreshView.height);
    [self addSubview:self.refreshView];
    self.alwaysBounceVertical = YES;
}

- (void)setRefreshHeaderViewBottom:(float)bottom {
    _refreshView.bottom = bottom;
}

- (void)isHiddenHeaderRefreshView:(BOOL)isHidden {
    _isHiddenHeaderView = isHidden;
}

- (void)isDisplayMoreView:(BOOL)isDisplay {
    _isDisplay = isDisplay;
}

- (BOOL)isNeedLoad {
    return self.contentOffset.y + self.height > self.contentSize.height + 30 && self.moreView.state != RefreshViewStateLoading && _isDisplay;
}

- (BOOL)isNeedRefresh {
    return self.contentOffset.y < -80 && self.refreshView.state != RefreshViewStateLoading;
}

- (void)startRefresh {
    if (!_isHiddenHeaderView) {
        [_refreshView setState:RefreshViewStateLoading];
        [self setContentOffset:CGPointMake(0, -40) animated:YES];
        
        if (self.loadDelegate && [self.loadDelegate respondsToSelector:@selector(collectionViewRefresh:)]) {
            [self.loadDelegate collectionViewRefresh:self];
        }
    }
}

- (void)didFinishedLoading {
    _refreshView.state = RefreshViewStateNormal;
    _moreView.state = RefreshViewStateNormal;
    
    if (self.contentOffset.y < 0) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)setContentSize:(CGSize)contentSize {
    contentSize = CGSizeMake(contentSize.width, contentSize.height + 40);
    [super setContentSize:contentSize];
    _refreshView.hidden = _isHiddenHeaderView;
    
    if (_isDisplay) {
        if (!_moreView) {
            _moreView = [FFMoreFooterView loadFromNib];
            _moreView.delegate = self;
        }
        _moreView.frame = CGRectMake(0, self.contentSize.height - _footHeight - _moreView.height, self.width, _moreView.height);
        [self addSubview:_moreView];
    } else {
        [_moreView removeFromSuperview];
        _moreView = nil;
    }
}

- (BOOL)isAnimating {
    return !self.dragging && !self.decelerating;
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    if ([self isNeedLoad]) {
        [_moreView setState:RefreshViewStateLoading];
        [self loadMore];
    }
    if ([self isNeedRefresh]) {
        if (self.dragging) {
            [_refreshView setState:RefreshViewStateWillLoad];
        }
        if (self.decelerating) {
            [self startRefresh];
        }
    } else {
        if (_refreshView.state == RefreshViewStateWillLoad) {
            [_refreshView setState:RefreshViewStateNormal];
        }
    }
    [_refreshView scrollViewDidScroll:self];
}

- (RefreshViewState)state {
    return _refreshView.state;
}

#pragma mark - FFMoreFooterViewDelegate
- (void)loadMore {
    if (self.loadDelegate && [self.loadDelegate respondsToSelector:@selector(collectionViewLoadMore:)]) {
        [self.loadDelegate collectionViewLoadMore:self];
    }
}

@end
