//
//  LIThread.m
//  Savanna
//
//  Created by yangzexin on 3/9/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LIThread.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LIThread ()

@end

@implementation LIThread

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    [self exit];
    self.objId = nil;
    self.appId = nil;
    self.runFuncName = nil;
    [super dealloc];
}

- (void)start
{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void)exit
{
    if(![NSThread isMainThread]){
        [NSThread exit];
    }
}

- (void)run
{
    @autoreleasepool {
        if(self.runFuncName.length != 0){
            id<SVScriptInteraction> si = [SVAppManager scriptInteractionWithAppId:self.appId];
            [si callFunction:self.runFuncName parameters:self.objId, nil];
        }
    }
}

+ (NSString *)create:(NSString *)appId
{
    LIThread *tmp = [[LIThread new] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
