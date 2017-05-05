//
//  NSDate+FFDate.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FFDate)
+ (NSString *)secondFormatTime:(NSInteger)totalSecond;
+ (NSString *)secondFormatTime:(NSInteger)totalSecond hasHour:(BOOL)hasHour;
+ (NSString *)date:(NSString *)dateStr dateFormat:(NSString *)dateFormat withFormat:(NSString *)targetFormat;
+ (NSString *)getTimeFormatWithTimestamp:(NSString *)timestamp format:(NSString *)format; // 时间戳
+ (NSString *)dateWithTimeStamp:(NSString *)timeStamp format:(NSString *)format;
- (NSString *)dateWithFormat:(NSString *)format;

+ (NSInteger)getCurrentYear;
+ (NSInteger)getCurrentMounth;
+ (NSInteger)getCurrentDay;
+ (NSInteger)getCurrentHour;
+ (NSInteger)getCurrentMinute;
+ (NSInteger)getCurrentSecond;
+ (NSInteger)getCurrentWeekday;
+ (NSDateComponents *)getCurrentDateDetail;

@end
