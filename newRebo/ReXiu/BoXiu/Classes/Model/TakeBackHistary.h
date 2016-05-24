//
//  TakeBackHistary.h
//  BoXiu
//
//  Created by andy on 15/12/2.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface TakeBackHistary : BaseHttpModel
@property (strong, nonatomic)NSString* strPageIndex;
@property (strong, nonatomic)NSString* strPageSize;
@property (strong, nonatomic)NSString* strPagination;
@property (strong, nonatomic)NSString* strRecordCount;
@property (strong, nonatomic)NSMutableArray* dataArray;
@property (strong, nonatomic)NSString* strTotolMoney;

@end

@interface  TakeBack : NSObject
@property (strong, nonatomic)NSString* strAccountname;
@property (strong, nonatomic)NSString* strBean;
@property (strong, nonatomic)NSString* strDatetime;
@property (strong, nonatomic)NSString* strExchangerate;
@property (strong, nonatomic)NSString* strMoney;
@property (strong, nonatomic)NSString* strStatus;
@property (strong, nonatomic)NSString* strUserid;
@property (strong, nonatomic)NSString* strId;

@end