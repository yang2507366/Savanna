//
//  LuaScriptCompiler.m
//  Queries
//
//  Created by yangzexin on 2/24/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "SVLuaScriptCompiler.h"
#import "SVUnicodeChecker.h"
#import "SVRequireAutoreleasePoolChecker.h"
#import "SVRequireReplaceChecker.h"
#import "SVIdentitySupportChecker.h"
#import "SVClassDefineChecker.h"
#import "SVSuperSupportChecker.h"
#import "SVPrefixGrammarChecker.h"
#import "SVTabCharReplaceChecker.h"
#import "SVPropertyDefineChecker.h"

@interface SVLuaScriptCompiler ()

@property(nonatomic, retain)NSArray *scriptCheckers;

@end

@implementation SVLuaScriptCompiler

+ (id)defaultScriptCompiler
{
    return [[self.class new] autorelease];
}

- (id)init
{
    self = [super init];
    
    
    self.scriptCheckers = [NSArray arrayWithObjects:
                           [[SVUnicodeChecker new] autorelease],
                           [[SVRequireAutoreleasePoolChecker new] autorelease],
                           [[SVRequireReplaceChecker new] autorelease],
                           [[SVPrefixGrammarChecker new] autorelease],
                           [[SVIdentitySupportChecker new] autorelease],
                           [[SVClassDefineChecker new] autorelease],
                           [[SVPropertyDefineChecker new] autorelease],
                           [[SVSuperSupportChecker new] autorelease],
#ifndef __IPHONE_6_0
                           [[TabCharReplaceChecker new] autorelease],
#endif
                           nil];
    
    return self;
}

- (NSString *)compileScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    for(NSInteger i = 0; i < self.scriptCheckers.count; ++i){
        id<SVLuaScriptChecker> checker = [self.scriptCheckers objectAtIndex:i];
        if(script){
            script = [checker checkScript:script scriptName:scriptName bundleId:bundleId];
        }else{
            return nil;
        }
    }
    return script;
}

@end
