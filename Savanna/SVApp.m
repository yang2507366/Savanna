//
//  LuaApp.m
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVApp.h"
#import "SVLuaScriptInteraction.h"

@interface SVApp ()

@end


@implementation SVApp

- (void)dealloc
{
    self.scriptInteraction = nil;
    [_scriptBundle release];
    [_baseWindow release];
    self.relatedViewController = nil;
    self.consoleOutputBlock = nil;
    
    [super dealloc];
}

- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle
{
    self = [super init];
    
    _scriptBundle = [scriptBundle retain];
    
    return self;
}

- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle baseWindow:(UIWindow *)window
{
    self = [self initWithScriptBundle:scriptBundle];
    
    self.baseWindow = window;
    
    return self;
}

- (id)initWithScriptBundle:(id<SVScriptBundle>)scriptBundle relatedViewController:(UIViewController *)relatedViewController
{
    self = [self initWithScriptBundle:scriptBundle];
    
    self.relatedViewController = relatedViewController;
    
    return self;
}

- (void)consoleOutput:(NSString *)output
{
    if(self.consoleOutputBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.consoleOutputBlock(output);
        });
    }
}

@end
