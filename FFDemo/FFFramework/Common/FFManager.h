//
//  FFManager.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const LogStatus;

@interface FFManager : NSObject
+ (void)setLogStatus:(BOOL)logStatus;
+ (BOOL)logStatus;
@end
