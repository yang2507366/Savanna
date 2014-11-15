//
//  BaseScriptManagerFactory.m
//  Queries
//
//  Created by yangzexin on 13-2-25.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVBaseScriptManagerFactory.h"
#import "SVMemoryBasedScriptManager.h"

@implementation SVBaseScriptManagerFactory

+ (id)defaultScriptManagerWithBaseScriptsBundlePath:(NSString *)bundlePath
{
    return [[[SVMemoryBasedScriptManager alloc] initWithBaseScriptsDirectory:bundlePath] autorelease];
}

@end
