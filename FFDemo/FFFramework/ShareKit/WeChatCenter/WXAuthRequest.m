//
//  WXAuthRequest.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "WXAuthRequest.h"

#import "FFWeChatCenter.h"

@implementation WXAuthRequest
- (NSString *)getRequestHost {
    return @"https://api.weixin.qq.com/sns/oauth2/access_token?grant_type=authorization_code&";
}

- (NSDictionary *)getDefaultParameters {
    NSString *wxAppId = [NSUserDefaults stringValueForKey:WeChatAppIdKey];
    NSString *wxSecret = [NSUserDefaults stringValueForKey:WeChatAppSecretKey];
    return @{@"appid": wxAppId,@"secret": wxSecret};
}

- (void)processResult {
    BOOL isError = [self.resultDict.allKeys containsObject:@"errcode"];
    if (isError) {
        
    } else {
        FFAuthInfo *authInfo = [FFAuthInfo new];
        authInfo.openId = self.resultDict[@"openid"];
        authInfo.accessToken = self.resultDict[@"access_token"];
        authInfo.expiresDate = self.resultDict[@"expires_in"];
        authInfo.refreshToken = self.resultDict[@"refresh_token"];
        authInfo.unionId = self.resultDict[@"unionid"];
        [FFWeChatCenter shareInstance].authInfo = authInfo;
    }
}
@end

@implementation WXRefreshAccessTokenRequest
- (NSString *)getRequestHost {
    return @"https://api.weixin.qq.com/sns/oauth2/refresh_token?grant_type=refresh_token";
}

- (NSDictionary *)getDefaultParameters {
    NSString *wxAppId = [NSUserDefaults stringValueForKey:WeChatAppIdKey];
#warning 未完成
    return @{@"appid": wxAppId, @"refresh_token":@""};
}

@end

@implementation WXGetUserInfoReqeust

- (NSString *)getRequestHost {
    return @"https://api.weixin.qq.com/sns/userinfo?";
}

- (void)processResult {
    FFUser *user = [[FFUser alloc] initWithWXDict:self.resultDict];
    NSString *unionIdKey = @"unionid";
    user.userId = [self.resultDict.allKeys containsObject:unionIdKey] ? self.resultDict[unionIdKey] : @"";
    [FFWeChatCenter shareInstance].user = user;
}
@end
