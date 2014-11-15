//
//  LITextViewDelegate.m
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LITextViewDelegate.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LITextViewDelegate

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    
    self.shouldBeginEditing = nil;
    self.shouldEndEditing = nil;
    self.didBeginEditing = nil;
    self.didEndEditing = nil;
    self.shouldChangeTextInRange = nil;
    self.didChange = nil;
    self.didChangeSelection = nil;
    [super dealloc];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.shouldBeginEditing.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId]
                 callFunction:self.shouldBeginEditing parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(self.shouldEndEditing.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId]
                 callFunction:self.shouldEndEditing parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(self.didBeginEditing.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didBeginEditing
                                                                               parameters:self.objId, nil];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(self.didEndEditing.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didEndEditing
                                                                               parameters:self.objId, nil];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(self.shouldChangeTextInRange.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId]
                 callFunction:self.shouldChangeTextInRange parameters:
                 self.objId, [NSString stringWithFormat:@"%d", range.location], [NSString stringWithFormat:@"%d", range.length],
                 text, nil] boolValue];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(self.didChange.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didChange
                                                                               parameters:self.objId, nil];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if(self.didChangeSelection.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didChangeSelection
                                                                               parameters:self.objId, nil];
    }
}

+ (id)create:(NSString *)appId
{
    LITextViewDelegate *tmp = [[LITextViewDelegate new] autorelease];
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
