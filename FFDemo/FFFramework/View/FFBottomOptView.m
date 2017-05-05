//
//  FFBottomOptView.m
//  FFDemo
//
//  Created by VS on 2017/4/27.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBottomOptView.h"
#import "UIView+FFView.h"

static NSTimeInterval duration = 0.25;

@interface FFBottomOptView () {
    UIControl *_bgControl;
    UIView *_inView;
}
@end

@implementation FFBottomOptView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bgControl = [[UIControl alloc] init];
        _bgControl.backgroundColor = [UIColor blackColor];
        [_bgControl addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        [toolBar setAutoresizeMaskAll];
        [self insertSubview:toolBar atIndex:0];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Method
- (void)showInWindow {
    [self showInView:[UIView keyWindow]];
}

- (void)showInView:(UIView *)aView {
    _inView = aView;
    
    _bgControl.frame = aView.bounds;
    [aView addSubview:_bgControl];
    self.width = aView.width;
    [aView addSubview:self];
    
    self.top = aView.height;
    _bgControl.alpha = 0;
    
    [UIView animateWithDuration:duration animations:^{
        _bgControl.alpha = 0.2;
        self.bottom = aView.height;
        _bgControl.bottom = self.top;
    }];
}

- (void)cancel {
    [UIView animateWithDuration:duration animations:^{
        self.top = _inView.height;
        _bgControl.bottom = self.top;
        _bgControl.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_bgControl removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

@end
