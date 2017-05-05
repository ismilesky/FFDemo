//
//  FFTabBarController.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTabBarController : UITabBarController

@end

@interface FFTabBarView : UIToolbar
+ (instancetype)createTabBarView;
+ (instancetype)getTabBarView;
+ (void)selectedIndex:(NSInteger)idx;
- (IBAction)onButtonTouched:(id)sender;//tag:0,1,2....

- (FFTabBarController *)tabBarController;
- (UINavigationController *)currentNavigationController;

#pragma mark - SubClass
- (NSArray<Class> *)getViewControllersClass;
@end
