//
//  FiltUtils.m
//  Queries
//
//  Created by yangzexin on 13-2-5.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LIFileUtils.h"
#import "SVAppManager.h"
#import "SVZipHandler.h"
#import "SVZipHandlerFactory.h"
#import "SVCommonUtils.h"

@implementation LIFileUtils

+ (void)moveFileWithSourcePath:(NSString *)srcPath destinationPath:(NSString *)desPath
{
    [[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:desPath error:nil];
}

+ (NSString *)readString:(NSString *)path
{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+ (void)upzipFile:(NSString *)zipFilePath
           toPath:(NSString *)path
        overWrite:(BOOL)overWrite
            appId:(NSString *)appId
            objId:(NSString *)objId
     completeFunc:(NSString *)completeFunc
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<SVZipHandler> zipHandler = [SVZipHandlerFactory defaultZipHandler];
        [zipHandler unzipWithFilePath:zipFilePath toDirectoryPath:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SVAppManager scriptInteractionWithAppId:appId] callFunction:completeFunc parameters:objId, nil];
        });
    });
}

+ (void)zipDirectory:(NSString *)dirPath
          toFilePath:(NSString *)toFilePath
               appId:(NSString *)appId
               objId:(NSString *)objId
        completeFunc:(NSString *)completeFunc
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<SVZipHandler> zipHandler = [SVZipHandlerFactory defaultZipHandler];
        [zipHandler zipWithDirectoryPath:dirPath toFilePath:toFilePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SVAppManager scriptInteractionWithAppId:appId] callFunction:completeFunc parameters:objId, nil];
        });
    });
}

+ (BOOL)isDirectory:(NSString *)path
{
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    return isDir;
}

+ (NSString *)documentPath
{
    return [SVCommonUtils documentPath];
}

+ (NSString *)randomString
{
    return [SVCommonUtils randomString];
}

+ (NSString *)tmpPath
{
    return [SVCommonUtils tmpPath];
}

+ (NSString *)libraryPath
{
    return [SVCommonUtils libraryPath];
}

+ (NSString *)homePath
{
    return [SVCommonUtils homePath];
}

@end
