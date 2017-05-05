//
//  FFBaseSplitViewController.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFBaseSplitViewController : UISplitViewController <UISplitViewControllerDelegate>
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, strong) UIColor *navigationTitleColor;
@property (nonatomic, strong) UIColor *navigationBarColor;
@property (nonatomic, assign, getter=isHideNavigationBar) BOOL hideNavigationBar;
@property (nonatomic, assign, getter=isStatuBarStyleDefault) BOOL statuBarStyleDefault;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) NSArray *rightBtns;

- (void)cancelAllRequest;
+ (NSString *)classStr;

@end
