//
//  AppRunImpl.m
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LIAppRunner.h"
#import "SVLuaConstants.h"
#import "SVLocalAppBundle.h"
#import "SVApp.h"
#import "SVAppManager.h"
#import "SVObjectManager.h"
#import "SVLuaCommonUtils.h"
#import "SVOnlineAppBundleLoader.h"
#import "SVLocalAppBundle.h"
#import "SVLuaCommonUtils.h"

@interface LIAppRunner ()

@property(nonatomic, retain)SVOnlineAppBundleLoader *onlineAppBundleLoader;
@property(nonatomic, retain)NSURL *url;
@property(nonatomic, retain)id params;
@property(nonatomic, retain)UIViewController *relatedViewController;
@property(nonatomic, retain)SVApp *app;

@end

@implementation LIAppRunner

@synthesize objId;
@synthesize appId;

+ (void)runWithAppId:(NSString *)appId targetAppId:(NSString *)targetAppId params:(NSString *)params relatedViewControllerId:(NSString *)rvcId
{
    if([SVLuaCommonUtils isObjCObject:params]){
        params = [SVObjectManager objectWithId:params group:appId];
    }
    NSString *appDir = [lua_app_bundle_dir stringByAppendingPathComponent:targetAppId];
    SVLocalAppBundle *appBundle = [[[SVLocalAppBundle alloc] initWithDirectory:appDir] autorelease];
    SVApp *app = [[[SVApp alloc] initWithScriptBundle:appBundle baseWindow:nil] autorelease];
    app.relatedViewController = [SVObjectManager objectWithId:rvcId group:appId];
    [SVAppManager runApp:app params:params];
}

+ (void)destoryAppWithAppId:(NSString *)appId targetAppId:(NSString *)targetAppId
{
    [SVAppManager destoryAppWithAppId:targetAppId];
}

+ (void)destoryAppWithTargetAppId:(NSString *)targetAppId
{
    [self destoryAppWithAppId:nil targetAppId:targetAppId];
}

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    self._completion = nil;
    self.url = nil;
    self.params = nil;
    self.relatedViewController = nil;
    [self cancel]; self.onlineAppBundleLoader = nil;
    [super dealloc];
}

- (void)start
{
    self.onlineAppBundleLoader = [[[SVOnlineAppBundleLoader alloc] initWithURLString:[self.url absoluteString]] autorelease];
    __block typeof(self) bself = self;
    [self.onlineAppBundleLoader loadWithCompletion:^(NSString *downloadedZipPath) {
        [bself completion:downloadedZipPath];
    }];
}

- (void)runWithURL:(NSURL *)url params:(NSDictionary *)params relatedViewController:(id)relatedViewController
{
    self.url = url;
    self.params = params;
    self.relatedViewController = relatedViewController;
    [self start];
}

- (void)cancel
{
    [self.onlineAppBundleLoader cancel];
}

- (void)destory
{
    if(self.app){
        [SVAppManager destoryAppWithAppId:[self.app.scriptBundle bundleId]];
    }
}

- (void)completion:(NSString *)downloadZipPath
{
    BOOL success = NO;
    NSString *returnValue = nil;
    SVLocalAppBundle *appBundle = [[[SVLocalAppBundle alloc] initWithPackageFile:downloadZipPath] autorelease];
    if(appBundle){
        success = YES;
        self.app = [[[SVApp alloc] initWithScriptBundle:appBundle relatedViewController:self.relatedViewController] autorelease];
        returnValue = [SVAppManager runApp:self.app params:self.params];
    }
    if(self._completion.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._completion
                                                                parameters:self.objId, [SVLuaCommonUtils toLuaBool:success], returnValue, nil];
    }
}

+ (id)create:(NSString *)appId
{
    LIAppRunner *appRunner = [[LIAppRunner new] autorelease];
    appRunner.objId = [SVObjectManager addObject:appRunner group:appId];
    appRunner.appId = appId;
    
    return appRunner.objId;
}

@end
