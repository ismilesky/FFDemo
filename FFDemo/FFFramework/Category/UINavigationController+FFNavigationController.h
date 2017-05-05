//
//  UINavigationController+FFNavigationController.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (FFNavigationController)

/**
  Pop回指定的VC
 */
- (void)popToViewControllerClass:(Class)aClass animated:(BOOL)animated;

@end
