//
//  LIActionSheet.m
//  Savanna
//
//  Created by yangzexin on 2/27/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LIActionSheet.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LIActionSheet () <UIActionSheetDelegate>

@end

@implementation LIActionSheet

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    self.clickedButtonAtIndex = nil;
    self.actionSheetCancel = nil;
    self.willDismissWithButtonIndex = nil;
    self.didDismissWithButtonIndex = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.delegate = self;
    
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.clickedButtonAtIndex.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.clickedButtonAtIndex
                                                                parameters:self.objId, [NSString stringWithFormat:@"%d", buttonIndex], nil];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if(self.actionSheetCancel.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.actionSheetCancel parameters:self.objId, nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.willDismissWithButtonIndex.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId]
         callFunction:self.willDismissWithButtonIndex parameters:self.objId, [NSString stringWithFormat:@"%d", buttonIndex], nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.didDismissWithButtonIndex.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId]
         callFunction:self.didDismissWithButtonIndex parameters:self.objId, [NSString stringWithFormat:@"%d", buttonIndex], nil];
    }
}

+ (NSString *)create:(NSString *)appId
{
    return nil;
}

+ (NSString *)create:(NSString *)appId title:(NSString *)title
{
    LIActionSheet *tmp = [[LIActionSheet new] autorelease];
    tmp.title = title;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
