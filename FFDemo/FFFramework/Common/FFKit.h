//
//  FFKit.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFUser, FFAuthInfo;

@interface FFKit : NSObject
+ (void)saveData:(id)obj forKey:(NSString *)key;
+ (NSData *)readDataForKey:(NSString *)key;
+ (id)readCacheForKey:(NSString *)key;
+ (FFUser *)readFFUserForKey:(NSString *)key;
+ (FFAuthInfo *)readFFAuthInfoForKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;
@end
