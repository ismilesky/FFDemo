//
//  FFMoreFooterView.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFMoreFooterView.h"
#import "UIView+FFView.h"

@interface FFMoreFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation FFMoreFooterView

#pragma mark - Method
- (void)setState:(RefreshViewState)state {
    _state = state;
    NSString *title = nil;
    switch (state) {
        case RefreshViewStateNormal:
            title = @"更多...";
            self.moreBtn.userInteractionEnabled = YES;
            [self.indicatorView stopAnimating];
            break;
        case RefreshViewStateLoading:
            title = @"正在加载，请稍候...";
            self.moreBtn.userInteractionEnabled = NO;
            [self.indicatorView startAnimating];
            break;
        case RefreshViewStateWillLoad:
            title = @"松开就能加载哦!";
            self.moreBtn.userInteractionEnabled = YES;
            [self.indicatorView stopAnimating];
            break;
    }
    [self.moreBtn setTitle:title forState:UIControlStateNormal];
    [self.moreBtn setTitle:title forState:UIControlStateHighlighted];
}

#pragma mark - Action
- (IBAction)onMoreBtnTap:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadMore)]) {
        [self setState:RefreshViewStateLoading];
        [self.delegate loadMore];
    }

}


@end
