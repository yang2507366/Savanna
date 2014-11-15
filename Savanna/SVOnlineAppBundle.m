//
//  SVOnlineAppBundle.m
//  Savanna
//
//  Created by yangzexin on 13-3-7.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVOnlineAppBundle.h"
#import "SVLocalAppBundle.h"
#import "SVCommonUtils.h"
#import "SVTimeCostTracer.h"

@interface SVOnlineAppBundle ()

@property(nonatomic, retain)id<SVScriptBundle> localAppBundle;

@end

@implementation SVOnlineAppBundle

- (void)dealloc
{
    self.localAppBundle = nil;
    [super dealloc];
}

- (id)initWithURL:(NSURL *)url
{
    return [self initWithURL:url timeoutInterval:0.0f];
}

- (id)initWithURL:(NSURL *)url timeoutInterval:(NSTimeInterval)timeoutInterval
{
    self = [super init];
    
    [SVTimeCostTracer markWithIdentifier:@"download_app"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [SVTimeCostTracer timeCostWithIdentifier:@"download_app" print:YES];
    NSString *tmpFileName = [SVCommonUtils countableTempFileName:@"tmp_bundle.zip" atDirectory:[SVCommonUtils tmpPath]];
    NSString *tmpFilePath = [[SVCommonUtils tmpPath] stringByAppendingPathComponent:tmpFileName];
    [data writeToFile:tmpFilePath atomically:NO];
    
    self.localAppBundle = [[[SVLocalAppBundle alloc] initWithPackageFile:tmpFilePath] autorelease];
    
    if(!self.localAppBundle){
        return nil;
    }
    
    return self;
}

- (NSString *)bundleId
{
    return [self.localAppBundle bundleId];
}

- (NSString *)scriptWithScriptName:(NSString *)scriptName
{
    return [self.localAppBundle scriptWithScriptName:scriptName];
}

- (NSData *)resourceWithName:(NSString *)resName
{
    return [self.localAppBundle resourceWithName:resName];
}

- (BOOL)resourceExistsWithName:(NSString *)resName
{
    return [self.localAppBundle resourceExistsWithName:resName];
}

- (NSString *)bundleVersion
{
    return [self.localAppBundle bundleVersion];
}

- (NSString *)mainScript
{
    return [self.localAppBundle mainScript];
}

- (BOOL)isCompiled
{
    return [self.localAppBundle isCompiled];
}

- (NSArray *)scriptNames
{
    return [self.localAppBundle scriptNames];
}

- (NSArray *)resourceNames
{
    return [self.localAppBundle resourceNames];
}

@end
