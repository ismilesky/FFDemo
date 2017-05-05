//
//  FFBaseShareCenter.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FFAuthInfo.h"
#import "FFUser.h"
#import "ShareContentInfo.h"

#import "NSUserDefaults+FFUserDefaults.h"

typedef void(^ShareSuccessBlock)();
typedef void(^ShareCancelBlock)(BOOL cancelled);
typedef void(^ShareFailureBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, InstallClientType) {
    InstallClientType_None,
    InstallClientType_QQ,
    InstallClientType_QZone,
    InstallClientType_Both_QQ_QZone,
    InstallClientType_Weibo,
    InstallClientType_WeChat
};

typedef enum : NSUInteger {
    SourceAppTypeUnknow,
    SourceAppTypeQQ,
    SourceAppTypeWX,
    SourceAppTypeWB,
} SourceAppType;

extern NSString * const ErrorDescKey;

extern NSString * const QQAppIdKey;
extern NSString * const SinaAppIdKey;
extern NSString * const SinaRedirectURIKey;
extern NSString * const WeChatAppIdKey;
extern NSString * const WeChatAppSecretKey;

@interface FFBaseShareCenter : NSObject
@property (nonatomic, strong) FFUser *user;
@property (nonatomic, strong) FFAuthInfo *authInfo;
@property (nonatomic, strong, readonly) NSDictionary *AppIdDict;
@property (nonatomic, assign, readonly, getter=isInstalledClient) InstallClientType installedClient;

- (void)openClientAuthWithShareType:(ShareType)shareType successBlock:(ShareSuccessBlock)shareSuccessBlock cancelBlock:(ShareCancelBlock)shareCancelBlock failureBlock:(ShareFailureBlock)shareFailureBlock;
+ (SourceAppType)sourceAppTypeWithSourceAppString:(NSString *)sourceApplication;

/**
   在appDelegate，- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 里面实现该方法
 */
+ (BOOL)handlerOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;
/**
 *  设置各平台的AppId、AppSecret、RedirectURI
 *
 *  @param appIdDict       key 为QQAppIdKey,SinaAppIdKey,WeChatAppIdKey value 为各平台AppId
 *  @param appSecretDict   key 为WeChatAppSecretKey,... value为各平台的Secret
 *  @param redirectURIDict key 为SinaRedirectURIKey,... value为各平台的RedirectURI
 */
+ (void)setAppId:(NSDictionary *)appIdDict appSecret:(NSDictionary *)appSecretDict redirectURI:(NSDictionary *)redirectURIDict;

/**
 *  获取分享平台
 *
 *  @param shareType 分享类型
 *  @return 分享平台
 */
+ (FFBaseShareCenter *)getShareCenterWithShareType:(ShareType)shareType;

/**
 *  分享
 *
 *  @param contentInfo  分享信息
 *  @param successBlock 成功回调
 *  @param cancelBlock  取消回调
 *  @param failureBlock 失败回调
 */
- (void)shareContentInfo:(ShareContentInfo *)contentInfo successBlock:(ShareSuccessBlock)successBlock cancelBlock:(ShareCancelBlock)cancelBlock failureBlock:(ShareFailureBlock)failureBlock;
- (void)executeFailureBlock:(ShareFailureBlock)failureBlock errorDomain:(NSString *)ErrorDomain errorMsg:(NSString *)errorMsg errorCode:(NSInteger)errorCode;
@end
