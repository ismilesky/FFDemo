//
//  FFBaseViewController.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseViewController.h"

#import "FFConst.h"

@interface FFBaseViewController ()

@end

@implementation FFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle];
    //    [self.navigationItem setHidesBackButton:YES];
    if (_leftBtn) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    }
    if (_rightBtn) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    } else if (_rightBtns && _rightBtns.count != 0) {
        NSMutableArray *rightBarBtns = [NSMutableArray array];
        NSInteger rightBtnCount = _rightBtns.count;
        for (NSInteger i = rightBtnCount - 1; i >= 0; i--) {
            UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtns[i]];
            [rightBarBtns addObject:btnItem];
        }
        self.navigationItem.rightBarButtonItems = rightBarBtns;
    }
    
    //如果UIScrollView或子类，不能滑动到顶部，ViewController中有一个UIScrollView或子类，发现大小不对(如底部不能靠底)时需要设置此属性为NO
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = _hideStatusBar;
    [UIApplication sharedApplication].statusBarStyle = _statusBarStyleDefault ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = _hideNavigationBar;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self cancelAllRequest];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    FFLog(@"%@ Do Dealloc",[[self class] classStr]);
}

#pragma mark - Property Method
- (UIColor *)navigationBarColor {
    if (_navigationBarColor) {
        return _navigationBarColor;
    }
    _navigationBarColor = [UIColor whiteColor];
    return _navigationBarColor;
}

- (void)setNavigationTitle:(NSString *)navigationTitle{
    _navigationTitle = navigationTitle;
    
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    if ([titleLabel isKindOfClass:[UILabel class]]) {
        [titleLabel setText:_navigationTitle];
    }
}

#pragma mark - Method
- (void)addNavigationTitle {
    self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
    self.navigationController.navigationBar.translucent = NO;
    if (_navigationTitle) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [titleLabel setText:_navigationTitle];
        [titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [titleLabel setTextColor:_navigationTitleColor?:[UIColor whiteColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        self.navigationItem.titleView = titleLabel;
    }
}

- (void)showBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    //    [backBtn setImage:[UIImage imageNamed:@"nav_back_tap.png"] forState:UIControlStateHighlighted];
    [backBtn setFrame:CGRectMake(0, 0, 35, 35)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 10)];
    [backBtn addTarget:self action:@selector(onBackBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
}

- (void)onBackBtnTap:(UIButton *)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:self.dismissBlock];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)cancelAllRequest {}

+ (NSString *)classStr {
    return NSStringFromClass([self class]);
}
@end
