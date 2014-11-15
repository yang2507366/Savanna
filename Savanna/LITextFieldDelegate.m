//
//  LITextFieldDelegate.m
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LITextFieldDelegate.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LITextFieldDelegate

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    
    self.shouldBeginEditing = nil;
    self.didBeginEditing = nil;
    self.shouldEndEditing = nil;
    self.didEndEditing = nil;
    self.shouldChangeCharactersInRange = nil;
    self.shouldClear = nil;
    self.shouldReturn = nil;
    self.textValueChanged = nil;
    [super dealloc];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.shouldBeginEditing.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldBeginEditing
                                                                        parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.didBeginEditing.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId]
         callFunction:self.didBeginEditing parameters:self.objId, nil];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(self.shouldEndEditing.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldEndEditing
                                                                                        parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.didEndEditing.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId]
         callFunction:self.didEndEditing parameters:self.objId, nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.shouldChangeCharactersInRange.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId]
                 callFunction:self.shouldChangeCharactersInRange parameters:self.objId,
                 [NSString stringWithFormat:@"%d", range.location], [NSString stringWithFormat:@"%d", range.length], string, nil] boolValue];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(self.shouldClear.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldClear
                                                                                        parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.shouldReturn.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldReturn
                                                                                        parameters:self.objId, nil] boolValue];
    }
    return YES;
}

- (void)textValueDidChanged
{
    if(self.textValueChanged.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.textValueChanged parameters:self.objId, nil];
    }
}

+ (id)create:(NSString *)appId
{
    LITextFieldDelegate *tmp = [[LITextFieldDelegate new] autorelease];
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
