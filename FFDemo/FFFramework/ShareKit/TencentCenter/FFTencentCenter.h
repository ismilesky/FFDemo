//
//  FFTencentCenter.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseShareCenter.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface FFTencentCenter : FFBaseShareCenter <TencentSessionDelegate,QQApiInterfaceDelegate>

@property (nonatomic, assign, readonly, getter=isInstalledQQ) BOOL installedQQ;
@property (nonatomic, assign, readonly, getter=isInstalledQZone) BOOL installedQZone;

+ (instancetype)shareInstance;
- (void)openQQClientOAuthSuccessBlock:(ShareSuccessBlock)successBlock cancelBlock:(ShareCancelBlock)cancelBlock failureBlock:(ShareFailureBlock)failureBlock;
- (void)openQZoneClientOAuth;
@end
