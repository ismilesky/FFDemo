//
//  NSUserDefaults+FFUserDefaults.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (FFUserDefaults)
+ (void)setBoolValue:(BOOL)value forKey:(NSString *)defaultName;
+ (void)setObjectValue:(id)value forKey:(NSString *)defauletName;
+ (void)setValue:(id)value forKey:(NSString *)defauletName;
+ (void)setIntegerValue:(NSInteger)value forKey:(NSString *)defaultName;
+ (BOOL)boolValueForKey:(NSString *)defaultName;
+ (NSString *)stringValueForKey:(NSString *)defaultName;
+ (NSInteger)integerValueForKey:(NSString *)defaultName;
+ (NSData *)dataValueForKey:(NSString *)defaultName;
+ (BOOL)isExistsForKey:(NSString *)defaultName;
+ (void)removeObjectForKey:(NSString *)defaultName;
+ (NSArray *)arrayValueForKey:(NSString *)defaultName;
+ (NSMutableArray *)mutableArrayValueForKey:(NSString *)defaultName;
@end
