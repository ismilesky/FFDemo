//
//  FFUser.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFUser.h"
#import "FFAuthInfo.h"

@implementation FFUser
- (instancetype)initWithQQDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _userType = [NSString stringWithFormat:@"%d",ShareType_QQ];
        _nick = dict[@"nickname"];
        _sex = [dict[@"gender"] isEqualToString:@"男"] ? Gender_Man : Gender_Woman;
        _address = [NSString stringWithFormat:@"%@ %@",dict[@"province"],dict[@"city"]];
        _figureUrl = dict[@"figureurl_qq_2"];
    }
    return self;
}

- (instancetype)initWithWXDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _userType = [NSString stringWithFormat:@"%d",ShareType_WeChat];
        _nick = dict[@"nickname"];
        _sex  = [dict[@"sex"] integerValue] == 1 ? Gender_Man : Gender_Woman;
        _address = [NSString stringWithFormat:@"%@ %@",dict[@"province"],dict[@"city"]];
        _figureUrl = dict[@"headimgurl"];
    }
    return self;
}

- (instancetype)initWithWBDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _userId = [NSString stringWithFormat:@"%@", dict[@"id"]];
        _userType = [NSString stringWithFormat:@"%d",ShareType_Sina];
        _nick = dict[@"name"];
        _sex = [dict[@"gender"] isEqualToString:@"m"] ? Gender_Man : Gender_Woman;
        _address = dict[@"location"];
        _figureUrl = dict[@"avatar_large"];
    }
    return self;
}

@end
