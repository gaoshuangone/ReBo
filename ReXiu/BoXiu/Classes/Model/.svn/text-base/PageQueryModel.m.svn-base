//
//  PageQueryModel.m
//  BoXiu
//
//  Created by andy on 15/12/1.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "PageQueryModel.h"
@implementation PageQuery
@end

@implementation PageQueryModel
-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail{
    [self requestDataWithMethod:PageQuery_Method params:params success:success fail:fail];
}
-(BOOL)analyseData:(NSDictionary *)data{
    if ([super analyseData:data])
    {
        NSDictionary *dic = [data objectForKey:@"data"];
        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
        {
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
            
            for (int i = 0;i< [[dic valueForKey:@"data"] count]; i++) {
                PageQuery* his = [[PageQuery alloc]init];
                his.strAccountname = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"accountname"] toString];
                his.strBean = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"bean"] toString];
                his.strDatetime = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"datetime"] toString];
                his.strExchangerate = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"exchangerate"] toString];
                his.strId = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"id"] toString];
                 his.strMoney = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"money"] toString];
                 his.strStatus = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"status"] toString];
                 his.strUserid = [[[[dic valueForKey:@"data"] objectAtIndex:i]valueForKey:@"userid"] toString];
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

//-(BOOL)analyseData:(NSDictionary *)data{
//    if ([super analyseData:data])
//    {
//        NSDictionary *dic = [data  valueForKey:@"data"];
//        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
//        {
//            NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
//            
//            for (int i = 0;i< [[[dic valueForKey:@"page"]objectForKey:@"data"] count]; i++) {
//                PageQuery* his = [[PageQuery alloc]init];
//                his.strAccountname = [[[[[dic objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"accountname"] toString];
//                his.strBean = [[[[[dic objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"bean"] toString];
//                his.strDatetime = [[[[[dic objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"datetime"] toString];
//                his.strExchangerate = [[[[[dic objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"exchangerate"] toString];
//                his.strId = [[[[[dic  objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"id"] toString];
//                his.strMoney = [[[[[dic  objectForKey:@"page"] valueForKey:@"data"] objectAtIndex:i]valueForKey:@"money"] toString];
//                his.strStatus = [[[[[dic  objectForKey:@"page"]  valueForKey:@"data"] objectAtIndex:i]valueForKey:@"status"] toString];
//                his.strUserid = [[[[[dic  objectForKey:@"page"]  valueForKey:@"data"] objectAtIndex:i]valueForKey:@"userid"] toString];
//                [array addObject:his];
//            }
//            if (self.dataArray) {
//                [self.dataArray removeAllObjects];
//                self.dataArray = nil;
//                
//            }
//            self.strPageIndex =[[[dic objectForKey:@"page"] valueForKey:@"pageIndex"]toString];
//            self.strPageSize =[[[dic objectForKey:@"page"] valueForKey:@"pageSize"] toString];
//            self.strRecordCount =[[[dic objectForKey:@"page"] valueForKey:@"recordCount"] toString];
//            self.dataArray = [NSMutableArray arrayWithArray:array];
//        }
//        return YES;
//    }
//    
//    
//    
//    return NO;
//    
//}


@end
