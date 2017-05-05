//
//  FFBaseDownloadRequest.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseDownloadRequest.h"

#import "FFBaseRequest.h"

#import "FFConst.h"

#import "AFNetworking.h"

#import "NSFileManager+FFFileManager.h"
#import "NSUserDefaults+FFUserDefaults.h"

static NSString *FFDownloadErrorDomain = @"FFDownloadErrorDomain";
NSString * const FFDownloadErrorReasonKey = @"FFDownloadErrorReasonKey";
NSString * const FFDownloadDoDownloadBlockKey = @"FFDownloadDoDownloadBlockKey";
NSString * const FFDownloadAllowUseMobileNetworkKey = @"FFDownloadAllowUseMobileNetworkKey";
NSString * const FFDownloadAllowUseMobileNetworkNotification = @"FFDownloadAllowUseMobileNetworkNotification";

static NSString *FFOperationKey = @"operation";
static NSString *FFPathKey = @"path";

@interface FFBaseDownloadRequest () {
    SuccessBlock    _successBlock;
    CancelBlock     _cancelBlock;
    FailureBlock    _failureBlock;
    ProgressBlock   _progressBlock;
    NSString        *_urlString;
    NSString        *_downloadPath;
    NSString        *_fileName;
    NSString        *_filePath;
}
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, assign, getter=isCancelDownload) BOOL cancelDownload;
@end

@implementation FFBaseDownloadRequest
#pragma mark - Lifycycle
- (instancetype)initWithUrlString:(NSString *)urlString
                     downloadPath:(NSString *)downloadPath
                         fileName:(NSString *)fileName
                    progressBlock:(ProgressBlock)progressBlock
                     successBlock:(SuccessBlock)successBlock
                      cancelBlock:(CancelBlock)cancelBlock
                     failureBlock:(FailureBlock)failureBlock {
    self = [super init];
    if (self) {
        _progressBlock  = progressBlock;
        _successBlock   = successBlock;
        _cancelBlock    = cancelBlock;
        _failureBlock   = failureBlock;
        _urlString = urlString;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlReqeust = [NSURLRequest requestWithURL:url];
        _operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlReqeust];
        
        downloadPath = downloadPath ?: kCachePath;
        _downloadPath = downloadPath;
        _fileName = fileName;
        _filePath = [downloadPath stringByAppendingPathComponent:fileName];
        
        BOOL isWIFI = [FFBaseRequest fetchReachabilityStatus] == FFNetworkReachabilityStatusReachableViaWiFi;
        BOOL isAllowUseMobileNetwork = [NSUserDefaults boolValueForKey:FFDownloadAllowUseMobileNetworkKey];
        if (isWIFI) {
            [self doDownloadWithPath:_downloadPath fileName:_fileName];
        } else if (isAllowUseMobileNetwork) {
            [self doDownloadWithPath:_downloadPath fileName:_fileName];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:FFDownloadAllowUseMobileNetworkNotification object:nil userInfo:nil];
        }
    }
    return self;
}

