//
//  NSMutableArray+FFMutableArray.m
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "NSMutableArray+FFMutableArray.h"

@implementation NSMutableArray (FFMutableArray)
- (id)safeObjectAtIndex:(NSUInteger)index {
    if([self count] > 0) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if(to != from) {
        id obj = [self safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        if(to >= [self count])
            [self addObject:obj];
        else
            [self insertObject:obj atIndex:to];
    }
}

- (NSMutableArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for(id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

+ (NSMutableArray *)sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];
    
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:brandDescriptor, nil];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];
    
    return array;
}

@end
