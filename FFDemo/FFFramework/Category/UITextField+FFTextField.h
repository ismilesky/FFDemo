//
//  UITextField+FFTextField.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const FFTextFieldDidDeleteBackwardNotification;

@protocol FFTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (FFTextField)
@property (weak, nonatomic) id<FFTextFieldDelegate> delegate;
@end
