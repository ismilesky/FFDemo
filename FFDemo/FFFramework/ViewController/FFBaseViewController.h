//
//  FFBaseViewController.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissBlock)();

@interface FFBaseViewController : UIViewController
/**设置标题*/
@property (nonatomic, copy) NSString *navigationTitle;
/**设置标题颜色*/
@property (nonatomic, strong) UIColor *navigationTitleColor;
/**设置NavigationBar颜色*/
@property (nonatomic, strong) UIColor *navigationBarColor;
/**隐藏NavigationBar*/
@property (nonatomic, assign, getter=isHideNavigationBar) BOOL hideNavigationBar;
/**隐藏状态栏*/
@property (nonatomic, assign, getter=isHideStatusBar) BOOL hideStatusBar;
/**设置状态栏样式*/
@property (nonatomic, assign, getter=isStatusBarStyleDefault) BOOL statusBarStyleDefault;

@property (nonatomic, assign, getter=isNavBarColorChange) BOOL navBarColorChange;
/**左按钮*/
@property (nonatomic, strong) UIButton *leftBtn;
/**右按钮*/
@property (nonatomic, strong) UIButton *rightBtn;
/**右边多个按钮数组*/
@property (nonatomic, strong) NSArray *rightBtns;
/***/
@property (nonatomic, copy) DismissBlock dismissBlock;

/**显示返回按钮（默认返回按钮）*/
- (void)showBackBtn;

/**返回按钮点击*/
- (void)onBackBtnTap:(UIButton *)sender;

/**取消请求*/
- (void)cancelAllRequest;
+ (NSString *)classStr;

@end
