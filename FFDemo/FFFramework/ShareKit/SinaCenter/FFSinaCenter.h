//
//  FFSinaCenter.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseShareCenter.h"

#import "WeiboSDK.h"

@interface FFSinaCenter : FFBaseShareCenter <WeiboSDKDelegate>
@property (nonatomic, assign, readonly, getter=isInstalledWeibo) BOOL installedWeibo;

+ (instancetype)shareInstance;
- (void)openSinaClientOAuthSuccessBlock:(ShareSuccessBlock)successBlock cancelBlock:(ShareCancelBlock)cancelBlock failureBlock:(ShareFailureBlock)failureBlock;
@end
