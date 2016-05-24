
//
//  CommandManager.m
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "CommandManager.h"
#import "TcpServerInterface.h"

@interface CommandManager ()
@property (nonatomic,strong) NSTimer *getBufferTimer;
@end
@implementation CommandManager

+ (CommandManager *)shareInstance
{
    static dispatch_once_t predicate;
    static CommandManager* instance;
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
        self.tcpServerInterface = [TcpServerInterface shareServerInterface];
        self.tcpServerInterface.delegate = self;
    }
    return self;
}

- (void)connectServer:(NSString *)serverip serverport:(NSInteger)serverport
{
    if (self.tcpServerInterface)
    {
        self.tcpConnecting = YES;
        [self.tcpServerInterface connectServer:serverip serverport:serverport];
    }
}

- (void)disConnectServer
{
    if (self.tcpServerInterface)
    {
        [self.tcpServerInterface disconnectServer];
    }
}

- (void)tcpConnectSuccess
{
    self.tcpConnecting = NO;
    self.connectSuccess = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:CONNECT_SUCCESS object:nil userInfo:nil];
}

- (void)tcpDisconnectSuccess
{
    self.tcpConnecting = NO;
    self.connectSuccess = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:DISCONNECT_SUCCESS object:nil userInfo:nil];
}

- (void)tcpWillDisconnectWithErro
{
    [[NSNotificationCenter defaultCenter] postNotificationName:WILL_DISCONNECT_WITHERRO object:nil userInfo:nil];
}

//处理接收到得数据

-(void)processData
{
    @autoreleasepool {
        if ([_receiveBuffer length] < 10)
        {
            return;
        }
        
        NSData *data = [_receiveBuffer subdataWithRange:NSMakeRange(0, 10)];
        int packLen = 0;
        
        char buffer[4] = {0};
        int bodyLen = 0;
        
        //解析bodyLen
        [data getBytes:buffer range:NSMakeRange(0, 4)];
        bodyLen = [SUByteConvert byteArrayToInt:buffer];
        packLen += 4;
        
        //解析cmd
        memset(buffer, 0, sizeof(char) * 4);
        [data getBytes:buffer range:NSMakeRange(4, sizeof(COMMAND_ID))];
        COMMAND_ID cmd = [SUByteConvert byteArrayToShort:buffer];
        packLen += 2;
        
        //跳过4个空字节
        packLen += 4;
        
        if (bodyLen > 0)
        {
            if ([_receiveBuffer length] >= bodyLen + 10)
            {
                char *body = nil;
                NSData *bodyData = nil;
                body = (char *)malloc(bodyLen);
                bodyData = [_receiveBuffer subdataWithRange:NSMakeRange(10, bodyLen)];
                packLen += bodyLen;
                free(body);
                [self processBodyData:bodyData cmd:cmd];
                //从缓冲区去掉该完整包
                [_receiveBuffer setData:[_receiveBuffer subdataWithRange:NSMakeRange(packLen, [_receiveBuffer length] - packLen)]];
                [self processData];
                
            }
            else
            {
                return;
            }
        }
        else
        {
            [self processBodyData:nil cmd:cmd];
            //从缓冲区去掉该完整包
            [_receiveBuffer setData:[_receiveBuffer subdataWithRange:NSMakeRange(packLen, [_receiveBuffer length] - packLen)]];
            [self processData];
        }
    }
}

- (void)processBodyData:(NSData *)data cmd:(COMMAND_ID)cmd
{
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    if (data && [data length] > 0)
    {
        [bodyDic setValuesForKeysWithDictionary:(NSDictionary *)[data objectFromJSONData]];
    }
    
    NSLog(@"TCP------------------接收-------%@--%@",[bodyDic valueForKey:@"msg"],[bodyDic valueForKey:@"nick"]);
    //将data转换为json数据传给
    if (cmd == CM_AUTH_RESULT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AUTH_RESULT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_HEART)
    {
        EWPLog(@"receive heart");
    }
    else if (cmd == CM_ENTERROOM_RESULT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:ENTER_ROOM_RESULT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_ROOM_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_GLOBAL_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_GLOBAL_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_GIFT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_GIFT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_SOFA)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SOFA object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_ERRO)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_ERRO object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_GET_APPROVE_RESULT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:GET_APPROVE_RESULT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_SEND_APPROVE_RESULT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:SEND_APPROVE_RESULT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_ENTNERROOM_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_ENTNERROOM_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_BARAGEMESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_BARAGE_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_MUSICCHANGE_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_MUSICCHANGE_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_SHOWTIMECHANGE_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SHOWTIMECHANGE_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_SHOWTIMEBEGIN_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SHOWTIMEBEGIN_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_SHOWTIMEEND_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SHOWTIMEEND_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_RECEIVE_SHOWTIME_DATA_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SHOWTIME_DATA_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_SEND_SHOWTIME_APPROVE_RESULT)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:SEND_SHOWTIME_APPROVE_RESULT object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_OUT_ROOM)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_OUTROOM_MESSAGE object:nil userInfo:bodyDic];
    }
    else if (cmd == CM_SENDNOTICE_MESSAGE)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVE_SENDNOTICE_MESSAGE object:nil userInfo:bodyDic];
    }
}

- (void)sendData:(NSData *)data
{
    [self sendData:data DataType:eOther_Type];
}

- (void)sendData:(NSData *)data DataType:(DataType)dataType
{
    if (self.connectSuccess)
    {
        [[TcpServerInterface shareServerInterface] sendData:data];
    }
    else
    {
        if (dataType == eOther_Type)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:SEND_DATA_FAIL object:[NSNumber numberWithBool:self.tcpConnecting] userInfo:nil];
        }
    }
    
}


- (void)putDataToBuffer:(NSData *)data
{
    //将数据放入缓冲区
    
    if (_receiveBuffer == nil)
    {
        _receiveBuffer = [[NSMutableData alloc] init];
    }
    
    [_receiveBuffer appendData:data];
    NSLog(@"-------%@---%ld",(NSDictionary *)[data objectFromJSONData],_receiveBuffer.length);
    [self processData];
    
    
    
}

#pragma mark - TcpServerInterfaceDelegate
- (void)progressData:(NSData *)data status:(TcpStatus)status
{
    switch (status)
    {
        case eWillDisconnectWithErro:
        {
            [self tcpWillDisconnectWithErro];
        }
            break;
        case eDisconnectSuccess:
        {
            [self tcpDisconnectSuccess];
        }
            break;
        case eConnectSuccess:
        {
            [self tcpConnectSuccess];
        }
            break;
        case eReceiveData:
        {
            [self putDataToBuffer:data];
        }
            break;
        case eWriteDataSuccess:
            break;
        default:
            break;
    }

}

@end
