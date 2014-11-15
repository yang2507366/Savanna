//
//  SVScriptBundleManager.m
//  Savanna
//
//  Created by yangzexin on 3/15/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "SVScriptBundleRepository.h"
#import "SVCommonUtils.h"
#import "SVEncryptUtils.h"
#import "SVLocalAppBundle.h"

@interface SVScriptBundleFileRepository : NSObject <SVScriptBundleRepository>

@property(nonatomic, copy)NSString *storagePath;

@end

@implementation SVScriptBundleFileRepository

- (id)init
{
    self = [super init];
    
    self.storagePath = [[SVCommonUtils libraryPath] stringByAppendingPathComponent:@"bundle_repository"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:self.storagePath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:self.storagePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return self;
}

- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle
{
    [self repositScriptBundle:scriptBundle newBundleId:nil];
}

- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle newBundleId:(NSString *)newBundleId
{
    NSArray *scriptNames = [scriptBundle scriptNames];
    NSArray *resourceNames = [scriptBundle resourceNames];
    NSString *bundleIdWithMD5 = [SVEncryptUtils hexStringByMD5EncryptingString:newBundleId.length == 0 ? [scriptBundle bundleId] : newBundleId];
    NSString *bundleStorePath = [self.storagePath stringByAppendingPathComponent:bundleIdWithMD5];
    if([[NSFileManager defaultManager] fileExistsAtPath:bundleStorePath]){
        [[NSFileManager defaultManager] removeItemAtPath:bundleStorePath error:nil];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:bundleStorePath withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *resFolderPath = [bundleStorePath stringByAppendingPathComponent:@"res"];
    [[NSFileManager defaultManager] createDirectoryAtPath:resFolderPath withIntermediateDirectories:NO attributes:nil error:nil];
    for(NSString *resourceName in resourceNames){
        [[scriptBundle resourceWithName:resourceName] writeToFile:[resFolderPath stringByAppendingPathComponent:resourceName] atomically:NO];
    }
    
    NSString *srcFolderPath = [bundleStorePath stringByAppendingPathComponent:@"src"];
    [[NSFileManager defaultManager] createDirectoryAtPath:srcFolderPath withIntermediateDirectories:NO attributes:nil error:nil];
    for(NSString *scriptName in scriptNames){
        [[scriptBundle scriptWithScriptName:scriptName] writeToFile:[srcFolderPath stringByAppendingPathComponent:scriptName]
                                                         atomically:NO
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil];
    }
}

- (id<SVScriptBundle>)scriptBundleWithBundleId:(NSString *)bundleId
{
    NSString *bundleIdWithMD5 = [SVEncryptUtils hexStringByMD5EncryptingString:bundleId];
    NSString *bundlePath = [self.storagePath stringByAppendingPathComponent:bundleIdWithMD5];
    if([[NSFileManager defaultManager] fileExistsAtPath:bundlePath]){
        return [[[SVLocalAppBundle alloc] initWithDirectory:bundlePath bundleId:bundleId] autorelease];
    }
    return nil;
}

@end

@interface SVScriptBundleRepository ()

@property(nonatomic, retain)id<SVScriptBundleRepository> respository;

@end

@implementation SVScriptBundleRepository

+ (id)defaultRespository
{
    static id instance = nil;
    if(instance == nil){
        instance = [self.class new];
    }
    return instance;
}

- (void)dealloc
{
    self.respository = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.respository = [[SVScriptBundleFileRepository new] autorelease];
    
    return self;
}

- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle
{
    [self.respository repositScriptBundle:scriptBundle];
}

- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle newBundleId:(NSString *)newBundleId
{
    [self.respository repositScriptBundle:scriptBundle newBundleId:newBundleId];
}

- (id<SVScriptBundle>)scriptBundleWithBundleId:(NSString *)bundleId
{
    return [self.respository scriptBundleWithBundleId:bundleId];
}

@end
