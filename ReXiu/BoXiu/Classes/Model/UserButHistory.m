//
//  UserButHistory.m
//  BoXiu
//
//  Created by andy on 15/9/1.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "UserButHistory.h"
@implementation BuyHistory
@end
@implementation UserButHistory
-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail{
     [self requestDataWithMethod:UserBuyHistory params:params success:success fail:fail];
}
-(BOOL)analyseData:(NSDictionary *)data{
    if ([super analyseData:data])
    {
        NSDictionary *dic = [data objectForKey:@"data"];
        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
        {
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:5];
            
            for (int i = 0;i< [[dic valueForKey:@"data"] count]; i++) {
                BuyHistory* his = [[BuyHistory alloc]init];
                his.strPaytype = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"paytype"] toString];
                      his.strDateTime = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"datetime"] toString];
                      his.strCostmoney = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"costmoney"] toString];
                      his.strStatus = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"status"] toString];
                      his.strCoin = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"coin"] toString];
                [array addObject:his];
            }
            if (self.dataArray) {
                [self.dataArray removeAllObjects];
                self.dataArray = nil;
                
            }
            self.strPageIndex =[[dic  valueForKey:@"pageIndex"]toString];
                 self.strPageSize =[[dic  valueForKey:@"pageSize"] toString];
                 self.strRecordCount =[[dic  valueForKey:@"recordCount"] toString];
            
            self.dataArray = [NSMutableArray arrayWithArray:array];
        }
        return YES;
    }
    
    
    
    return NO;

}
@end
