//
//  DataBaseManager.m
//  BoXiu
//
//  Created by andy on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"

@interface DataBaseManager ()

@property (nonatomic,strong) FMDatabase *dataBase;//数据库

@end

@implementation DataBaseManager

+ (instancetype)shareDataBaseManager
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
        _dataBase = [FMDatabase databaseWithPath:[self dataBasePath]];
    }
    return self;
}

//返回数据库路径
- (NSString *)dataBasePath
{
    NSArray* paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ;
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"data.db"] ;
}

- (BOOL)deleteDataBase
{
    BOOL result = NO;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[self dataBasePath]])
    {
        [self.dataBase close];
        result = [fileManager removeItemAtPath:[self dataBasePath] error:&error];
        if (result)
        {
            EWPLog(@"删除数据库成功");
        }
        else
        {
            EWPLog(@"删除数据库失败");
        }
    }
    return result;
}

//创建表,默认创建id和time字段
- (BOOL)createTableWithName:(NSString *)tableName keys:(NSArray *)keys
{
    BOOL result = NO;
    if (tableName && [tableName length] && keys && [keys count])
    {
        if ([self.dataBase open])
        {
            EWPLog(@"打开数据成功");
        }
        else
        {
            EWPLog(@"打开数据库失败");
        }
        NSMutableArray *keyMArray = [NSMutableArray arrayWithArray:keys];
        if (![keyMArray containsObject:@"time"])
        {
            [keyMArray addObject:@"time"];
        }
        NSString *allKey = [keyMArray componentsJoinedByString:@","];
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id integer PRIMARY KEY AUTOINCREMENT,%@)",tableName,allKey];
        result = [self.dataBase executeUpdate:sql];
        if (result)
        {
            EWPLog(@"创建表成功");
        }
        else
        {
            [self.dataBase close];
            EWPLog(@"创建表失败");
        }
        [self.dataBase close];
    }
    return result;
}

//删除表
- (BOOL)deleteTableWithName:(NSString *)tableName
{
    BOOL result = NO;
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    result = [self.dataBase executeUpdate:sql];
    if (result)
    {
        EWPLog(@"删除表成功");
    }
    else
    {
        EWPLog(@"删除表失败");
    }
    [self.dataBase close];
    return result;
}

