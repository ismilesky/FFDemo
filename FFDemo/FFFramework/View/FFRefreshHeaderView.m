//
//  FFRefreshHeaderView.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFRefreshHeaderView.h"

#import "UIView+FFView.h"

@interface FFRefreshHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *loadingImgView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@end

@implementation FFRefreshHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.loadingImgView stopRotationDisableViews:nil];
}

- (void)dealloc {
    FFLog(@"FFRefreshHeaderView dealloc");
}

#pragma mark - Method
- (void)setState:(RefreshViewState)state {
    _state = state;
    NSString *title = nil;
    
    switch (state) {
        case RefreshViewStateNormal:
            title = @"下拉可以刷新哦!";
            [self.loadingImgView stopRotationDisableViews:nil];
            break;
        case RefreshViewStateLoading:
            title = @"正在刷新，请稍后...";
            [self.loadingImgView startRotationWithDisableViews:nil];
            break;
        case RefreshViewStateWillLoad:
            title = @"松开就能刷新哦!";
            [self.loadingImgView stopRotationDisableViews:nil];
            break;
    }
    self.stateLabel.text = title;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0 && _state != RefreshViewStateLoading) {
        float angle = degreesToRadian(-scrollView.contentOffset.y * 3);
        self.loadingImgView.transform = CGAffineTransformMakeRotation(angle);
    }
}


@end
