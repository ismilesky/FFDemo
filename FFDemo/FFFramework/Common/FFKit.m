//
//  FFKit.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFKit.h"
#import "FFUser.h"
#import "FFAuthInfo.h"

#import "FFConst.h"

#import "NSUserDefaults+FFUserDefaults.h"

@implementation FFKit
+ (void)saveData:(id)obj forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [NSUserDefaults setObjectValue:data forKey:key];
}

+ (NSData *)readDataForKey:(NSString *)key {
    return [NSUserDefaults dataValueForKey:key];
}

+ (id)readCacheForKey:(NSString *)key {
    NSData *data = [NSUserDefaults dataValueForKey:key];
    if (data) {
        @try {
            id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return obj;
        }
        @catch (NSException *exception) {
            FFLog(@"readCacheForKey:%@, error:%@",key, exception);
        }
        @finally {
            
        }
    }
    return nil;
}

+ (FFUser *)readFFUserForKey:(NSString *)key {
    NSData *data = [self readDataForKey:key];
    FFUser *user = data == nil ? nil : [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

+ (FFAuthInfo *)readFFAuthInfoForKey:(NSString *)key {
    NSData *data = [self readDataForKey:key];
    FFAuthInfo *authInfo = data == nil ? nil : [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return authInfo;
}

+ (void)deleteObjectForKey:(NSString *)key {
    [NSUserDefaults removeObjectForKey:key];
}

@end
