 //
//  MessageCenter.m
//  BoXiu
//
//  Created by andy on 14-11-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MessageCenter.h"
#import "DataBaseManager.h"
#import "UserInfoManager.h"

@implementation MessageData

@end

@interface MessageCenter ()

@property (nonatomic,strong) NSMutableArray *messageMArray;

@end
@implementation MessageCenter

+ (instancetype)shareMessageCenter
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
//        [[AppInfo shareInstance] addObserver:self forKeyPath:@"bLoginSuccess" options:NSKeyValueObservingOptionNew context:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upDataMessage) name:@"upDataMessage" object:nil];
        
        NSArray *keyArray = @[@"userid",@"uuid",@"title",@"content",@"icon",@"time",@"readed",@"messageType",@"notifyShowType",@"actionLink",@"data",@"level",@"levelName",@"staruserId"];
        [[DataBaseManager shareDataBaseManager] createTableWithName:Message_Table keys:keyArray];
    }
    return self;
}

- (void)loadMessageData
{
    NSArray *dataArray = [[DataBaseManager shareDataBaseManager] queryTableWithName:Message_Table sortByTime:YES];
    if (_messageMArray == nil)
    {
        _messageMArray = [NSMutableArray array];
    }
    [_messageMArray removeAllObjects];
    self.unReadCount = 0;
    
    if (dataArray)
    {
        for (NSDictionary *dictionary in dataArray)
        {
            if (dictionary)
            {
                MessageData *messageData = [[MessageData alloc] init];
                messageData.userId = [[dictionary objectForKey:@"userid"] integerValue];
                messageData.messageId = [[dictionary objectForKey:@"id"] integerValue];
                messageData.uuid = [dictionary objectForKey:@"uuid"];
                messageData.title = [dictionary objectForKey:@"title"];
                messageData.content = [dictionary objectForKey:@"content"];
                messageData.icon = [dictionary objectForKey:@"icon"];
                messageData.time = [dictionary objectForKey:@"time"];
                messageData.readed = [[dictionary objectForKey:@"readed"] boolValue];
                
                messageData.messageType = [[dictionary objectForKey:@"messageType"] integerValue];
                messageData.notifyShowType = [[dictionary objectForKey:@"notifyShowType"] integerValue];
                
                if (messageData.messageType == 1)
                {
                    messageData.actionLink = [[dictionary objectForKey:@"actionLink"] integerValue];
                    messageData.data = [dictionary objectForKey:@"data"];
                    
                    //设置默认值
                    messageData.level = [dictionary objectForKey:@"level"];
                    messageData.levelName = [dictionary objectForKey:@"levelName"];
                    
                    messageData.staruserId = [[dictionary objectForKey:@"staruserId"] integerValue];
                }
                else if (messageData.messageType == 2)
                {
                    messageData.level = [dictionary objectForKey:@"level"];
                    messageData.levelName = [dictionary objectForKey:@"levelName"];
                    
                    //设置默认值
                    messageData.staruserId = [[dictionary objectForKey:@"staruserId"] integerValue];
                    messageData.actionLink = [[dictionary objectForKey:@"actionLink"] integerValue];
                    messageData.data = [dictionary objectForKey:@"data"];
                }
                else if (messageData.messageType == 3)
                {
                    messageData.staruserId = [[dictionary objectForKey:@"staruserId"] integerValue];
                    //设置默认值
                    messageData.level = [dictionary objectForKey:@"level"];
                    messageData.levelName = [dictionary objectForKey:@"levelName"];
                    messageData.actionLink = [[dictionary objectForKey:@"actionLink"] integerValue];
                    messageData.data = [dictionary objectForKey:@"data"];
                }
                
//                //过滤当前用户或者游客
//                if (messageData.messageType == 1)
//                {
//                    //活动通知
//                    [_messageMArray addObject:messageData];
//                    if (messageData.readed == NO)
//                    {
//                        self.unReadCount++;
//                    }
//
//                }
//                else
//                {
                
                NSInteger userid =[UserInfoManager shareUserInfoManager].currentUserInfo.userId;
                    if ([AppInfo shareInstance].bLoginSuccess)
                    {
                        if (messageData.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
                        {
                            [_messageMArray addObject:messageData];
                            if (messageData.readed == NO)
                            {
                                self.unReadCount++;
                            }

                        }
                    }
//                }
            }

        }

    }
}


- (BOOL)saveMessge:(MessageData *)messageData
{
    BOOL result = NO;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:[NSNumber numberWithInteger:messageData.userId] forKey:@"userid"];
    [dictionary setObject:messageData.uuid forKey:@"uuid"];
    [dictionary setObject:messageData.title forKey:@"title"];
    [dictionary setObject:messageData.content forKey:@"content"];
    [dictionary setObject:messageData.icon forKey:@"icon"];
    [dictionary setObject:messageData.time forKey:@"time"];
    
    [dictionary setObject:[NSNumber numberWithInteger:messageData.messageType] forKey:@"messageType"];
    [dictionary setObject:[NSNumber numberWithInteger:messageData.notifyShowType] forKey:@"notifyShowType"];
    
    if (messageData.messageType == 1)
    {
        [dictionary setObject:[NSNumber numberWithInteger:messageData.actionLink] forKey:@"actionLink"];
        [dictionary setObject:messageData.data forKey:@"data"];
        
        //设置默认值
        [dictionary setObject:messageData.level forKey:@"level"];
        [dictionary setObject:messageData.levelName forKey:@"levelName"];
        [dictionary setObject:[NSNumber numberWithInteger:messageData.staruserId] forKey:@"staruserId"];
    }
    else if (messageData.messageType == 2)
    {
        [dictionary setObject:messageData.level forKey:@"level"];
        [dictionary setObject:messageData.levelName forKey:@"levelName"];
        
        //设置默认值
        [dictionary setObject:[NSNumber numberWithInteger:messageData.staruserId] forKey:@"staruserId"];
        [dictionary setObject:[NSNumber numberWithInteger:messageData.actionLink] forKey:@"actionLink"];
        [dictionary setObject:messageData.data forKey:@"data"];
    }
    else if (messageData.messageType == 3)
    {
        [dictionary setObject:[NSNumber numberWithInteger:messageData.staruserId] forKey:@"staruserId"];
        
        //设置默认值
        [dictionary setObject:messageData.level forKey:@"level"];
        [dictionary setObject:messageData.levelName forKey:@"levelName"];
        [dictionary setObject:[NSNumber numberWithInteger:messageData.actionLink] forKey:@"actionLink"];
        [dictionary setObject:messageData.data forKey:@"data"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:messageData.readed] forKey:@"readed"];
    result = [[DataBaseManager shareDataBaseManager] insertDataToTable:Message_Table keyAndValue:dictionary];
    [self loadMessageData];
    return result;
}

