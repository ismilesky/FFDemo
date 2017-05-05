//
//  FFBaseModel.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "FFBaseModel.h"
#import "MJExtension.h"

@interface FFBaseModel () <MJCoding>

@end

@implementation FFBaseModel
- (NSDictionary *)ff_toKeyValue {
    return [self mj_keyValues];
}

- (void)ff_modelsDidFinishConvertingToKeyValues {
    
}

- (void)ff_keyvaluesDidFinishConvertingToModels {
    
}

/**
 *  字典转模型完毕后执行
 */
- (void)mj_keyValuesDidFinishConvertingToObject {
    [self ff_keyvaluesDidFinishConvertingToModels];
}

/**
 *  模型转字典完毕后执行
 */
- (void)mj_objectDidFinishConvertingToKeyValues {
    [self ff_modelsDidFinishConvertingToKeyValues];
}

+ (NSDictionary *)ff_replaceKeyFromPropertyName {
    return @{};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self ff_replaceKeyFromPropertyName];
}

+ (NSDictionary *)ff_objectClassInArray {
    return @{};
}

+ (NSArray *)mj_ignoredPropertyNames {
    return [self ff_ignoredPropertyNames];
}

+ (NSArray *)ff_ignoredPropertyNames {
    return @[];
}

+ (NSDictionary *)mj_objectClassInArray {
    return [self ff_objectClassInArray];
}

+ (instancetype)ff_modelFromKeyValue:(NSDictionary *)keyValue {
    return [self mj_objectWithKeyValues:keyValue];
}

+ (NSArray *)ff_keyValuesFromModels:(NSArray *)models {
    NSArray *array = [self mj_keyValuesArrayWithObjectArray:models];
    return array?:[NSArray array];
}

+ (NSArray *)ff_modelsFromKeyValues:(NSArray *)keyvalues {
    NSArray *array = [self mj_objectArrayWithKeyValuesArray:keyvalues];
    return  array?:[NSArray array];
}

#pragma mark - 归档和解归档
+ (NSArray *)mj_allowedCodingPropertyNames {
    return [self ff_allowedCodingPropertyNames];
}

+ (NSArray *)mj_ignoredCodingPropertyNames {
    return [self ff_ignoredCodingPropertyNames];
}

+ (NSArray *)ff_allowedCodingPropertyNames {
    return @[];
}

+ (NSArray *)ff_ignoredCodingPropertyNames {
    return @[];
}

MJExtensionCodingImplementation

@end
