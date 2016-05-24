//
//  ActivityModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ActivityModel.h"

@implementation RobActivity

@end

@implementation ActivityModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:ActivityQuery_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic count] > 0)
        {
            NSArray *activityArray = [dataDic objectForKey:@"data"];
            self.activityList = [NSMutableArray array];
            if (activityArray && [activityArray count])
            {
                for (int nIndex = 0; nIndex < [activityArray count]; nIndex++)
                {
                    NSDictionary *activityDic = [activityArray objectAtIndex:nIndex];
                    RobActivity *robActivity = [[RobActivity alloc] init];
                    
                    robActivity.activityId = [[activityDic objectForKey:@"activitytype"] integerValue];
                    robActivity.content = [activityDic objectForKey:@"content"];
                    robActivity.createtime = [activityDic objectForKey:@"createtime"];
                    robActivity.displaytype = [[activityDic objectForKey:@"displaytype"] integerValue];
                    robActivity.endtime = [activityDic objectForKey:@"endtime"];
                    robActivity.activitytype = [[activityDic objectForKey:@"id"] integerValue];
                    robActivity.imgurlmobile = [activityDic objectForKey:@"imgurlmobile"];
                    robActivity.imgurlpc = [activityDic objectForKey:@"imgurlpc"];
                    robActivity.istop = [[activityDic objectForKey:@"istop"] integerValue];
                    robActivity.orderby = [[activityDic objectForKey:@"orderby"] integerValue];
                    robActivity.pageurl = [activityDic objectForKey:@"pageurl"];
                    robActivity.pageurlmobile = [activityDic objectForKey:@"pageurlmobile"];
                    robActivity.starttime = [activityDic objectForKey:@"starttime"];
                    robActivity.status = [[activityDic objectForKey:@"status"] integerValue];
                    robActivity.title = [activityDic objectForKey:@"title"];
                    robActivity.updatetime = [activityDic objectForKey:@"updatetime"];
                    
                    [self.activityList addObject:robActivity];
                    
                    
                }
            }
        }
        
        return YES;

    }
    return NO;
}

@end
