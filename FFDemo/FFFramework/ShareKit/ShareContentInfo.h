//
//  ShareContentInfo.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
/**
  设置分享信息
 */

#import "FFBaseModel.h"
#import "FFAuthInfo.h"

typedef NS_ENUM(NSUInteger, ShareContentType) {
    ShareContentType_None,
    ShareContentType_Text,
    ShareContentType_Link,
    ShareContentType_Image
};

@interface ShareContentInfo : FFBaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSData   *objData;
@property (nonatomic, assign) ShareContentType contentType;
@property (nonatomic, assign) ShareType shareType;

+ (instancetype)shareTitle:(NSString *)title content:(NSString *)content contentType:(ShareContentType)contentType;
+ (instancetype)shareTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imagePath:(NSString *)imgPath contentType:(ShareContentType)contentType;
+ (instancetype)shareTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imagePath:(NSString *)imgPath objData:(NSData *)objData contentType:(ShareContentType)contentType;
@end