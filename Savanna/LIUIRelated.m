//
//  ViewControllerManager.m
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LIUIRelated.h"
#import "SVAlertDialog.h"
#import "SVAppManager.h"
#import "SVObjectManager.h"

@implementation LIUIRelated

+ (void)setRootViewControllerWithId:(NSString *)viewControllerId appId:(NSString *)scriptId
{
    UIViewController *vc = [SVObjectManager objectWithId:viewControllerId group:scriptId];
    [SVAppManager currentWindow].rootViewController = vc;
}

+ (NSString *)relatedViewControllerForAppId:(NSString *)appId
{
    id vc = [SVAppManager appForId:appId].relatedViewController;
    if(vc){
        return [SVObjectManager addObject:vc group:appId];
    }
    return nil;
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)msg scriptInteraction:(id<SVScriptInteraction>)si callbackFuncName:(NSString *)funcName
{
    [SVAlertDialog showWithTitle:title message:msg completion:^(NSInteger buttonIndex, NSString *buttonTitle) {
        if(funcName.length != 0){
            [si callFunction:funcName callback:nil parameters:nil];
        }
    } cancelButtonTitle:@"OK" otherButtonTitles:nil];
}

@end
