//
//  AliyunOSSManager.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "AliyunOSSManager.h"

#import <AliyunOSSiOS/OSSService.h>
// 阿里云申请的AccessKey，SecretKey
NSString * const AliyunAccessKey = @"111111 ";
NSString * const AliyunSecretKey = @"111122 ";
NSString * const AliyunEndpoint  = @"http://oss-cn-hangzhou.aliyuncs.com";

// 正式：storybook 测试：ttest2
//NSString * const AliyunBucketName= @"ttest";     // 测试
NSString * const AliyunBucketName= @"formal";  // 正式

NSString * const AliyunCompletedErrorInfoKey = @"AliyunCompletedErrorInfoKey";

static AliyunOSSManager *instance = nil;

@interface AliyunOSSManager () {
    BOOL _cancelled;
}
@property (nonatomic, strong) OSSClient *client;
@property (nonatomic, copy) OSSMProgressUploadBlock progressBlock;
@property (nonatomic, copy) OSSMCompletedBlock completedBlock;
@property (nonatomic, strong) NSArray<OSSObjectModel *> *objects;
@end

@implementation AliyunOSSManager

#pragma mark - Property Method
- (OSSClient *)client {
    if (!_client) {
        id<OSSCredentialProvider> credentialPro = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AliyunAccessKey secretKey:AliyunSecretKey];
        _client = [[OSSClient alloc] initWithEndpoint:AliyunEndpoint credentialProvider:credentialPro];
    }
    return _client;
}

- (BOOL)isAllCompleted {
    BOOL result = YES;
    for (OSSObjectModel *item in self.objects) {
        if (!item.isUploadCompleted) {
            result = NO;
            break;
        }
    }
    return result;
}

- (BOOL)isCanceled {
    return _cancelled;
}

#pragma mark - Method
- (void)uploadFileWithOSSObject:(OSSObjectModel *)ossObjModel hasError:(BOOL **)hasError {
    OSSPutObjectRequest *putReq = [OSSPutObjectRequest new];
    putReq.bucketName = AliyunBucketName;
    putReq.objectKey = ossObjModel.fileName;
    switch (ossObjModel.objType) {
        case OSSObjectTypeBinary:
            putReq.uploadingData = ossObjModel.objData;
            break;
        case OSSObjectTypeFileUrl:
            putReq.uploadingFileURL = ossObjModel.fileUrl;
            break;
    }
    __weak typeof(self) WS = self;
    putReq.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        if (WS.progressBlock) {
            WS.progressBlock(ossObjModel, bytesSent, totalByteSent, totalBytesExpectedToSend);
        }
    };
    
    __block BOOL *result = hasError == nil ? NO : *hasError;
    OSSTask *putTask = [self.client putObject:putReq];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            ossObjModel.uploadCompleted = YES;
            if (WS.completedBlock) {
                WS.completedBlock(YES, nil);
            }
        } else {
            _cancelled = YES;
            *result = YES;
            if (WS.completedBlock) {
                NSError *error = [NSError errorWithDomain:@"AliyunOSSManager" code:task.error.code userInfo:@{AliyunCompletedErrorInfoKey: task.error.localizedDescription}];
                WS.completedBlock(NO, error);
            }
        }
        return nil;
    }];
}

- (void)uploadFileWithOSSObject:(OSSObjectModel *)ossObjModel progressBlock:(OSSMProgressUploadBlock)progressBlock completedBlock:(OSSMCompletedBlock)completedBlock {
    self.progressBlock = progressBlock;
    self.completedBlock = completedBlock;
    [self uploadFileWithOSSObject:ossObjModel hasError:nil];
}

- (void)uploadFileWithOSSObjects:(NSArray<OSSObjectModel *> *)ossObjs progressBlock:(OSSMProgressUploadBlock)progressBlock completedBlock:(OSSMCompletedBlock)completedBlock {
    self.progressBlock = progressBlock;
    self.completedBlock = completedBlock;
    self.objects = ossObjs;
    __weak typeof(self) WS = self;
    [ossObjs enumerateObjectsUsingBlock:^(OSSObjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.isCancelled || *stop) {
            return;
        }
        [WS uploadFileWithOSSObject:obj hasError:&stop];
    }];
}

@end

