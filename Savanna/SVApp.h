//
//  LuaApp.h
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptBundle.h"
#import "SVScriptInteraction.h"

@interface SVApp : NSObject

@property(nonatomic, readonly)id<SVScriptBundle> scriptBundle;
@property(nonatomic, retain)id<SVScriptInteraction> scriptInteraction;
@property(nonatomic, retain)UIWindow *baseWindow;
@property(nonatomic, retain)UIViewController *relatedViewController;
@property(nonatomic, copy)void(^consoleOutputBlock)(NSString *output);

- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle;
- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle baseWindow:(UIWindow *)baseWindow;
- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle relatedViewController:(UIViewController *)relatedViewController;
- (void)consoleOutput:(NSString *)output;

@end
