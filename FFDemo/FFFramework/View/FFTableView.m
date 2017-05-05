//
//  FFTableView.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFTableView.h"

#import "FFMoreFooterView.h"
#import "FFRefreshHeaderView.h"

#import "UIView+FFView.h"

@interface FFTableView () <FFMoreFooterViewDelegate> {
    FFMoreFooterView *_moreView;
    FFRefreshHeaderView *_refreshView;
    void(^_moreBlock)();
    void(^_refreshBlock)();
}
@end

@implementation FFTableView
- (void)setRefreshHeaderViewBottom:(float)bottom {
    _refreshView.bottom = bottom;
}

- (void)setMoreBlock:(void (^)())moreBlock {
    _moreBlock = moreBlock;
    
    if (moreBlock) {
        if (!_moreView) {
            _moreView = [FFMoreFooterView loadFromNib];
            _moreView.delegate = self;
        }
        self.tableFooterView = _moreView;
    } else {
        self.tableFooterView = nil;
    }
}

- (void)setRefreshBlock:(void (^)())refreshBlock {
    _refreshBlock = refreshBlock;
    
    if (_refreshBlock) {
        if (!_refreshView) {
            _refreshView = [FFRefreshHeaderView loadFromNib];
            _refreshView.frame = CGRectMake(0, -_refreshView.height, self.width, _refreshView.height);
        }
        [self addSubview:_refreshView];
    } else {
        [_refreshView removeFromSuperview];
    }
}

- (BOOL)isNeedLoad {
    return self.contentOffset.y + self.height > self.contentSize.height + 50 && _moreView.state != RefreshViewStateLoading && _moreBlock;
}

- (BOOL)isNeedRefresh {
    return _refreshBlock && self.contentOffset.y < -100 && _refreshView.state != RefreshViewStateLoading;
}

- (void)startRefresh {
    [self setContentOffset:CGPointMake(0, -40) animated:YES];
    if (_refreshBlock) {
        _refreshBlock();
    }
}

- (void)didFinishedLoading {
    _moreView.state = RefreshViewStateNormal;
    _refreshView.state = RefreshViewStateNormal;
    
    if (self.contentOffset.y < 0) {
        [self setContentOffset:CGPointZero animated:YES];
    }
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    if ([self isNeedLoad]) {
        [_moreView setState:RefreshViewStateLoading];
        [self loadMore];
    }
    if ([self isNeedRefresh]) {
        if (self.isDragging) {
            [_refreshView setState:RefreshViewStateWillLoad];
        }
        if (self.isDecelerating) {
            [_refreshView setState:RefreshViewStateLoading];
            [self startRefresh];
        }
    } else {
        if (_refreshView.state == RefreshViewStateWillLoad) {
            [_refreshView setState:RefreshViewStateWillLoad];
        }
    }
    [_refreshView scrollViewDidScroll:self];
}

#pragma mark - FFMoreFooterViewDelegate
- (void)loadMore {
    if (_moreBlock) {
        _moreBlock();
    }
}
@end
