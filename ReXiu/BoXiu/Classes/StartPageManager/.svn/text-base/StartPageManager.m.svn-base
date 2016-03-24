
//  StartPageManager.m
//  BoXiu
//
//  Created by andy on 15-1-19.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "StartPageManager.h"
#import "StartupPageModel.h"
#import "DataBaseManager.h"
#import "TMCache.h"

#define StartupPage_Table @"startuppage"

@interface StartPageManager ()
@property (nonatomic,strong) NSMutableArray *startPages;
@end
@implementation StartPageManager

+ (StartPageManager *)shareInstance
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
        NSArray *keyArray = @[@"staruppageid",@"actiontype",@"data",@"datetime",@"devicetype",@"endtime",@"imgurl",@"postertype",@"seq",@"starttime",@"status",@"title"];
        [[DataBaseManager shareDataBaseManager] createTableWithName:StartupPage_Table keys:keyArray];
        [self loadData];
        
    }
    return self;
}

- (void)loadData
{
    NSArray *dataArray = [[DataBaseManager shareDataBaseManager] queryTableWithName:StartupPage_Table sortByTime:NO];
    if (_startPages == nil)
    {
        _startPages = [NSMutableArray array];
    }
    [_startPages removeAllObjects];

    if (dataArray)
    {
        NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970];
        
        for (NSDictionary *dictionary in dataArray)
        {
            if (dictionary)
            {
                StartupPageData *startupPageData = [[StartupPageData alloc] init];
                
                startupPageData.staruppageid = [[dictionary objectForKey:@"staruppageid"] integerValue];
                startupPageData.actiontype = [[dictionary objectForKey:@"actiontype"] integerValue];
                startupPageData.data = [dictionary objectForKey:@"data"];
                startupPageData.datetime = [dictionary objectForKey:@"datetime"];
                startupPageData.devicetype = [[dictionary objectForKey:@"devicetype"] integerValue];
                startupPageData.endtime = [dictionary objectForKey:@"endtime"];
                startupPageData.imgurl = [dictionary objectForKey:@"imgurl"];
                
                //从缓冲中花去图片

                NSData *data = (NSData *)[[TMDiskCache sharedCache] objectForKey:startupPageData.imgurl];
                startupPageData.imgData = [NSData dataWithData:data];
                
                startupPageData.postertype = [[dictionary objectForKey:@"postertype"] integerValue];
                startupPageData.seq = [[dictionary objectForKey:@"seq"] integerValue];
                startupPageData.starttime = [dictionary objectForKey:@"starttime"];
                startupPageData.status = [[dictionary objectForKey:@"status"] integerValue];
                startupPageData.title = [dictionary objectForKey:@"title"];
                
                NSDate *endTimeDate = [CommonFuction dateFromString:startupPageData.endtime];
                NSTimeInterval endTime = [endTimeDate timeIntervalSince1970];
                if (endTime < currentDate)
                {
                    [self deleteDataFromDataBase:startupPageData];
                }
                else
                {
                    if (startupPageData.imgData && [startupPageData.imgData length] > 0)
                    {
                        [_startPages addObject:startupPageData];
                    }
                    else
                    {
                        [self deleteDataFromDataBase:startupPageData];
                    }
                }
            }
        }
        
    }

}

- (BOOL)insertDataToDataBase:(StartupPageData *)startupPageData
{
    BOOL result = NO;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.staruppageid] forKey:@"staruppageid"];
    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.actiontype] forKey:@"actiontype"];
    [dictionary setObject:startupPageData.endtime forKey:@"datetime"];
    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.devicetype] forKey:@"devicetype"];
    [dictionary setObject:startupPageData.endtime forKey:@"endtime"];
    [dictionary setObject:startupPageData.imgurl forKey:@"imgurl"];
    
    //将数据保存在缓冲
    NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:startupPageData.imgurl]];
    [[TMDiskCache sharedCache] setObject:imgdata forKey:startupPageData.imgurl];

    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.postertype] forKey:@"postertype"];
    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.seq] forKey:@"seq"];
    [dictionary setObject:startupPageData.starttime forKey:@"starttime"];
    [dictionary setObject:[NSNumber numberWithInteger:startupPageData.status] forKey:@"status"];
    
    NSString* str = nil;
    if(startupPageData.data == nil)
    {
        [dictionary setObject:@"" forKey:@"data"];

    }else{
        [dictionary setObject:startupPageData.data forKey:@"data"];

    }
    
    if (startupPageData.title == nil) {
        str = @"";
    }else{
        str =startupPageData.title;
    }
    [dictionary setObject:str forKey:@"title"];

    result = [[DataBaseManager shareDataBaseManager] insertDataToTable:StartupPage_Table keyAndValue:dictionary];
    return result;
}

- (void)saveStartupData:(NSArray *)startupPages
{
    if (startupPages && startupPages.count)
    {
        //删除旧的，
        
        for (StartupPageData *oldStartupPageData in _startPages)
        {
            [self deleteDataFromDataBase:oldStartupPageData];
        }
        
        //插入新得
        for (StartupPageData *newStartupPageData in startupPages)
        {
            [self insertDataToDataBase:newStartupPageData];
        }
    }
    else
    {
        //删除旧的，
        
        for (StartupPageData *oldStartupPageData in _startPages)
        {
            [self deleteDataFromDataBase:oldStartupPageData];
        }
    }
}

- (BOOL)deleteDataFromDataBase:(StartupPageData *)startupPageData
{
    BOOL result = NO;
    [[TMDiskCache sharedCache] removeObjectForKey:startupPageData.imgurl];
    result = [[DataBaseManager shareDataBaseManager] deleteTableWithName:StartupPage_Table];
    return result;
}

- (void)requestData
{
    StartupPageModel *model = [[StartupPageModel alloc] init];
    [model requestDataWithParams:nil success:^(id object) {
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
        if(hideSwitch != 1)
        {
            if(model.result == 0)
            {
                [self performSelector:@selector(saveStartupData:) withObject:model.startupPages];
            }
        }
    } fail:^(id object) {
            
    }];

}

- (NSArray *)startPages
{
    //读取旧的启动页数据
    NSArray *startPageDatas = [NSArray arrayWithArray:_startPages];
    //同时请求新得启动页数据，下次启动时候会用。
    [self performSelector:@selector(requestData) withObject:nil];
    return startPageDatas;
}

@end
