//
//  FFTools.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFTools.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation FFTools
/**
*  日期时间
*/
+ (NSDictionary *)getCurrentDate
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDate *date = [NSDate date];
    //获得日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //通过日历对象获得日期组件对象NSDateComponents
    NSUInteger units =  NSYearCalendarUnit  |
    NSMonthCalendarUnit |
    NSDayCalendarUnit   |
    NSHourCalendarUnit  |
    NSMinuteCalendarUnit|
    NSSecondCalendarUnit;
    NSDateComponents *components = [calender components:units fromDate:date];
    //格式化字符串
    NSString *strDate = [NSString stringWithFormat:@"%04ld-%02ld-%02ld",
                         (long)[components year ],
                         (long)[components month],
                         (long)[components day  ]];
    NSString *strTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",
                         (long)[components hour  ],
                         (long)[components minute],
                         (long)[components second]];
    dict[@"time"] = strTime;
    dict[@"date"] = strDate;
    return dict;
}
#pragma mark - 正则匹配
//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

#pragma mark -
+ (NSString *)trimmedString:(NSString *)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGRect rect =  [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

+ (NSString *)md5:(NSString *)str {
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    };
    return [hash lowercaseString];
}

+ (void)readFolderFiles:(NSString *)path {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self readFolderFiles:subPath];
            }
        }else{
            //            NSRange range = [path rangeOfString:@"BgMusic/"];
            //            NSString * result = [path substringFromIndex:range.location+8];
            NSLog(@"%@",path);
        }
    }else{
        NSLog(@"你打印的是目录或者不存在");
    }
}

/*
 * JSON格式的字符串转换成字典
 */
+ (NSDictionary *)jsonToDict:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *JSONData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    //    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //    NSError *err;
    //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
    //                                                        options:NSJSONReadingMutableContainers
    //                                                          error:&err];
    //    if(err) {
    //        return nil;
    //    }
    return dic;
}

+ (NSString*)dictToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