//表是否存在
- (BOOL)isExistOfTable:(NSString *)tableName
{
    BOOL result = NO;
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    FMResultSet *resultSet = [self.dataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([resultSet next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [resultSet intForColumn:@"count"];
        if (0 == count)
        {
            result = NO;
        }
        else
        {
            result = YES;
        }
    }
    [self.dataBase close];
    return result;
}

//表中插入数据
- (BOOL)insertDataToTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue
{
    BOOL result = NO;
    if (tableName == nil || keyAndValue == nil)
    {
        return result;
    }
    if (![self.dataBase tableExists:tableName])
    {
        [self createTableWithName:tableName keys:[keyAndValue allKeys]];
    }
    if (tableName && [tableName length] && keyAndValue && [keyAndValue count])
    {
        if ([self.dataBase open])
        {
            EWPLog(@"打开数据成功");
        }
        else
        {
            EWPLog(@"打开数据库失败");
        }
        NSMutableDictionary *keyAndValueMDic = [NSMutableDictionary dictionaryWithDictionary:keyAndValue];
        id timeObject = [keyAndValueMDic objectForKey:@"time"];
        if (timeObject == nil)
        {
            [keyAndValueMDic setObject:[CommonFuction stringFromDate:[NSDate date]] forKey:@"time"];
        }
      
        NSArray *keyArray = [NSArray arrayWithArray:[keyAndValueMDic allKeys]];
        NSMutableArray *valueArray = [NSMutableArray array];
        for (int nIndex = 0; nIndex < keyArray.count; nIndex++)
        {
            NSString *value = [NSString stringWithFormat:@":%@",[keyArray objectAtIndex:nIndex]];
            [valueArray addObject:value];
        }
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) values(%@)",tableName,[keyArray componentsJoinedByString:@","],[valueArray componentsJoinedByString:@","]];
        result = [self.dataBase executeUpdate:sql withParameterDictionary:keyAndValueMDic];

        if(result)
        {
            EWPLog(@"插入数据成功");
        }
        else
        {
            EWPLog(@"插入数据失败");
        }
        [self.dataBase close];
    }
    return result;
}

//采用事务插入多条数据
- (BOOL)insertDataToTable:(NSString *)tableName keyAndValueArray:(NSArray *)keyAndValueArray
{
    BOOL result = NO;
    if (tableName == nil || keyAndValueArray == nil)
    {
        return result;
    }
    
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    
    [self.dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int nIndex = 0; nIndex < [keyAndValueArray count]; nIndex++)
        {
            NSDictionary *keyAndValue = [keyAndValueArray objectAtIndex:nIndex];
            NSMutableDictionary *keyAndValueMDic = [NSMutableDictionary dictionaryWithDictionary:keyAndValue];
            id timeObject = [keyAndValueMDic objectForKey:@"time"];
            if (timeObject == nil)
            {
                [keyAndValueMDic setObject:[CommonFuction stringFromDate:[NSDate date]] forKey:@"time"];
            }
            NSArray *keyArray = [NSArray arrayWithArray:[keyAndValueMDic allKeys]];
            NSMutableArray *valueArray = [NSMutableArray array];
            for (int nIndex = 0; nIndex < keyArray.count; nIndex++)
            {
                NSString *value = [NSString stringWithFormat:@":%@",[keyArray objectAtIndex:nIndex]];
                [valueArray addObject:value];
            }
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) values(%@)",tableName,[keyArray componentsJoinedByString:@","],[valueArray componentsJoinedByString:@","]];
            result = [self.dataBase executeUpdate:sql withParameterDictionary:keyAndValueMDic];
            if (result)
            {
                EWPLog(@"数据插入成功");
            }
            else
            {
                EWPLog(@"数据插入失败");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.dataBase rollback];
    }
    @finally {
        if (!isRollBack)
        {
            [self.dataBase commit];
        }
    }
    [self.dataBase close];
    return result;
}

//删除数据
- (BOOL)deleteDataFromTable:(NSString *)tableName primaryKeyValue:(NSInteger )primaryKeyValue
{
    BOOL result = NO;
    if (tableName == nil)
    {
        return result;
    }
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    [self.dataBase setShouldCacheStatements:YES];
    if (![self.dataBase tableExists:tableName])
    {
        [self.dataBase close];
        return result;
    }
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = %ld",tableName,(long)primaryKeyValue];
    result = [self.dataBase executeUpdate:sql];
    [self.dataBase close];
    return result;
}

//删除多条数据
- (BOOL)deleteDataFromTable:(NSString *)tableName primaryKeyValues:(NSArray *)primaryKeyValues
{
    BOOL result = NO;
    if (tableName == nil || primaryKeyValues == nil)
    {
        return result;
    }
    
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    [self.dataBase setShouldCacheStatements:YES];
    if (![self.dataBase tableExists:tableName])
    {
        [self.dataBase close];
        return result;
    }
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id in(%@)",tableName,[primaryKeyValues componentsJoinedByString:@","]];
    result = [self.dataBase executeUpdate:sql];
    [self.dataBase close];
    return result;
}

//删除符合条件的数据
- (BOOL)deleteDataFromTable:(NSString *)tableName conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue
{
    BOOL result = NO;
    if (tableName == nil || conditionKeyAndValue == nil)
    {
        return result;
    }
    
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    [self.dataBase setShouldCacheStatements:YES];
    if (![self.dataBase tableExists:tableName])
    {
        [self.dataBase close];
        return result;
    }
    NSString *sql = nil;
    if (conditionKeyAndValue)
    {
        //拼接条件字符串
        NSMutableString *condictionStr = [NSMutableString stringWithString:@"where"];
        NSArray *conditionKeys = [conditionKeyAndValue allKeys];
        NSMutableArray *condithionMArray = [NSMutableArray array];
        for (NSString *key in conditionKeys)
        {
            NSString *value = [conditionKeyAndValue objectForKey:key];
            NSString *str = [NSString stringWithFormat:@"%@='%@'",key,value];
            [condithionMArray addObject:str];
        }
        [condictionStr appendFormat:@" %@",[condithionMArray componentsJoinedByString:@" and "]];
        
        
        sql = [NSString stringWithFormat:@"delete from %@ %@",tableName,condictionStr];
        result = [self.dataBase executeUpdate:sql];
        [self.dataBase close];
        return result;
    }
    
    return result;

}