#pragma mark - Property Method
- (NSMutableArray *)paths {
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (NSString *)downloadPath {
    return _downloadPath;
}

- (NSString *)fileName {
    return _fileName;
}

- (NSString *)filePath {
    return _filePath;
}

#pragma mark - Method
- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

+ (FFBaseDownloadRequest *)downloadFileWithURLString:(NSString *)URLStirng
                                        fileName:(NSString *)fileName
                                   progressBlock:(ProgressBlock)progressBlock
                                    successBlock:(SuccessBlock)successBlock
                                     cancelBlock:(CancelBlock)cancelBlock
                                    failureBlock:(FailureBlock)failureBlock {
    return [self downloadFileWithURLString:URLStirng
                              downloadPath:nil
                                  fileName:fileName
                             progressBlock:progressBlock
                              successBlock:successBlock
                               cancelBlock:cancelBlock
                              failureBlock:failureBlock];
}

+ (instancetype)downloadFileWithURLString:(NSString *)URLStirng
                             downloadPath:(NSString *)downloadPath
                                 fileName:(NSString *)fileName
                            progressBlock:(ProgressBlock)progressBlock
                             successBlock:(SuccessBlock)successBlock
                              cancelBlock:(CancelBlock)cancelBlock
                             failureBlock:(FailureBlock)failureBlock {
    if (STR_ISNULL_OR_EMPTY(URLStirng)) {
        NSError *error = [NSError errorWithDomain:FFDownloadErrorDomain code:-100 userInfo:@{FFDownloadErrorReasonKey : @"下载地址不能为空"}];
        if (failureBlock) {
            failureBlock(nil,error);
        }
        return nil;
    }
    if (STR_ISNULL_OR_EMPTY(fileName)) {
        NSError *error = [NSError errorWithDomain:FFDownloadErrorDomain code:-101 userInfo:@{FFDownloadErrorReasonKey : @"文件名不能为空"}];
        if (failureBlock) {
            failureBlock(nil, error);
        }
        return nil;
    }
    return [[self alloc] initWithUrlString:URLStirng
                              downloadPath:downloadPath
                                  fileName:fileName
                             progressBlock:progressBlock
                              successBlock:successBlock
                               cancelBlock:cancelBlock failureBlock:failureBlock];
}

- (void)doDownloadWithPath:(NSString *)downloadPath fileName:(NSString *)fileName {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    unsigned long long downloadedBytes = 0;
    if (![NSFileManager isDirectoryExist:downloadPath]) {
        [NSFileManager createDirectorysAtPath:downloadPath];
    } else if ([NSFileManager isFileExistAtPath:_filePath]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:_filePath];
        //检查文件是否已经下载了一部分
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-",downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    //下载请求
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //检查是否已经有该下载任务，如果有，释放掉...
    for (NSDictionary *dict in self.paths) {
        if ([_filePath isEqualToString:dict[FFPathKey]] && ![(AFHTTPRequestOperation *)dict[FFOperationKey] isPaused]) {
            
        } else {
            [(AFHTTPRequestOperation *)dict[FFOperationKey] cancel];
        }
    }
    NSDictionary *dictNew = @{FFPathKey : fileName,
                              FFOperationKey : _operation};
    [self.paths addObject:dictNew];
    //下载路径
    self.operation.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:YES];
    __block typeof(self) WS = self;
    //下载进度回调
    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        if (WS->_progressBlock) {
            float downloadMB = (totalBytesRead + downloadedBytes) / 1024 / 1024.0f;
            float totalMB = (totalBytesExpectedToRead + downloadedBytes) / 1024 / 1024.0f;
            float progress = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
            WS->_progressBlock(progress, downloadMB, totalMB, totalBytesExpectedToRead);
        }
    }];
    
    [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (WS->_successBlock) {
            WS->_successBlock(WS, responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (WS.isCancelDownload) {
            if (WS->_cancelBlock) {
                WS->_cancelBlock(WS);
            }
            WS.cancelDownload = NO;
        } else {
            if (WS->_failureBlock) {
                WS->_failureBlock(WS, error);
            }
        }
    }];
    [self.operation start];
}

+ (void)pauseWithDownloadRequest:(FFBaseDownloadRequest *)downloadRequest {
    [downloadRequest pauseDownload];
}

+ (void)resumeWithDownloadRequest:(FFBaseDownloadRequest *)downloadRequest {
    [downloadRequest resumeDownload];
}

- (void)pauseDownload {
    [self.operation pause];
}

- (void)resumeDownload {
    [self.operation resume];
}

- (void)cancelDownload {
    [_operation cancel];
    self.cancelDownload = YES;
}

- (BOOL)isDownloading {
    return [_operation isExecuting];
}

- (BOOL)finished {
    return [_operation isFinished];
}

+ (void)removeAllCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
