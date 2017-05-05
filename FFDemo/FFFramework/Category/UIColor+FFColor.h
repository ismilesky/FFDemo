//
//  UIColor+FFColor.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FFColor)

/**
    从十六进制字符串获取颜色，
    color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
