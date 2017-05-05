//
//  TestRequest.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "TestRequest.h"

//#import "UIDevice+FFDevice.h"
//#import "NSBundle+FFBundle.h"

// 以豆瓣的接口为例
NSString * const FORMAL_SERVER_URL = @"https://api.douban.com/v2/";    // 正式服务器
NSString * const TEST_SERVER_URL = @"https://api.douban.com/v2/";   // 测试服务器

@implementation TestRequest
#pragma mark - Methods
- (NSString *)getRequestHost {
    return FORMAL_SERVER_URL;
    //    return TEST_SERVER_URL;
}

//- (NSDictionary *)getDefaultParameters {   // 默认参数，可自行决定
//    NSMutableDictionary *defaultParamDict = [NSMutableDictionary dictionary];
//    [defaultParamDict setObject:[UIDevice iphoneType] forKey:@"device"];
//    [defaultParamDict setObject:[NSBundle appVersion] forKey:@"ver"];
//    return defaultParamDict;
//}
//
//- (NSString *)getUserAgent {
//    NSString *agent = [NSString stringWithFormat:@"phone_version:%@; ios_version:%@; app_version:%@;", [UIDevice iphoneType], [UIDevice osVersion], [NSBundle appVersion]];
//    return agent;
//}

- (BOOL)isSuccess {
    return [self success];
}

- (BOOL)success {
    if ([self.resultDict.allKeys containsObject:@"status"]) {
        NSDictionary *dict = self.resultDict[@"status"];
        NSInteger code = [[NSString stringWithFormat:@"%@", dict[@"code"]] integerValue];
        return code == 1;
    }
    return false;
}

- (NSString *)errorMsg {
    if ([self.resultDict.allKeys containsObject:@"status"]) {
        NSDictionary *dict = self.resultDict[@"status"];
        return dict[@"msg"];
    }
    return @"";
}


#pragma mark - 可根据具体返回数据设置相关属性
- (NSInteger)totalCount {
    return [self.resultDict[@"total"] integerValue];
}

@end
