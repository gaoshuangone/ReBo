//
//  RecordApproveManager.m
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "RecordApproveManager.h"
#import "DataBaseManager.h"
#import "UserInfoManager.h"
#import "SendShowTimeApproveModel.h"

#define StarApprove_Table @"starapprove"

@interface RecordApproveManager ()

@property (nonatomic,assign) NSInteger freeApproveCount;

@property (nonatomic,assign) NSInteger approveCount;
@property (nonatomic,assign) BOOL existRecord;

@property (nonatomic,strong) NSTimer *sendApproveTimer;

@property (nonatomic,strong) NSLock *totalApproveLock;
@property (nonatomic,strong) NSLock *freeApproveLock;

@property (nonatomic,assign) NSInteger showId;

@end

@implementation RecordApproveManager

+ (RecordApproveManager *)shareInstance
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
        _totalApproveLock = [[NSLock alloc] init];
        _freeApproveLock = [[NSLock alloc] init];
        
        NSArray *keyArray = @[@"showId",@"userId",@"approvecount"];
        [[DataBaseManager shareDataBaseManager] createTableWithName:StarApprove_Table keys:keyArray];
    }
    return self;
}

- (void)loadDataWithShowId:(NSInteger)showId
{
    if (showId == 0)
    {
        return;
    }
    
    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (currentInfo == nil)
    {
        return;
    }
    //重新读取时将此值恢复为0
    _approveCount = 0;
    _existRecord = NO;
    
    NSMutableDictionary *keyAndValue = [NSMutableDictionary dictionary];
    [keyAndValue setObject:[NSNumber numberWithInteger:showId] forKey:@"showId"];
    [keyAndValue setObject:[NSNumber numberWithInteger:currentInfo.userId] forKey:@"userId"];
    NSArray *dataArray = [[DataBaseManager shareDataBaseManager] queryTableWitthName:StarApprove_Table conditionKeyAndValue:keyAndValue sortByTime:NO];
    
    if (dataArray)
    {
        for (NSDictionary *dictionary in dataArray)
        {
            if (dictionary)
            {
                NSInteger roomShowId = [[dictionary objectForKey:@"showId"] integerValue];
                if (roomShowId == showId)
                {
                    self.existRecord = YES;
                    self.approveCount = [[dictionary objectForKey:@"approvecount"] integerValue];
                    break;
                }
            }
        }
    }
}

- (void)deleteOldApproveData
{
    
}

- (NSInteger)approveCountOfCurrentShowId
{
    return _approveCount;
}

- (void)addFreeApproveCount
{
    [_freeApproveLock lock];
    _freeApproveCount++;
    [_freeApproveLock unlock];
    [self addApproveCount:1];
}

- (void)addApproveCount:(NSInteger)approveCount
{
    [_totalApproveLock lock];
    _approveCount = _approveCount + approveCount;
    [_totalApproveLock unlock];
    
    [self saveApproveCount:_approveCount];
}

- (BOOL)saveApproveCount:(NSInteger)approveCount
{
    return [self saveApproveCount:approveCount showId:_showId];
}

- (BOOL)saveApproveCount:(NSInteger)approveCount showId:(NSInteger)showId
{
    _showId = showId;
    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (currentInfo == nil)
    {
        return NO;
    }
    
    if (approveCount == self.approveCount && showId == 0)
    {
        return YES;
    }
    BOOL result;
    if (self.existRecord)
    {
        result = [self updateApproveCount:approveCount showId:showId];
    }
    else
    {
        result = [self insertInfoWithApproveCount:approveCount showId:showId];
        self.existRecord = YES;
    }
    if (result)
    {
        self.approveCount = approveCount;
    }
    return result;
}

//更新数据
- (BOOL)updateApproveCount:(NSInteger)approveCount showId:(NSInteger)showId
{
    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    NSDictionary *keyAndValue = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:approveCount] forKey:@"approvecount"];
                                 
    NSMutableDictionary *conditionKeyAndValue = [NSMutableDictionary dictionary];
    [conditionKeyAndValue setObject:[NSNumber numberWithInteger:showId] forKey:@"showId"];
    [conditionKeyAndValue setObject:[NSNumber numberWithInteger:currentInfo.userId] forKey:@"userId"];
    BOOL result = [[DataBaseManager shareDataBaseManager] updateDataInTable:StarApprove_Table keyAndValue:keyAndValue conditionKeyAndValue:conditionKeyAndValue];
    return result;
}

//插入数据
- (BOOL)insertInfoWithApproveCount:(NSInteger)approveCount showId:(NSInteger)showId
{
    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    NSMutableDictionary *keyAndValue = [NSMutableDictionary dictionary];
    [keyAndValue setObject:[NSNumber numberWithInteger:showId] forKey:@"showId"];
    [keyAndValue setObject:[NSNumber numberWithInteger:currentInfo.userId] forKey:@"userId"];
    [keyAndValue setObject:[NSNumber numberWithInteger:approveCount] forKey:@"approvecount"];
    BOOL result = [[DataBaseManager shareDataBaseManager] insertDataToTable:StarApprove_Table keyAndValue:keyAndValue];
    return result;
}


- (NSInteger)approveCountOfShowId:(NSInteger)showId
{
    [self loadDataWithShowId:showId];
    return self.approveCount;
}

- (void)beginSendFreeApproveWithShowId:(NSInteger)showId
{
    _showId = showId;
    if (_sendApproveTimer == nil)
    {
        _sendApproveTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(sendFreeApprove) userInfo:nil repeats:YES];
    }
}

- (void)stopSendFreeApprove
{
    if (_sendApproveTimer)
    {
        //停止之前发送一次
        [self sendFreeApprove];
        
        [_sendApproveTimer invalidate];
        _sendApproveTimer = nil;
    }
}

- (void)sendFreeApprove
{
    [self sendShowTimeApprove:1];
}

- (void)sendShowTimeApprove:(NSInteger)praiseType
{
    if (praiseType == 1 && _freeApproveCount == 0)
    {
        return;
    }
    
    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    //clienttype：2是安卓;3是ios
    [bodyDic setObject:[NSNumber numberWithInt:3] forKey:@"clienttype"];
    if (_showId != 0)
    {
        [bodyDic setObject:[NSNumber numberWithInteger:_showId] forKey:@"showId"];
    }
    [bodyDic setObject:[NSNumber numberWithInteger:praiseType] forKey:@"praiseType"];
    if (praiseType == 1)
    {
        [bodyDic setObject:[NSNumber numberWithInteger:_freeApproveCount] forKey:@"praiseNum"];
        [_freeApproveLock lock];
        _freeApproveCount = 0;
        [_freeApproveLock unlock];
    }
    
    [bodyDic setObject:[NSNumber numberWithInteger:currentInfo.userId] forKey:@"userid"];
    [SendShowTimeApproveModel sendApprove:bodyDic];
}

@end
