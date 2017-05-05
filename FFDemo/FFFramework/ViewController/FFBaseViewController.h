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
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, strong) UIColor *navigationTitleColor;
@property (nonatomic, strong) UIColor *navigationBarColor;
@property (nonatomic, assign, getter=isHideNavigationBar) BOOL hideNavigationBar;
@property (nonatomic, assign, getter=isHideStatusBar) BOOL hideStatusBar;
@property (nonatomic, assign, getter=isStatusBarStyleDefault) BOOL statusBarStyleDefault;
@property (nonatomic, assign, getter=isNavBarColorChange) BOOL navBarColorChange;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) NSArray *rightBtns;
@property (nonatomic, copy) DismissBlock dismissBlock;

- (void)showBackBtn;
- (void)onBackBtnTap:(UIButton *)sender;

- (void)cancelAllRequest;
+ (NSString *)classStr;

@end
