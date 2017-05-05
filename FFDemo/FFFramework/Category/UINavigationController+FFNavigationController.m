//
//  UINavigationController+FFNavigationController.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "UINavigationController+FFNavigationController.h"

@implementation UINavigationController (FFNavigationController)
- (void)popToViewControllerClass:(Class)aClass animated:(BOOL)animated {
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isMemberOfClass:aClass]) {
            [self popToViewController:vc animated:animated];
        }
    }
}
@end
