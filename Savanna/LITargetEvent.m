//
//  LITargetProxy.m
//  Savanna
//
//  Created by yangzexin on 3/11/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LITargetEvent.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LITargetEvent ()

@property(nonatomic, assign)NSInteger event;

@end

@implementation LITargetEvent

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    [super dealloc];
}

- (void)proxy:(id)object
{
    if(self.eventDidPerform.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.eventDidPerform parameters:self.objId, [NSString stringWithFormat:@"%d", self.event], nil];
    }
}

+ (void)sourceObject:(id)object addTarget:(id)target event:(NSInteger)event
{
    [target setEvent:event];
    [object addTarget:target action:@selector(proxy:) forControlEvents:event];
}

+ (void)sourceObject:(id)object removeTarget:(id)target
{
    [object removeTarget:target action:@selector(proxy:) forControlEvents:[target event]];
}

+ (id)create:(NSString *)appId
{
    LITargetEvent *tmp = [[LITargetEvent new] autorelease];
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
