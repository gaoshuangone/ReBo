//
//  FileManager.h
//  BoXiu
//
//  Created by andy on 15-1-21.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(BOOL)fileExistsAtPath:(NSString *)path;

+(NSString *)getDocumentsPath;

+ (NSString *)getCachePath;

+(BOOL)createDirectoryWithPath:(NSString *)path;

+(BOOL)removeFileAtPath:(NSString *)filePath;

+(BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName;

+(NSData *)readFileContent:(NSString *)filePath;

+(BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName;

+(float)getFileSize:(NSString *)filePath;


@end
