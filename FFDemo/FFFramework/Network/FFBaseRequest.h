//
//  FFBaseRequest.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class FFBaseRequest;

typedef NS_ENUM(NSUInteger, FFRequestMethod) {
    FFRequestMethodGet,
    FFRequestMethodPost,
    FFRequestMethodPut,
    FFRequestMethodDelete
};

typedef NS_ENUM(NSInteger, FFNetworkReachabilityStatus) {
    FFNetworkReachabilityStatusUnknown          = -1,
    FFNetworkReachabilityStatusNotReachable     = 0,
    FFNetworkReachabilityStatusReachableViaWWAN = 1,
    FFNetworkReachabilityStatusReachableViaWiFi = 2,
};

typedef NS_ENUM(NSUInteger, FFRequestError) {
    FFRequestErrorNetwork = 0
};

static NSString *Key_Model = @"Key_Model";

typedef void(^reqSuccessBlock)(FFBaseRequest *request);
typedef void(^reqCancelBlock)(FFBaseRequest *request);
typedef void(^reqFailureBlock)(FFBaseRequest *request, NSError *error);
typedef void(^reqUploadBlock)(FFBaseRequest *request, NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface FFBaseRequest : NSObject
/**请求路径*/
@property (nonatomic, copy,   readonly) NSString *requestUrl;
/**请求参数*/
@property (nonatomic, strong, readonly) NSDictionary *requestParameters;
/**上传二进制数据数组*/
@property (nonatomic, strong, readonly) NSMutableArray *binaryParameterArray;
/**返回字典数据*/
@property (nonatomic, strong, readonly) NSMutableDictionary *resultDict;
/**结果数组*/
@property (nonatomic, strong, readonly) NSMutableArray *resultArray;
/**结果字符串*/
@property (nonatomic, copy)             NSString *resultString;
@property (nonatomic, strong, readonly) UIImage *responseImage;
/**是否请求成功*/
@property (nonatomic, assign, readonly) BOOL isSuccess;

/**
 *  网络数据请求
 *
 *  @param parameters 上传参数
 *  @param successBlock 成功回调
 *  @param cancelBlock 取消回调
 *  @param failureBlock 失败回调
 */
+ (void)requestParameters:(NSDictionary *)parameters
             successBlock:(reqSuccessBlock)successBlock
              cancelBlock:(reqCancelBlock)cancelBlock
             failureBlock:(reqFailureBlock)failureBlock;
/**
 *  执行请求
 *
 *  @param parameters   请求参数(非二进制文件)
 *  @param binaryArray  上传的二进制文件(ZZBinaryData对象)
 *  @param successBlock 成功回调
 *  @param cancelBlock  取消回调
 *  @param failureBlock 失败回调
 *  @param uploadProcessBlock 上传进度回调
 */
+ (void)requestParameters:(NSDictionary *)parameters
              binaryArray:(NSMutableArray *)binaryArray
             successBlock:(reqSuccessBlock)successBlock
              cancelBlock:(reqCancelBlock)cancelBlock
             failureBlock:(reqFailureBlock)failureBlock
        uplodProcessBlock:(reqUploadBlock)uploadProcessBlock;

/**获取请求地址*/
- (NSString *)getRequestUrl;

/// 是否正在请求数据
+ (BOOL)isRequesting;

/**获取当前网络类型*/
+ (FFNetworkReachabilityStatus)fetchReachabilityStatus;

/**启动网络监听*/
+ (void)starNetWorkReachability;

#pragma mark - Children Class
- (NSString *)getRequestHost;
- (NSString *)getRequestQuery;
- (NSString *)getUserAgent;
/**请求头设置*/
- (NSDictionary<NSString *, NSString *> *)getCustomHeaders;
/**请求方式（默认GET）*/
- (FFRequestMethod)getRequestMethod;
/**请求参数*/
- (NSDictionary *)getDefaultParameters;
/**数据解析*/
- (void)processResult;
/**取消请求*/
+ (void)cancelTheRequest;

#pragma mark- 以下可根据服务器返回自行设置
/**是否成功*/
- (BOOL)success;
/**请求失败错误信息*/
- (NSString *)errorMsg;
/**数据总数*/
- (NSInteger)totalCount;
/**是否有数据（通常是分页请求数据)*/
- (BOOL)hasMoreData;
@end
