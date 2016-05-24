//
//  ExpressionManager.m
//  BoXiu
//
//  Created by andy on 14-4-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ExpressionManager.h"
#import "JSONKit.h"

@interface ExpressionManager ()

@property (nonatomic,strong) NSMutableDictionary *faceDic;

@end

@implementation ExpressionManager

+ (ExpressionManager *)shareInstance
{
    static dispatch_once_t predicate;
    static id instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _faceDic = [NSMutableDictionary dictionary];
        
        NSString *string=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Expression" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *expressionMary = [NSArray arrayWithArray:[string objectFromJSONString]];
        
        for (int i = 0; i < [expressionMary count]; i++)
        {
            NSString *title = [[expressionMary objectAtIndex:i] objectForKey:@"title"];
            NSString *linkName = [[expressionMary objectAtIndex:i] objectForKey:@"link"];
            
            NSString *key = [NSString stringWithFormat:@"[%@]",title];
            [_faceDic setObject:linkName forKey:key];
        }
    }
    return self;
}

- (NSDictionary *)expressionDictionary
{
    return self.faceDic;
}

- (NSArray *)expressionImageArray
{
    return [self.faceDic allValues];
}

@end
