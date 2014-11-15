//
//  LuaScriptManager.m
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVAppManager.h"
#import "SVLuaScriptInteraction.h"
#import "SVLuaConstants.h"
#import "SVEncryptUtils.h"
#import "SVObjectManager.h"
#import "SVScriptCompiler.h"
#import "SVLuaScriptCompiler.h"
#import "SVBaseScriptManager.h"
#import "SVBaseScriptManagerFactory.h"

NSString *kAppWillBeDestoryNotification = @"kAppWillBeDestoryNotification";

@interface SVAppManager ()

@property(nonatomic, retain)SVApp *rootApp;
@property(nonatomic, retain)NSMutableDictionary *appDict;
@property(nonatomic, retain)id<SVScriptCompiler> scriptCompiler;
@property(nonatomic, retain)id<SVScriptManager> baseScriptManager;

@end

@implementation SVAppManager

+ (id)defaultManager
{
    return [self sharedApplication];
}

+ (id)sharedApplication
{
    static typeof(self) instance = nil;
    @synchronized(self.class){
        if(instance == nil){
            instance = [[self.class alloc] init];
        }
    }
    return instance;
}

- (void)dealloc
{
    self.rootApp = nil;
    self.appDict = nil;
    self.scriptCompiler = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.appDict = [NSMutableDictionary dictionary];
    self.scriptCompiler = [SVLuaScriptCompiler defaultScriptCompiler];
    self.baseScriptManager = [SVBaseScriptManagerFactory defaultScriptManagerWithBaseScriptsBundlePath:
                              [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Savanna" ofType:@"bundle"]] bundlePath]];
    
    return self;
}

- (NSString *)compileScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    return [self.scriptCompiler compileScript:script scriptName:scriptName bundleId:bundleId];
}

- (NSString *)scriptWithScriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    SVApp *targetApp = [self.appDict objectForKey:bundleId];
    NSString *script = [targetApp.scriptBundle scriptWithScriptName:scriptName];
    if(script.length == 0){
        script = [self.baseScriptManager compiledScriptWithScriptName:scriptName bundleId:bundleId];
    }else{
        if(![targetApp.scriptBundle isCompiled]){
            script = [self compileScript:script scriptName:scriptName bundleId:[targetApp.scriptBundle bundleId]];
        }
    }
    return script;
}

- (id)runRootApp:(SVApp *)app params:(id)params;
{
    self.rootApp = app;
    return [self runApp:app params:params];
}

- (id)runApp:(SVApp *)app
{
    return [self runApp:app params:nil];
}

- (id)runApp:(SVApp *)app params:(id)params
{
    NSString *paramsId = nil;
    NSString *appId = [app.scriptBundle bundleId];
    if(params){
        if([params isKindOfClass:[NSString class]]){
            paramsId = params;
        }else{
            paramsId = [SVObjectManager addObject:params group:appId];
        }
    }
    [self.appDict setObject:app forKey:[app.scriptBundle bundleId]];
    NSString *mainScript = nil;
    if([app.scriptBundle isCompiled]){
        mainScript = [app.scriptBundle mainScript];
    }else{
        mainScript = [self compileScript:[app.scriptBundle mainScript]
                              scriptName:lua_main_function
                                bundleId:appId];
    }
    NSString *returnValue = nil;
    if(mainScript.length != 0){
        __block SVApp *__app = app;
        SVLuaScriptInteraction *luaScriptInteraction = [[[SVLuaScriptInteraction alloc] initWithScript:mainScript errorMsgThrowBlock:^(NSString *errorMsg) {
            [__app consoleOutput:[NSString stringWithFormat:@"%@", errorMsg]];
        }] autorelease];
        app.scriptInteraction = luaScriptInteraction;
        returnValue = [luaScriptInteraction callFunction:lua_main_function parameters:paramsId != nil ? paramsId : nil, nil];
    }else{
        NSLog(@"run app:%@ failed, main script cannot be found", appId);
        [app consoleOutput:[NSString stringWithFormat:@"run app:%@ failed, main script cannot be found", appId]];
    }
    if(paramsId != nil){
        [SVObjectManager releaseObjectWithId:paramsId group:appId];
    }
    return returnValue;
}

- (void)destoryAppWithAppId:(NSString *)appId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppWillBeDestoryNotification object:appId];
    [self.appDict removeObjectForKey:appId];
    [SVObjectManager removeGroup:appId];
}

- (void)destoryAllApps
{
    NSArray *allAppIds = [self.appDict allKeys];
    for(NSString *appId in allAppIds){
        [self destoryAppWithAppId:appId];
    }
}

- (SVApp *)appForId:(NSString *)appId
{
    return [self.appDict objectForKey:appId];
}

- (UIWindow *)currentWindow
{
    return [self.rootApp baseWindow];
}

- (id<SVScriptInteraction>)scriptInteractionWithAppId:(NSString *)appId
{
    return [[self.appDict objectForKey:appId] scriptInteraction];
}

+ (id<SVScriptInteraction>)scriptInteractionWithAppId:(NSString *)appId
{
    return [[self sharedApplication] scriptInteractionWithAppId:appId];
}

+ (SVApp *)appForId:(NSString *)appId
{
    return [[self sharedApplication] appForId:appId];
}

+ (NSMutableDictionary *)appDictionary
{
    return [[self sharedApplication] appDict];
}

+ (UIWindow *)currentWindow
{
    return [[self sharedApplication] currentWindow];
}

+ (NSString *)scriptWithScriptName:(NSString *)scriptName appId:(NSString *)appId
{
    NSString *script = [[self sharedApplication] scriptWithScriptName:scriptName bundleId:appId];
    
    return script;
}

+ (id)runRootApp:(SVApp *)app
{
    return [[self sharedApplication] runRootApp:app params:nil];
}

+ (id)runRootApp:(SVApp *)app params:(id)params
{
    return [[self sharedApplication] runRootApp:app params:params];
}

+ (id)runApp:(SVApp *)app
{
    return [[self sharedApplication] runApp:app];
}

+ (id)runApp:(SVApp *)app params:(id)params
{
    return [[self sharedApplication] runApp:app params:params];
}

+ (void)destoryAppWithAppId:(NSString *)appId
{
    [[self sharedApplication] destoryAppWithAppId:appId];
}

+ (void)destoryAllApps
{
    [[self sharedApplication] destoryAllApps];
}

+ (NSBundle *)baseScriptsBundle
{
    static NSBundle *baseScriptsBundle = nil;
    if(baseScriptsBundle == nil){
        baseScriptsBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Savanna" ofType:@".bundle"]];
    }
    return baseScriptsBundle;
}

@end
