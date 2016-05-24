//
//  DataBaseManager.h
//  BoXiu
//
//  Created by andy on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseObject.h"

@interface DataBaseManager : BaseObject
//类方法
+ (instancetype)shareDataBaseManager;

//删除数据库
- (BOOL)deleteDataBase;

//创建表,默认创建id和time字段。
- (BOOL)createTableWithName:(NSString *)tableName keys:(NSArray *)keys;

//删除表
- (BOOL)deleteTableWithName:(NSString *)tableName;

//表是否存在
- (BOOL)isExistOfTable:(NSString *)tableName;

//插入一条数据
- (BOOL)insertDataToTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue;

//采用事务插入多条数据
/*keyAndValueArray参数保存对象类型为NSDictionary*/
- (BOOL)insertDataToTable:(NSString *)tableName keyAndValueArray:(NSArray *)keyAndValueArray;

//删除表数据
- (BOOL)deleteDataFromTable:(NSString *)tableName primaryKeyValue:(NSInteger )primaryKeyValue;

//删除多条数据
/*primaryKeyValues参数保存NSNumber类型数据*/
- (BOOL)deleteDataFromTable:(NSString *)tableName primaryKeyValues:(NSArray *)primaryKeyValues;

//删除符合条件的记录
- (BOOL)deleteDataFromTable:(NSString *)tableName conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue;

//根据条件查询记录
- (NSArray *)queryTableWitthName:(NSString *)tableName conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue sortByTime:(BOOL)desc;

//查询数据,如果参数desc为真，是降序结果，否则默认升序结果
- (NSArray *)queryTableWithName:(NSString *)tableName sortByTime:(BOOL)desc;

//更新数据,KeyAndValue这个为条件的属性和属性值
- (BOOL )updateDataInTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue;

//更新数据，primaryKeyValue为主键id的值
- (BOOL)updateDataInTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue primaryKeyValue:(NSInteger )primaryKeyValue;

//更新多条数据
/*keysAndValues保存对象为NSDictionary*/
/*primaryKeyValues保存对象为NSnumber*/
- (BOOL)updateDataInTable:(NSString *)tableName keysAndValues:(NSArray *)keysAndValues primaryKeyValues:(NSArray *)primaryKeyValues;
@end
