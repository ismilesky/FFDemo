//
//  UIDevice+FFDevice.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (FFDevice)
+ (NSString *)osVersion;
+ (NSString *)model;
+ (BOOL)supportIphone;
+ (NSString *)iphoneType;
+ (BOOL)isPad;
@end
