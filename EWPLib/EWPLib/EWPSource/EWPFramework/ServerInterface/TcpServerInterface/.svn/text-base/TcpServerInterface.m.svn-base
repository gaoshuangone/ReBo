//
//  TcpServerInterface.m
//  BoXiu
//
//  Created by Andy on 14-4-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TcpServerInterface.h"
#import "AsyncSocket.h"



@interface TcpServerInterface ()<AsyncSocketDelegate>

@property (nonatomic,strong) AsyncSocket *asyncSocket;

@end

@implementation TcpServerInterface

+ (id)shareServerInterface
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
        
    }
    return self;
}

- (BOOL)isConnected
{
    return [self.asyncSocket isConnected];
}

- (void)connectServer:(NSString *)serverip serverport:(NSInteger )serverport
{
    if (_asyncSocket == nil && ![_asyncSocket isConnected])
    {
        _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
        [_asyncSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        if (![_asyncSocket isConnected])
        {
            NSError *error = nil;
            [_asyncSocket connectToHost:serverip onPort:serverport withTimeout:8 error:&error];
            if (error)
            {
                EWPLog(@"connectToHost error %@",error);
                [self disconnectServer];
            }
        }
    }
}

- (void)disconnectServer
{
    if (_asyncSocket)
    {
        [_asyncSocket disconnect];
        _asyncSocket.delegate = nil;
        _asyncSocket = nil;
    }
}

- (void)sendData:(NSData *)data
{
    if ([self.asyncSocket isConnected])
    {
        
        
        NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"发送数据==================================%@",aStr);
        
        [self.asyncSocket writeData:data withTimeout:-1 tag:0];
    }else{
        
    }
}

- (void)processData:(NSData *)data status:(TcpStatus)status
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(progressData:status:)])
    {
        
        
        NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [self.delegate progressData:data status:status];
        
    }
}

#pragma mark AsyncSocket

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    
    EWPLog(@"client willDisconnectWithError:%@",err);
    [self processData:nil status:eWillDisconnectWithErro];
    
 
    
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    if (_asyncSocket)
    {
        _asyncSocket.delegate = nil;
        _asyncSocket = nil;
    }
    
    EWPLog(@"client onSocketDidDisconnect");
    [sock readDataWithTimeout:-1 tag:0];
    [self processData:nil status:eDisconnectSuccess];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    EWPLog(@"thread(%@),onSocket:%p didConnectToHost:%@ port:%hu", [[NSThread currentThread] name], sock, host, port);
    //这是异步返回的连接成功，
    [self processData:nil status:eConnectSuccess];
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收socket------------------------%@",aStr);
    
    [self processData:data status:eReceiveData];
    [_asyncSocket readDataWithTimeout:-1 tag:0];
    
    
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    EWPLog(@"thread(%@),onSocket:%p didWriteDataWithTag:%ld",[[NSThread currentThread] name],sock,tag);
    [self processData:nil status:eWriteDataSuccess];
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}
//-(NSTimeInterval)onSocket: (AsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)exapsed bytesDone:(NSUInteger)length{
//    return -1;
//}
////使 用读操作已超时但还没完成时调用，此方法允许随意延迟超时，如果返回一个正的时间间隔，读取的超时将有一定量的扩展，如果不实现这个方法，或会像往常一样 返回一个负的时间间隔，elapsed参数是  原超时的总和，加上先前通过这种方法添加的任何补充， length参数是 读操作到目前为止已读取的字节数， 注意，如果返回正数的话，这个方法可能被一个单独的读取多次调用
//-(NSTimeInterval)onSocket: (AsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length{
//    return -1;
//}

@end
