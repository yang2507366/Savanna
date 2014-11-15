//
//  ViewControllerManager.h
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptInteraction.h"

@interface LIUIRelated : NSObject

+ (void)setRootViewControllerWithId:(NSString *)viewControllerId appId:(NSString *)scriptId;

+ (NSString *)relatedViewControllerForAppId:(NSString *)appId;

+ (void)alertWithTitle:(NSString *)title message:(NSString *)msg scriptInteraction:(id<SVScriptInteraction>)si callbackFuncName:(NSString *)funcName;

@end
