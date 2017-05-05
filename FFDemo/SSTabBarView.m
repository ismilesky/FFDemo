//
//  SSTabBarView.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "SSTabBarView.h"

#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"
#import "Test5ViewController.h"

@implementation SSTabBarView

- (IBAction)onButtonTouched:(id)sender {
    [super onButtonTouched:sender];
}

- (NSArray<Class> *)getViewControllersClass {
    return @[[Test1ViewController class],[Test2ViewController class],[Test3ViewController class],[Test4ViewController class], [Test5ViewController class]];
}

+ (instancetype)getCPTabBar {
    return (SSTabBarView *)[super getTabBarView];
}
@end
