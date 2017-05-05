//
//  AliyunOSSManager.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OSSObjectModel;

#define COMMON_BLOCK progressBlock:(OSSMProgressUploadBlock)progressBlock completedBlock:(OSSMCompletedBlock)completedBlock

typedef void(^OSSMCompletedBlock)(BOOL isSuccess, NSError *error);
typedef void(^OSSMProgressUploadBlock)(OSSObjectModel *ossObj, int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend);

extern NSString * const AliyunCompletedErrorInfoKey;

typedef enum : NSUInteger {
    OSSObjectTypeBinary,
    OSSObjectTypeFileUrl
} OSSObjectType;

@interface AliyunOSSManager : NSObject
@property (nonatomic, assign, readonly, getter=isAllCompleted) BOOL allCompleted;
@property (nonatomic, assign, readonly, getter=isCancelled) BOOL cancelled;

- (void)uploadFileWithOSSObject:(OSSObjectModel *)ossObjModel COMMON_BLOCK;
- (void)uploadFileWithOSSObjects:(NSArray<OSSObjectModel *> *)ossObjs COMMON_BLOCK;
@end

@interface OSSObjectModel : NSObject
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSData *objData;
@property (nonatomic, strong) NSURL *fileUrl;
@property (nonatomic, assign) OSSObjectType objType;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign, getter=isUploadCompleted) BOOL uploadCompleted;
@end

