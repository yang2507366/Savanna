//
//  LuaScriptManager.h
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptInteraction.h"
#import "SVScriptBundle.h"
#import "SVApp.h"

OBJC_EXPORT NSString *kAppWillBeDestoryNotification;

@interface SVAppManager : NSObject

+ (NSBundle *)baseScriptsBundle;

+ (UIWindow *)currentWindow;
+ (id<SVScriptInteraction>)scriptInteractionWithAppId:(NSString *)appId;
+ (NSString *)scriptWithScriptName:(NSString *)scriptName appId:(NSString *)appId;
+ (SVApp *)appForId:(NSString *)appId;

+ (id)runRootApp:(SVApp *)app;
+ (id)runRootApp:(SVApp *)app params:(id)params;
+ (id)runApp:(SVApp *)app;
+ (id)runApp:(SVApp *)app params:(id)params;
+ (void)destoryAppWithAppId:(NSString *)appId;
+ (void)destoryAllApps;

@end
