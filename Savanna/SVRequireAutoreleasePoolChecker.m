//
//  RequireAutoreleasePoolChecker.m
//  Queries
//
//  Created by yangzexin on 12-12-11.
//  Copyright (c) 2012年 yangzexin. All rights reserved.
//

#import "SVRequireAutoreleasePoolChecker.h"
#import "SVLuaCommonUtils.h"

@implementation SVRequireAutoreleasePoolChecker

- (NSString *)checkScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    if([SVLuaCommonUtils scriptIsMainScript:script]){
        return [NSString stringWithFormat:@"require \"AutoreleasePool\"\n%@", script];
    }
    return script;
}

@end
