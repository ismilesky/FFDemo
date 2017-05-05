//
//  FFBaseDownloadRequest.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFBaseDownloadRequest;

extern NSString * const FFDownloadErrorReasonKey;
extern NSString * const FFDownloadDoDownloadBlockKey;
extern NSString * const FFDownloadAllowUseMobileNetworkKey;
extern NSString * const FFDownloadAllowUseMobileNetworkNotification;


typedef void(^ProgressBlock)(float progress, NSUInteger bytesRead, unsigned long long totalRead, unsigned long long totalExpectedToRead);
typedef void(^SuccessBlock)(FFBaseDownloadRequest *request, id responseObject);
typedef void(^CancelBlock)(FFBaseDownloadRequest *request);
typedef void(^FailureBlock)(FFBaseDownloadRequest *request, NSError *error);

@interface FFBaseDownloadRequest : NSObject
/**
 * 下载路径(文件夹)
 */
@property (nonatomic, strong, readonly) NSString *downloadPath;
@property (nonatomic, strong, readonly) NSString *fileName;
/**
 * 下载文件绝对路径
 */
@property (nonatomic, strong, readonly) NSString *filePath;

/**
 *  下载文件
 *
 *  @param URLStirng     文件链接
 *  @param fileName      文件名
 *  @param progressBlock 下载进度回调
 *  @param successBlock  下载成功回调
 *  @param failureBlock  下载失败回调
 *
 *  @return 下载任务
 */
+ (FFBaseDownloadRequest *)downloadFileWithURLString:(NSString *)URLStirng
                                        fileName:(NSString *)fileName
                                   progressBlock:(ProgressBlock)progressBlock
                                    successBlock:(SuccessBlock)successBlock
                                     cancelBlock:(CancelBlock)cancelBlock
                                    failureBlock:(FailureBlock)failureBlock;
/**
 *  下载文件
 *
 *  @param URLStirng     文件链接
 *  @param fileName      文件名
 *  @param downloadPath  下载位置
 *  @param progressBlock 下载进度回调
 *  @param successBlock  下载成功回调
 *  @param failureBlock  下载失败回调
 *
 *  @return 下载任务
 */
+ (FFBaseDownloadRequest *)downloadFileWithURLString:(NSString *)URLStirng
                                    downloadPath:(NSString *)downloadPath
                                        fileName:(NSString *)fileName
                                   progressBlock:(ProgressBlock)progressBlock
                                    successBlock:(SuccessBlock)successBlock
                                     cancelBlock:(CancelBlock)cancelBlock
                                    failureBlock:(FailureBlock)failureBlock;

/**
 *  暂停下载文件
 *
 *  @param downloadRequest 下载任务
 */
+ (void)pauseWithDownloadRequest:(FFBaseDownloadRequest *)downloadRequest;

/**
 *  恢复下载文件
 *
 *  @param downloadRequest 下载请求
 */
+ (void)resumeWithDownloadRequest:(FFBaseDownloadRequest *)downloadRequest;

/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
- (unsigned long long)fileSizeForPath:(NSString *)path;
/**
 * 暂停下载
 */
- (void)pauseDownload;
/**
 * 恢复下载
 */
- (void)resumeDownload;
/**
 * 取消下载
 */
- (void)cancelDownload;
/**
 * 是否正在下载
 */
- (BOOL)isDownloading;
/**
 * 是否完成
 */
- (BOOL)finished;
/**
 * 移除Cache
 */
+ (void)removeAllCache;

@end
