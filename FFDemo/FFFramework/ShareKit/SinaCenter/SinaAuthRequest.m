//
//  SinaAuthRequest.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "SinaAuthRequest.h"

#import "FFUser.h"

#import "FFSinaCenter.h"

@implementation SinaAuthRequest
- (NSString *)getRequestHost {
    return @"https://api.weibo.com/2/users/show.json?";
}

- (NSDictionary *)getDefaultParameters {
    NSString *appId = [NSUserDefaults stringValueForKey:SinaAppIdKey];
    return @{@"source" : appId};
}

- (void)processResult {
    FFUser *user = [[FFUser alloc] initWithWBDict:self.resultDict];
    [FFSinaCenter shareInstance].user = user;
}

@end
