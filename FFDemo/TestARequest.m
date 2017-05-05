//
//  TestARequest.m
//  FFDemo
//
//  Created by VS on 2017/5/3.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "TestARequest.h"
#import "TestModel.h"

@implementation TestARequest
- (NSString *)getRequestQuery {
    return @"book/search?";
}

- (void)processResult {
    NSArray *results = self.resultDict[@"books"];
    NSArray *books = [TestModel ff_modelsFromKeyValues:results];
    if (books != nil) {
        [self.resultDict setObject:books forKey:Key_Model];
    }
}

@end
