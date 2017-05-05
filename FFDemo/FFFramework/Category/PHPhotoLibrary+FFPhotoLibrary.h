//
//  PHPhotoLibrary+FFPhotoLibrary.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Photos/Photos.h>

typedef void(^PHAssetLibraryWriteImageCompletionBlock)(PHAsset *imageAsset);

typedef void(^PHAssetLibraryWriteVideoCompletionBlock)(NSURL *videoUrl);

typedef void(^PHAssetLibraryAccessFailureBlock)(NSError *error);

@interface PHPhotoLibrary (FFPhotoLibrary)
/**
 判断相册权限
 */
- (BOOL)canAccessPhotoAlbum;

/**
 创建一个相册文件夹
 
 @param albumName 相册名称
 */
- (PHAssetCollection *)createNewAlbumCalled:(NSString *)albumName;

/**
 保存一个UIImage对象到某一个相册里，若没有该相册会先自动创建
 
 @param image 保存的照片
 @param albumName 保存的相册名称
 @param completion 保存成功回调
 @param failure 保存失败回调
 */
- (void)saveImage:(UIImage *)image ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteImageCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;

/**
 通过一个图片的本地url保存该图片到某一个相册里
 
 @param imageUrl 本地图片的URL
 @param albumName 保存的相册名称
 @param completion 保存成功回调
 @param failure 保存失败回调
 */
- (void)saveImageWithImageUrl:(NSURL *)imageUrl ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteImageCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;

/**
 通过一个视频的本地url保存该视频到某一个相册里
 
 @param videoUrl 视频URL
 @param albumName 保存相册名称
 @param completion 保存成功回调
 @param failure 保存失败回调
 */
- (void)saveVideoWithUrl:(NSURL *)videoUrl ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteVideoCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;

/**
 保存一个imageData对象到某一个相册里
 
 @param imageData 图片的Data类型
 @param albumName 保存的相册名称
 @param completion 保存成功回调
 @param failure 保存失败回调
 */
- (void)saveImageData:(NSData *)imageData ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteImageCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;

/**
 获取photos app创建的相册里所有图片
 
 @param albumName 相册名称
 @param completion 成功回调
 */
- (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion;

@end
