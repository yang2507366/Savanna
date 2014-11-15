//
//  OnlineAppBundle.m
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVLocalAppBundle.h"
#import "NSString+SVJavaLikeStringHandle.h"
#import "SVLuaCommonUtils.h"
#import "SVZipHandler.h"
#import "SVZipHandlerFactory.h"
#import "SVCommonUtils.h"
#import "SVTimeCostTracer.h"

@interface SVLocalAppBundle ()

@property(nonatomic, copy)NSString *dirPath;
@property(nonatomic, copy)NSString *speacifiedBundleId;

@end

@implementation SVLocalAppBundle

- (void)dealloc
{
    self.dirPath = nil;
    self.speacifiedBundleId = nil;
    [super dealloc];
}

- (id)initWithDirectory:(NSString *)dirPath bundleId:(NSString *)bundleId
{
    self = [super init];
    
    self.dirPath = dirPath;
    self.speacifiedBundleId = bundleId;
    
    return self;
}

- (id)initWithDirectory:(NSString *)dirPath
{
    return [self initWithDirectory:dirPath bundleId:nil];
}

- (NSString *)scriptFolderPath
{
    return [self.dirPath stringByAppendingPathComponent:@"src"];
}

- (NSString *)resourceFilderPath
{
    return [self.dirPath stringByAppendingPathComponent:@"res"];
}

- (id)initWithPackageFile:(NSString *)packageFile
{
    [SVTimeCostTracer markWithIdentifier:@"unzip_package"];
    NSString *dirPath = nil;
    id<SVZipHandler> zip = [SVZipHandlerFactory defaultZipHandler];
    NSString *tmpParentPath = [[SVCommonUtils tmpPath] stringByAppendingPathComponent:@"app_caches"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:tmpParentPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:tmpParentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *tmpFileName = [SVCommonUtils countableTempFileName:@"temp" atDirectory:tmpParentPath];
    NSString *tmpDirPath = [tmpParentPath stringByAppendingPathComponent:tmpFileName];
    [zip unzipWithFilePath:packageFile toDirectoryPath:tmpDirPath];
    [SVTimeCostTracer timeCostWithIdentifier:@"unzip_package" print:YES];
    NSArray *tmpFileNameList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:tmpDirPath error:nil];
    if(tmpFileNameList.count == 1){
        NSString *fileName = [tmpFileNameList objectAtIndex:0];
        dirPath = [tmpDirPath stringByAppendingPathComponent:fileName];
        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
        dirPath = isDir ? dirPath : nil;
    }
    if(dirPath.length != 0){
        self = [self initWithDirectory:dirPath];
        return self;
    }
    return nil;
}

- (id)objectFromAppConfigurationWithKey:(NSString *)key
{
    NSString *projectInfoFile = @"project.plist";
    if([self resourceExistsWithName:projectInfoFile]){
        NSString *filePath = [[self resourceFilderPath] stringByAppendingPathComponent:projectInfoFile];
        NSDictionary *projectInfo = [NSDictionary dictionaryWithContentsOfFile:filePath];
        return [projectInfo objectForKey:key];
    }
    return nil;
}

- (NSString *)bundleId
{
    if(self.speacifiedBundleId){
        return self.speacifiedBundleId;
    }
    return [self.dirPath lastPathComponent];
}

- (NSString *)scriptWithScriptName:(NSString *)scriptName
{
    if(![scriptName hasSuffix:@".lua"]){
        scriptName = [NSString stringWithFormat:@"%@.lua", scriptName];
    }
    NSString *filePath = [[self scriptFolderPath] stringByAppendingPathComponent:scriptName];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    return script;
}

- (NSData *)resourceWithName:(NSString *)resName
{
    NSString *filePath = [[self resourceFilderPath] stringByAppendingPathComponent:resName];
    return [NSData dataWithContentsOfFile:filePath];
}

- (BOOL)resourceExistsWithName:(NSString *)resName
{
    NSString *filePath = [[self resourceFilderPath] stringByAppendingPathComponent:resName];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

- (NSArray *)allScriptFileNames
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *subfiles = [fileMgr contentsOfDirectoryAtPath:[self scriptFolderPath] error:nil];
    NSMutableArray *filteredFiles = [NSMutableArray array];
    for(NSString *fileName in subfiles){
        if([fileName hasSuffix:@".lua"]){
            [filteredFiles addObject:fileName];
        }
    }
    return filteredFiles;
}

- (NSString *)mainScript
{
    NSString *srcPath = [self scriptFolderPath];
    NSString *projectSpeacifiedMainScriptName = [self objectFromAppConfigurationWithKey:@"kProjectMainScriptNameKey"];
    if(projectSpeacifiedMainScriptName.length != 0){
        if(![[projectSpeacifiedMainScriptName lowercaseString] hasSuffix:@".lua"]){
            projectSpeacifiedMainScriptName = [NSString stringWithFormat:@"%@.lua", projectSpeacifiedMainScriptName];
        }
        NSString *script = [NSString stringWithContentsOfFile:[srcPath stringByAppendingPathComponent:projectSpeacifiedMainScriptName]
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
        return script;
    }else{
        NSArray *scriptList = [self allScriptFileNames];
        for(NSString *file in scriptList){
            NSString *filePath = [srcPath stringByAppendingPathComponent:file];
            NSString *script = [NSString stringWithContentsOfFile:filePath
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
            if([SVLuaCommonUtils scriptIsMainScript:script]){
//                NSLog(@"%@ find main script in file:%@", self.bundleId, file);
                return script;
            }
        }
    }
    return nil;
}

- (NSString *)bundleVersion
{
    return @"0.0.0";
}

- (BOOL)isCompiled
{
    NSNumber *b = [self objectFromAppConfigurationWithKey:@"kProjectCompileStateKey"];
    if(b){
        return [b boolValue];
    }
    return NO;
}

- (NSArray *)scriptNames
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self scriptFolderPath] error:nil];
}

- (NSArray *)resourceNames
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self resourceFilderPath]
                                                               error:nil];
}

@end
