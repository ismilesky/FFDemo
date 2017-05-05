//
//  FFBaseDownloadModel.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseDownloadModel.h"
#import "NSString+FFString.h"

NSString * const ZeroSpeedString = @"0 b/s";

@interface FFBaseDownloadModel ()
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *saveFilePath;
@property (nonatomic, assign) DownloadStatus status;

@property (nonatomic, assign) long long totalExpectedToRead;
@property (nonatomic, assign) long long totalRead;
@property (nonatomic, assign) NSUInteger bytesRead;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) NSUInteger totalBytes;
@property (nonatomic, assign) long long byteSpeed;
@property (nonatomic, strong) NSDate *lastReadDate;

@property (nonatomic, strong) FFBaseDownloadRequest *request;
@end

@implementation FFBaseDownloadModel
- (instancetype)initWithDownloadUrlStr:(NSString *)urlStr
                       andSaveFilePath:(NSString *)saveFilePath
                              fileName:(NSString *)fileName {
    self = [super init];
    if (self) {
        self.urlStr = urlStr;
        self.fileName = fileName;
        self.saveFilePath = saveFilePath;
        self.status = DownloadStatusNormal;
    }
    return self;
}

#pragma mark - Property Method
- (NSString *)urlStr {
    return _urlStr;
}

- (NSString *)fileName {
    return _fileName;
}

- (NSString *)saveFilePath {
    return _saveFilePath;
}

- (DownloadStatus)status {
    return _status;
}

- (long long)totalExpectedToRead {
    return _totalExpectedToRead;
}

- (long long)totalRead {
    return _totalRead;
}

- (NSUInteger)bytesRead {
    return _bytesRead;
}

- (float)progress {
    return _progress;
}

- (NSString *)speed {
    NSString *speed = self.byteSpeed == 0 ? @"0 KB" : [NSByteCountFormatter stringFromByteCount:self.byteSpeed countStyle:NSByteCountFormatterCountStyleFile];
    return [NSString stringWithFormat:@"%@/s", speed];
}

- (NSDate *)lastReadDate {
    if (!_lastReadDate) {
        _lastReadDate = [NSDate date];
    }
    return _lastReadDate;
}

#pragma mark - Private Method
- (BOOL)checkUrlAndSavePathEmpty {
    BOOL isEmpty = NO;
    isEmpty = [NSString isNilOrEmpty:self.urlStr];
    isEmpty = isEmpty || [NSString isNilOrEmpty:self.saveFilePath];
    return isEmpty;
}

- (void)doDownload {
    self.request = [FFBaseDownloadRequest downloadFileWithURLString:self.urlStr
                                                   downloadPath:self.saveFilePath
                                                       fileName:self.fileName
                                                  progressBlock:^(float progress, NSUInteger bytesRead, unsigned long long totalRead, unsigned long long totalExpectedToRead) {
                                                      self.totalBytes += bytesRead;
                                                      NSDate *currentDate = [NSDate date];
                                                      //时间差
                                                      double time = [currentDate timeIntervalSinceDate:self.lastReadDate];
                                                      if (time >= 1) {
                                                          long long speed = self.totalBytes * 1.0 / time;
                                                          self.byteSpeed = speed;
                                                          self.totalBytes = 0.0;
                                                          self.lastReadDate = currentDate;
                                                      }
                                                      self.progress = progress;
                                                      self.bytesRead = bytesRead;
                                                      self.totalRead = totalRead;
                                                      self.totalExpectedToRead = totalExpectedToRead;
                                                      if (self.progressBlock) {
                                                          self.progressBlock(progress, bytesRead, totalRead, totalExpectedToRead);
                                                      }
                                                  }
                                                   successBlock:self.successBlock
                                                    cancelBlock:self.cancelBlock
                                                   failureBlock:self.failureBlock];
    if (self.request) {
        self.status = DownloadStatusDownloading;
    }
}

- (void)resetInfo {
    self.byteSpeed = 0;
}

#pragma mark - Public Method
- (void)start {
    if ([self checkUrlAndSavePathEmpty]) {
        self.status = DownloadStatusFailed;
        return;
    }
    if (self.status == DownloadStatusFinished || self.status == DownloadStatusDownloading) {
        return;
    }
    [self doDownload];
}

- (void)pause {
    if (self.status == DownloadStatusDownloading) {
        [self.request pauseDownload];
    }
    self.status = DownloadStatusPause;
    [self resetInfo];
}

- (void)cancel {
    self.status = DownloadStatusWait;
    if (self.request == nil) {
        return;
    }
    [self.request cancelDownload];
    [self resetInfo];
}

- (void)setDownloadStatus:(DownloadStatus)status {
    self.status = status;
}

- (void)setDownloadProgress:(CGFloat)progress {
    self.progress = progress;
}

@end