//根据条件查询记录
- (NSArray *)queryTableWitthName:(NSString *)tableName conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue sortByTime:(BOOL)desc
{
    NSMutableArray *result = [NSMutableArray array];
    if (tableName == nil )
    {
        return result;
    }
    if (tableName && [tableName length])
    {
        if ([self.dataBase open])
        {
            EWPLog(@"打开数据成功");
        }
        else
        {
            EWPLog(@"打开数据库失败");
        }
        
        NSString *sql = nil;
        if (conditionKeyAndValue)
        {
            //拼接条件字符串
            NSMutableString *condictionStr = [NSMutableString stringWithString:@"where"];
            NSArray *conditionKeys = [conditionKeyAndValue allKeys];
            NSMutableArray *condithionMArray = [NSMutableArray array];
            for (NSString *key in conditionKeys)
            {
                NSString *value = [conditionKeyAndValue objectForKey:key];
                NSString *str = [NSString stringWithFormat:@"%@=%@",key,value];
                [condithionMArray addObject:str];
            }
            [condictionStr appendFormat:@" %@",[condithionMArray componentsJoinedByString:@" and "]];
            
            //默认是升序
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ order by time ASC",tableName,condictionStr];
            if (desc)
            {
                sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ order by time DESC",tableName,condictionStr];
            }
        }
        else
        {
            //默认是升序
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by time ASC",tableName];
            if (desc)
            {
                sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by time DESC",tableName];
            }
        }

        FMResultSet *resultSet = [self.dataBase executeQuery:sql];
        while ([resultSet next])
        {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            NSInteger columnCount = [resultSet columnCount];
            for (int nIndex = 0; nIndex <columnCount; nIndex++)
            {
                NSString *columName = [resultSet columnNameForIndex:nIndex];
                NSString *columValue = [resultSet stringForColumn:columName];
                [dataDic setObject:columValue forKey:columName];
            }
            [result addObject:dataDic];
        }
        [self.dataBase close];
    }
    
    return result;

}

//查询数据
- (NSArray *)queryTableWithName:(NSString *)tableName  sortByTime:(BOOL)desc
{
    NSMutableArray *result = [NSMutableArray array];
    if (tableName == nil )
    {
        return result;
    }
    if (tableName && [tableName length])
    {
        if ([self.dataBase open])
        {
            EWPLog(@"打开数据成功");
        }
        else
        {
            EWPLog(@"打开数据库失败");
        }
        //默认是升序
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by time ASC",tableName];
        if (desc)
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by time DESC",tableName];
        }
        FMResultSet *resultSet = [self.dataBase executeQuery:sql];
        while ([resultSet next])
        {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            NSInteger columnCount = [resultSet columnCount];
            for (int nIndex = 0; nIndex <columnCount; nIndex++)
            {
                NSString *columName = [resultSet columnNameForIndex:nIndex];
                NSString *columValue = [resultSet stringForColumn:columName];
                if(columValue.length >0)
                {
                    [dataDic setObject:columValue forKey:columName];
                }
            }
            [result addObject:dataDic];
        }
        [self.dataBase close];
    }

    return result;
}

