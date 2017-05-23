//
//  UIColor+HexClolor.h
//  ComicPhoto
//
//  Created by VS on 2017/5/22.
//  Copyright © 2017年 com.ifenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexClolor)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
