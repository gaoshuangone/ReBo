//
//  ExpressionManager.h
//  BoXiu
//
//  Created by andy on 14-4-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressionManager : NSObject

+ (ExpressionManager *)shareInstance;

- (NSDictionary *)expressionDictionary;
- (NSArray *)expressionImageArray;

@end