//按条件更新数据库表
- (BOOL)updateDataInTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue conditionKeyAndValue:(NSDictionary *)conditionKeyAndValue
{
    BOOL result = NO;
    if (tableName == nil || keyAndValue == nil || conditionKeyAndValue == nil)
    {
        return result;
    }
    
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    NSArray *keyArray = [keyAndValue allKeys];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int nIndex = 0; nIndex < [keyArray count]; nIndex++)
    {
        NSString *key = [keyArray objectAtIndex:nIndex];
        NSString *value = [NSString stringWithFormat:@"%@ = (:%@)",key,key];
        [valueArray addObject:value];
    }
    
    //拼接条件字符串
    NSMutableString *condictionStr = [NSMutableString stringWithString:@"where"];
    NSArray *conditionKeys = [conditionKeyAndValue allKeys];
    NSMutableArray *condithionMArray = [NSMutableArray array];
    for (NSString *key in conditionKeys)
    {
        NSString *value = [conditionKeyAndValue objectForKey:key];
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,value];
        [condithionMArray addObject:str];
    }
    [condictionStr appendFormat:@" %@",[condithionMArray componentsJoinedByString:@" and "]];
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ %@",tableName,[valueArray componentsJoinedByString:@","],condictionStr];
    result = [self.dataBase executeUpdate:sql withParameterDictionary:keyAndValue];
    if(result)
    {
        EWPLog(@"更新数据成功");
    }
    else
    {
        EWPLog(@"更新数据失败");
    }
    [self.dataBase close];
    return result;

}

//更新数据
- (BOOL)updateDataInTable:(NSString *)tableName keyAndValue:(NSDictionary *)keyAndValue primaryKeyValue:(NSInteger)primaryKeyValue
{
    BOOL result = NO;
    if (tableName == nil || keyAndValue == nil )
    {
        return result;
    }
    
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    NSArray *keyArray = [keyAndValue allKeys];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int nIndex = 0; nIndex < [keyArray count]; nIndex++)
    {
        NSString *key = [keyArray objectAtIndex:nIndex];
        NSString *value = [NSString stringWithFormat:@"%@ = (:%@)",key,key];
        [valueArray addObject:value];
    }
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where id = %ld",tableName,[valueArray componentsJoinedByString:@","],(long)primaryKeyValue];
    result = [self.dataBase executeUpdate:sql withParameterDictionary:keyAndValue];
    if(result)
    {
        EWPLog(@"更新数据成功");
    }
    else
    {
        EWPLog(@"更新数据失败");
    }
    [self.dataBase close];
    return result;
}

//用事务更新多条数据
- (BOOL)updateDataInTable:(NSString *)tableName keysAndValues:(NSArray *)keysAndValues primaryKeyValues:(NSArray *)primaryKeyValues
{
    BOOL result = NO;
    if (tableName == nil || keysAndValues == nil|| primaryKeyValues == nil
        ||[keysAndValues count] != [primaryKeyValues count])
    {
        return result;
    }
        
    if ([self.dataBase open])
    {
        EWPLog(@"打开数据成功");
    }
    else
    {
        EWPLog(@"打开数据库失败");
    }
    
    [self.dataBase beginDeferredTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int nIndex = 0; nIndex < [keysAndValues count]; nIndex++)
        {
            NSDictionary *keyAndValue = [keysAndValues objectAtIndex:nIndex];
            NSArray *keyArray = [keyAndValue allKeys];
            NSMutableArray *valueArray = [NSMutableArray array];
            for (int nIndex = 0; nIndex < [keyArray count]; nIndex++)
            {
                NSString *key = [keyArray objectAtIndex:nIndex];
                NSString *value = [NSString stringWithFormat:@"%@ = (:%@)",key,key];
                [valueArray addObject:value];
            }
            NSInteger primaryKeyValue = [[primaryKeyValues objectAtIndex:nIndex] integerValue];
            NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where id = %ld",tableName,[valueArray componentsJoinedByString:@","],(long)primaryKeyValue];
            result = [self.dataBase executeUpdate:sql withParameterDictionary:keyAndValue];
            if (result)
            {
                EWPLog(@"数据插入成功");
            }
            else
            {
                EWPLog(@"数据插入失败");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.dataBase rollback];
    }
    @finally {
        if (!isRollBack)
        {
            [self.dataBase commit];
        }
    }
    [self.dataBase close];
    
    return result;
}
@end