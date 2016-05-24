//
//  TcpModelProtocol.h
//  BoXiu
//
//  Created by Andy on 14-4-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TcpServerInterface.h"

@protocol TcpModelProtocol <NSObject>

@required

- (void)analyseData:(NSDictionary *)dataDic;

@optional

- (id)initWithData:(NSDictionary *)dataDic;
@end
