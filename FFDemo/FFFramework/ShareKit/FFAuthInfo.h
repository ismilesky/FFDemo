//
//  FFAuthInfo.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseModel.h"

typedef NS_ENUM(NSUInteger, ShareType) {
    ShareType_None = 0,
    ShareType_WeChat = 1,
    ShareType_QQ = 2,
    ShareType_Sina = 3,
    ShareType_QZone,
    ShareType_WeChatTimeline,
    ShareType_Phone
};

@interface FFAuthInfo : FFBaseModel
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *expiresDate;
/**
 *  wechat使用
 */
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *unionId;

@end
