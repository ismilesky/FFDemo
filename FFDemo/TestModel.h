//
//  TestModel.h
//  FFDemo
//
//  Created by VS on 2017/4/24.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

/**
  继承FFBaseModel,直接可以进行模型与字典，模型数组与字典数组等转换，FFBaseModel基于MJExtension
 */

#import "FFBaseModel.h"

@interface TestModel : FFBaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *publisher;
@end
