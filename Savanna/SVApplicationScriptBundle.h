//
//  ApplicationScriptBundle.h
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptBundle.h"

@interface SVApplicationScriptBundle : NSObject <SVScriptBundle>

- (id)initWithMainScriptName:(NSString *)scriptName;

@end
