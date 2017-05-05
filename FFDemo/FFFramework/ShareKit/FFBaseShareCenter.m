//
//  FFBaseShareCenter.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseShareCenter.h"

#import "FFKit.h"

#import "FFSinaCenter.h"
#import "FFWeChatCenter.h"
#import "FFTencentCenter.h"

NSString * const SourceApp_QQ   = @"com.tencent.mqq";
NSString * const SourceApp_QQHD = @"com.tencent.mipadqq";
NSString * const SourceApp_WX   = @"com.tencent.xin";
NSString * const SourceApp_WB   = @"com.sina.weibo";
NSString * const SourceApp_WBHD = @"com.sina.weibohd";

NSString * const ErrorDescKey = @"shareErrDesc";

NSString * const QQAppIdKey = @"QQAppIdKey";

NSString * const SinaAppIdKey = @"SinaAppIdKey";
NSString * const SinaRedirectURIKey = @"SinaRedirectURIKey";

NSString * const WeChatAppIdKey = @"WeChatAppIdKey";
NSString * const WeChatAppSecretKey = @"WeChatAppSecretKey";

NSString * const UserDefaultKey = @"User_%@";
NSString * const AuthDefaultKey = @"Auth_%@";

@interface FFBaseShareCenter () {
    FFUser *_user;
    FFAuthInfo *_authInfo;
}

@end

@implementation FFBaseShareCenter 

#pragma mark - Property Method
- (void)setUser:(FFUser *)user {
    _user = user;
    
    NSString *key = [NSString stringWithFormat:UserDefaultKey,[self class]];
    if (user) {
        [FFKit saveData:user forKey:key];
    } else {
        [FFKit deleteObjectForKey:key];
    }
}

- (FFUser *)user {
    NSString *key = [NSString stringWithFormat:UserDefaultKey,[self class]];
    if ([NSUserDefaults isExistsForKey:key]) {
        _user = [FFKit readFFUserForKey:key];
    }
    return _user;
}

- (void)setAuthInfo:(FFAuthInfo *)authInfo {
    _authInfo = authInfo;
    
    NSString *key = [NSString stringWithFormat:AuthDefaultKey,[self class]];
    if (authInfo) {
        [FFKit saveData:authInfo forKey:key];
    } else {
        [FFKit deleteObjectForKey:key];
    }
}

- (FFAuthInfo *)authInfo {
    NSString *key = [NSString stringWithFormat:AuthDefaultKey,[self class]];
    if ([NSUserDefaults isExistsForKey:key]) {
        _authInfo = [FFKit readFFAuthInfoForKey:key];
    }
    return _authInfo;
}

#pragma mark - Method
- (void)openClientAuthWithShareType:(ShareType)shareType successBlock:(ShareSuccessBlock)shareSuccessBlock cancelBlock:(ShareCancelBlock)shareCancelBlock failureBlock:(ShareFailureBlock)shareFailureBlock {
    if (shareType == ShareType_WeChat) {
        [[FFWeChatCenter shareInstance] openWXClientOAuthSuccessBlock:shareSuccessBlock cancelBlock:shareCancelBlock failureBlock:shareFailureBlock];
    } else if (shareType == ShareType_Sina) {
        [[FFSinaCenter shareInstance] openSinaClientOAuthSuccessBlock:shareSuccessBlock cancelBlock:shareCancelBlock failureBlock:shareFailureBlock];
    } else if (shareType == ShareType_QQ) {
        [[FFTencentCenter shareInstance] openQQClientOAuthSuccessBlock:shareSuccessBlock cancelBlock:shareCancelBlock failureBlock:shareFailureBlock];
    }
}

+ (SourceAppType)sourceAppTypeWithSourceAppString:(NSString *)sourceApplication {
    SourceAppType type = SourceAppTypeUnknow;
    if ([sourceApplication isEqualToString:SourceApp_WX]) {
        type = SourceAppTypeWX;
    } else if ([sourceApplication isEqualToString:SourceApp_WB] || [sourceApplication isEqualToString:SourceApp_WBHD]) {
        type = SourceAppTypeWB;
    } else if ([sourceApplication isEqualToString:SourceApp_QQ] || [SourceApp_QQHD isEqualToString:SourceApp_QQHD]) {
        type = SourceAppTypeQQ;
    }
    return type;
}

+ (BOOL)handlerOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    SourceAppType type = [self sourceAppTypeWithSourceAppString:sourceApplication];
    switch (type) {
        case SourceAppTypeWX:
            return [WXApi handleOpenURL:url delegate:[FFWeChatCenter shareInstance]];
        case SourceAppTypeWB:
            return [WeiboSDK handleOpenURL:url delegate:[FFSinaCenter shareInstance]];
        case SourceAppTypeQQ:
            return [TencentOAuth HandleOpenURL:url] || [QQApiInterface handleOpenURL:url delegate:[FFTencentCenter shareInstance]];
        case SourceAppTypeUnknow:
            return NO;
    }
}

+ (void)setAppId:(NSDictionary *)appIdDict appSecret:(NSDictionary *)appSecret redirectURI:(NSDictionary *)redirectURIDict {
    NSAssert(appIdDict, @"未设置AppId");
    [appIdDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self saveToUserDefaultValue:obj forKey:key];
    }];
    [appSecret enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self saveToUserDefaultValue:obj forKey:key];
    }];
    [redirectURIDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self saveToUserDefaultValue:obj forKey:key];
    }];
}

+ (void)saveToUserDefaultValue:(id)obj forKey:(NSString *)key {
    BOOL isExistKey = [NSUserDefaults isExistsForKey:key];
    BOOL isEqualKey = NO;
    if (isExistKey) {
        NSString *value = [NSUserDefaults stringValueForKey:key];
        isEqualKey = [value isEqualToString:obj];
    }
    if (!isEqualKey) {
        [NSUserDefaults setObjectValue:obj forKey:key];
    }
}

- (void)shareContentInfo:(ShareContentInfo *)contentInfo successBlock:(ShareSuccessBlock)successBlock cancelBlock:(ShareCancelBlock)cancelBlock failureBlock:(ShareFailureBlock)failureBlock { }

+ (FFBaseShareCenter *)getShareCenterWithShareType:(ShareType)shareType {
    switch (shareType) {
        case ShareType_None:
            return [FFBaseShareCenter new];
        case ShareType_QQ:
        case ShareType_QZone:
            return [FFTencentCenter shareInstance];
        case ShareType_Sina:
            return [FFSinaCenter shareInstance];
        case ShareType_WeChat:
        case ShareType_WeChatTimeline:
            return [FFWeChatCenter shareInstance];
        case ShareType_Phone:
            return nil;
    }
}

- (void)executeFailureBlock:(ShareFailureBlock)failureBlock errorDomain:(NSString *)ErrorDomain errorMsg:(NSString *)errorMsg errorCode:(NSInteger)errorCode {
    if (failureBlock) {
        NSError *error = [NSError errorWithDomain:ErrorDomain code:errorCode userInfo:@{ErrorDescKey:errorMsg}];
        failureBlock(error);
    }
}


@end
