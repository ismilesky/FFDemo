//
//  FFBaseModel.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFBaseModel : NSObject
- (NSDictionary *)ff_toKeyValue;
- (void)ff_modelsDidFinishConvertingToKeyValues;
- (void)ff_keyvaluesDidFinishConvertingToModels;

+ (NSDictionary *)ff_replaceKeyFromPropertyName;
+ (NSDictionary *)ff_objectClassInArray;
+ (NSArray *)ff_ignoredPropertyNames;
+ (instancetype)ff_modelFromKeyValue:(NSDictionary *)keyValue;
+ (NSArray *)ff_keyValuesFromModels:(NSArray *)models;
+ (NSArray *)ff_modelsFromKeyValues:(NSArray *)keyvalues;
+ (NSArray *)ff_allowedCodingPropertyNames;
+ (NSArray *)ff_ignoredCodingPropertyNames;

@end
