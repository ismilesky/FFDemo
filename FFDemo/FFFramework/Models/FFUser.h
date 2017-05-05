//
//  FFUser.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//
/**
  用于第三方登录时设置用户信息
 */

#import "FFBaseModel.h"

typedef NS_ENUM(NSUInteger, Gender) {
    Gender_Man,
    Gender_Woman
};

@interface FFUser : FFBaseModel

@property (nonatomic, strong) NSString *userId;//OAuth -> openId
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) Gender    sex;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *figureUrl;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *password;

- (instancetype)initWithQQDict:(NSDictionary *)dict;
- (instancetype)initWithWXDict:(NSDictionary *)dict;
- (instancetype)initWithWBDict:(NSDictionary *)dict;

@end
