//
//  NSObject+Convert.m
//  FHL
//
//  Created by panume on 14-11-4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "NSObject+Convert.h"

@implementation NSObject (Convert)

- (NSString *)toString
{
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (self == nil) {
        return @"";
    }
    else if ([self isKindOfClass:[NSNumber class]]) {
        NSNumber *object = (NSNumber *)self;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        return [formatter stringFromNumber:object];
      
    }
    
    else {
        return [NSString stringWithFormat:@"%@", self];
    }
    
}

- (NSInteger)toInt
{
    if ([self isKindOfClass:[NSNull class]]) {
        return -1;
    }
    
    if (self == nil) {
        return -1;
    }
    else if ([self isKindOfClass:[NSNumber class]]){
        
        NSNumber *number =(NSNumber *)self;
        return [number integerValue];
    }
    return -1;
}
@end
