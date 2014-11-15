//
//  View.m
//  Queries
//
//  Created by yangzexin on 11/19/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LIView.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LIView

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    self._layoutSubviews = nil;
    self._touchesBegan = nil;
    self._touchesCancelled = nil;
    self._touchesEnded = nil;
    self._touchesMoved = nil;
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self._layoutSubviews.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._layoutSubviews
                                                                parameters:self.objId, nil];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self._touchesBegan.length != 0){
        NSString *touchesId = [SVObjectManager addObject:touches group:self.appId];
        NSString *eventId = [SVObjectManager addObject:event group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._touchesBegan
                                                                parameters:self.objId, touchesId, eventId, nil];
        [SVObjectManager releaseObjectWithId:touchesId group:self.appId];
        [SVObjectManager releaseObjectWithId:eventId group:self.appId];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self._touchesCancelled.length != 0){
        NSString *touchesId = [SVObjectManager addObject:touches group:self.appId];
        NSString *eventId = [SVObjectManager addObject:event group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._touchesCancelled
                                                                parameters:self.objId, touchesId, eventId, nil];
        [SVObjectManager releaseObjectWithId:touchesId group:self.appId];
        [SVObjectManager releaseObjectWithId:eventId group:self.appId];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self._touchesEnded.length != 0){
        NSString *touchesId = [SVObjectManager addObject:touches group:self.appId];
        NSString *eventId = [SVObjectManager addObject:event group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._touchesEnded
                                                                parameters:self.objId, touchesId, eventId, nil];
        [SVObjectManager releaseObjectWithId:touchesId group:self.appId];
        [SVObjectManager releaseObjectWithId:eventId group:self.appId];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self._touchesMoved.length != 0){
        NSString *touchesId = [SVObjectManager addObject:touches group:self.appId];
        NSString *eventId = [SVObjectManager addObject:event group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._touchesMoved
                                                                parameters:self.objId, touchesId, eventId, nil];
        [SVObjectManager releaseObjectWithId:touchesId group:self.appId];
        [SVObjectManager releaseObjectWithId:eventId group:self.appId];
    }
}

+ (NSString *)create:(NSString *)appId
{
    LIView *tmp = [[LIView new] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:tmp.appId];
    
    return tmp.objId;
}

@end
