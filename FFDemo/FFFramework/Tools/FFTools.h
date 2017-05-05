//
//  FFTools.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FFTools : NSObject
/**
 *  日期时间
 */
+ (NSDictionary *)getCurrentDate;

/**
 *  去除字符串首尾空格换行
 */
+ (NSString *)trimmedString:(NSString *)str;

/**
 *  计算文本尺寸
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  MD5加密
 *  @param str 要加密的字符串
 *  @return 加密后的值
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  遍历文件夹中文件
 *  @param path 遍历的文件夹
 */
+ (void)readFolderFiles:(NSString *)path;

#pragma mark - 正则匹配
/**
 *  手机正则
 */
+ (BOOL) validateMobile:(NSString *)mobile;
/**
 *  邮箱正则
 */
+ (BOOL) validateEmail:(NSString *)email;
/**
 *  身份证正则
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/**
 *  银行卡号正则
 */
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

/**
 *  Json转字典
 */
+ (NSDictionary *)jsonToDict:(NSString *)jsonString;
/**
 *  字典转Json
 */
+ (NSString*)dictToJson:(NSDictionary *)dic;

@end
