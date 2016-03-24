//
//  ConfirmTxModel.m
//  BoXiu
//
//  Created by andy on 15/12/1.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "ConfirmTxModel.h"

@implementation ConfirmTxModel
-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail{
    [self requestDataWithMethod:ConfirmTx_Method params:params success:success fail:fail];
}
@end
