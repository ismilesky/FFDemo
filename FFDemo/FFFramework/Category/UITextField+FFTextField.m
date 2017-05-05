//
//  UITextField+FFTextField.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "UITextField+FFTextField.h"
#import <objc/runtime.h>

NSString * const FFTextFieldDidDeleteBackwardNotification = @"com.textfield.did.notification";

@implementation UITextField (FFTextField)

+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(ff_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)ff_deleteBackward {
    [self ff_deleteBackward];
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        id <FFTextFieldDelegate> delegate  = (id<FFTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FFTextFieldDidDeleteBackwardNotification object:self];
}

@end
