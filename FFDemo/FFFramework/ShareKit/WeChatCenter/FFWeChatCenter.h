//
//  FFWeChatCenter.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseShareCenter.h"

#import "WXApi.h"

@interface FFWeChatCenter : FFBaseShareCenter <WXApiDelegate>
@property (nonatomic, assign, readonly, getter=isInstalledWeChat) BOOL installedWeChat;

+ (instancetype)shareInstance;
- (void)openWXClientOAuthSuccessBlock:(ShareSuccessBlock)successBlock cancelBlock:(ShareCancelBlock)cancelBlock failureBlock:(ShareFailureBlock)failureBlock;
@end
