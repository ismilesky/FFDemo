//
//  WXAuthRequest.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseRequest.h"

@interface WXAuthRequest : FFBaseRequest
//code
//appid
//secret
@end

@interface WXRefreshAccessTokenRequest : FFBaseRequest
//appid
//refresh_token
@end

@interface WXGetUserInfoReqeust : FFBaseRequest
//access_token
//openid
@end
