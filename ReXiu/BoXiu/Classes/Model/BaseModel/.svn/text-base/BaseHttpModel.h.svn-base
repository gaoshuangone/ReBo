//
//  BaseHttpModel.h
//  BoXiu
//
//  Created by andy on 14-9-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HttpModel.h"

@interface BaseHttpModel : HttpModel
@property (nonatomic,strong) id data;//返回数据
@property (nonatomic,assign) NSInteger result;//1代表失败，0代表成功
@property (nonatomic,strong) NSString *title;//当result等于1时，错误提示标题
@property (nonatomic,strong) NSString *msg;//当result等于1时，错误提示内容
@property (nonatomic,assign) NSInteger code;//返回码//当code=403 时候，msg==1 没有登录  ==2超时  ==3 账号在其他地方登陆   ==4登陆了但没有权限操作

- (NSDictionary *)httpHeaderWithMethod:(NSString *)method;
- (NSDictionary *)signParamWithMethod:(NSString *)method;
- (void)autAddNumber;
@end
