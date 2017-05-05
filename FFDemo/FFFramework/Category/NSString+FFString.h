//
//  NSString+FFString.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FFString)
+ (BOOL)isNilOrEmpty:(NSString *)str;
- (NSString *)md5Str;
+ (NSString *)GUIDString;
@end
