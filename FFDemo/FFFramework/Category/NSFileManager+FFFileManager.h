//
//  NSFileManager+FFFileManager.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (FFFileManager)
+ (BOOL)isDirectoryExist:(NSString *)path;
+ (BOOL)isFileExistAtPath:(NSString *)path;
+ (BOOL)isEmptyFolderWithPath:(NSString *)path error:(NSError **)error;
+ (BOOL)deleteFileAtPath:(NSString *)path isDirectory:(BOOL)isDir;
+ (BOOL)createDirectorysAtPath:(NSString *)path;
/**
 * 获得文件夹大小
 */
+ (long long)folderSizeAtPath:(NSString*)folderPath;
/**
 * 获得单个文件大小
 */
+ (long long)fileSizeAtPath:(NSString*)filePath;
/**
 * 转换大小单位
 */
+ (NSString *)sizeFormatByteCount:(long long)size;

@end
