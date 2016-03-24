//
//  CommandManager.h
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "Command.h"
#import "SUByteConvert.h"
#import "TcpServerInterface.h"

#define CONNECT_SUCCESS @"CONNECT_SUCCESS"

#define WILL_DISCONNECT_WITHERRO @"WILL_DISCONNECT_WITHERRO"

#define DISCONNECT_SUCCESS @"DISCONNECT_SUCCESS"

#define CONNECT_FAIL    @"CONNECT_FAIL"

#define AUTH_RESULT    @"AUTH_SUCCESS"
#define ENTER_ROOM_RESULT @"ENTER_ROOM_RESULT"

#define RECEIVE_ROOM_MESSAGE @"RECEIVE_ROOM_MESSAGE"
#define RECEIVE_GLOBAL_MESSAGE @"RECEIVE_GLOBAL_MESSAGE"

#define RECEIVE_GIFT    @"RECEIVE_GIFT"
#define RECEIVE_SOFA    @"RECEIVE_SOFA"

#define RECEIVE_ERRO    @"RECEIVE_ERRO"

#define GET_APPROVE_RESULT @"GET_APPROVE_RESULT"
#define SEND_APPROVE_RESULT @"SEND_APPROVE_RESULT"

#define RECEIVE_ENTNERROOM_MESSAGE @"RECEIVE_ENTNERROOM_MESSAGE"//进入房间消息
#define RECEIVE_OUTROOM_MESSAGE @"RECEIVE_OUTROOM_MESSAGE"//退出房间消息

#define RECEIVE_SENDNOTICE_MESSAGE @"RECEIVE_SENDNOTICE_MESSAGE" //首次触发点赞效果通知

#define SEND_DATA_FAIL   @"SEND_DATA_FAIL"//如果网络不通，返回发送数据失败

#define RECEIVE_BARAGE_MESSAGE @"RECEIVE_BARAGE_MESSAGE"//收到弹幕消息

#define RECEIVE_SHOWTIMECHANGE_MESSAGE @"RECEIVE_SHOWTIMECHANGE_MESSAGE"
#define RECEIVE_SHOWTIMEBEGIN_MESSAGE @"RECEIVE_SHOWTIMEBEGIN_MESSAGE"
#define RECEIVE_SHOWTIMEEND_MESSAGE @"RECEIVE_SHOWTIMEEND_MESSAGE"

#define RECEIVE_MUSICCHANGE_MESSAGE @"RECEIVE_MUSICCHANGE_MESSAGE"
#define RECEIVE_SHOWTIME_DATA_MESSAGE @"RECEIVE_SHOWTIME_DATA_MESSAGE"

#define SEND_SHOWTIME_APPROVE_RESULT @"SEND_SHOWTIME_APPROVE_RESULT"
#define BUTTON_SENDPRESSED_MESSAGE @"butonGuanZhuPressed"

#define MAX_READ_BUFFER_SIZE (1024 * 10)//每次读取最大缓冲大小10K

typedef enum _DataType
{
    eHeart_Type = 1,
    eAuth_Type,
    eOther_Type
}DataType;

@interface CommandManager : NSObject<TcpServerInterfaceDelegate>

@property (nonatomic,strong) NSMutableData *receiveBuffer;//可变缓冲区

@property (nonatomic,strong) NSMutableArray *dataMArray;

@property (nonatomic,strong) TcpServerInterface *tcpServerInterface;

@property (nonatomic,assign) BOOL tcpConnecting;
@property (nonatomic,assign) BOOL connectSuccess;

+ (CommandManager *)shareInstance;

- (void)processData:(NSData *)data;
- (void)connectServer:(NSString *)serverip serverport:(NSInteger)serverport;
- (void)disConnectServer;
- (void)sendData:(NSData *)data;
- (void)sendData:(NSData *)data DataType:(DataType)dataType;

@end
