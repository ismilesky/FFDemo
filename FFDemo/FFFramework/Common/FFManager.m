//
//  FFManager.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFManager.h"
#import "NSUserDefaults+FFUserDefaults.h"

NSString * const LogStatus = @"LogStatus";

@implementation FFManager
+ (void)setLogStatus:(BOOL)logStatus{
    [NSUserDefaults setBoolValue:logStatus forKey:LogStatus];
}

+ (BOOL)logStatus{
    if ([NSUserDefaults isExistsForKey:LogStatus]) {
        return [NSUserDefaults boolValueForKey:LogStatus];
    }
    return YES;
}

@end