- (NSArray *)getMessageData
{
    if (_messageMArray == nil)
    {
        _messageMArray= [NSMutableArray array];
    }
    if (_messageMArray && [_messageMArray count] == 0)
    {
        [self loadMessageData];
    }
    return _messageMArray;
}

- (BOOL)markMessageReadFlag:(NSInteger)messageId
{
    BOOL result = NO;
    result = [[DataBaseManager shareDataBaseManager] updateDataInTable:Message_Table keyAndValue:@{@"readed":@"YES"} primaryKeyValue:messageId];
    if (result)
    {
        for (MessageData *messageData in self.messageMArray)
        {
            if (messageData.messageId == messageId)
            {
                self.unReadCount = 0;
                messageData.readed = YES;
                break;
            }
        }
    }
    return result;
}

- (BOOL)markMoreMessageReadFlag:(NSArray *)messageIds
{ 
    BOOL result = NO;
    
    NSMutableArray *keyValue = [NSMutableArray array];
    for (int index = 0; index < [messageIds count]; index++)
    {
        NSDictionary *dic = @{@"readed":@"YES"};
        [keyValue addObject:dic];
    }
    
    
    result = [[DataBaseManager shareDataBaseManager] updateDataInTable:Message_Table keysAndValues:keyValue primaryKeyValues:messageIds];
    
    if (result)
    {
        for (MessageData *msgData in self.messageMArray)
        {
            if (msgData && msgData.readed == NO)
            {
                msgData.readed = YES;
                self.unReadCount--;
                if (self.unReadCount < 0)
                {
                    self.unReadCount = 0;
                }
            }
            
        }
    }
    
     return result;
}
- (BOOL)deleteMessage:(NSInteger)messgeId
{
    BOOL result = NO;
    result = [[DataBaseManager shareDataBaseManager] deleteDataFromTable:Message_Table primaryKeyValue:messgeId];
    if (result)
    {
        for (MessageData *messageData in self.messageMArray)
        {
            if (messageData.messageId == messgeId)
            {
                [self.messageMArray removeObject:messageData];
                break;
            }
        }
    }
    return result;
}

- (BOOL)deleteAllMessage
{
    BOOL result = NO;
    result = [[DataBaseManager shareDataBaseManager] deleteTableWithName:Message_Table];
    if (result)
    {
        [self.messageMArray removeAllObjects];
    }
    return result;
}


//#pragma mark - 登录成功或者注销都要重新装在数据库
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"bLoginSuccess"])
//    {
//        [self loadMessageData];
//    }
//}
-(void)upDataMessage{
    [self loadMessageData];
}
@end
