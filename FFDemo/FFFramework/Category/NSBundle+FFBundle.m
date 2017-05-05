//
//  NSBundle+FFBundle.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "NSBundle+FFBundle.h"

@implementation NSBundle (FFBundle)
+ (NSString *)appVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

@end
