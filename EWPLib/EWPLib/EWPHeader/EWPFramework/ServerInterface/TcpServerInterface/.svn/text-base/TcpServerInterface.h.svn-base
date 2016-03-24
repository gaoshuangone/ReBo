//
//  TcpServerInterface.h
//  BoXiu
//
//  Created by Andy on 14-4-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseObject.h"
#import "TcpModelProtocol.h"

typedef void(^TcpServerInterfaceBlock)(id object);

typedef enum
{
    eWillDisconnectWithErro = 1,
    eDisconnectSuccess,
    eConnectSuccess,
    eReceiveData,
    eWriteDataSuccess,
}TcpStatus;

@protocol TcpServerInterfaceProtocol <NSObject>

- (void)sendData:(NSData *)data;
- (void)processData:(NSData *)data status:(TcpStatus)status;

@end

@protocol TcpServerInterfaceDelegate <NSObject>

- (void)progressData:(NSData *)data status:(TcpStatus)status;

@end

@interface TcpServerInterface : BaseObject<TcpServerInterfaceProtocol>

@property (nonatomic,assign) id<TcpServerInterfaceDelegate> delegate;

+ (id)shareServerInterface;
- (void)connectServer:(NSString *)serverip serverport:(NSInteger )serverport;
- (void)disconnectServer;

- (BOOL)isConnected;

- (void)sendData:(NSData *)data;
- (void)processData:(NSData *)data status:(TcpStatus)status;

@end
