//
//  AddBaseScriptsChecker.m
//  Queries
//
//  Created by yangzexin on 11/17/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVAddBaseScriptsChecker.h"
#import "SVAppManager.h"
#import "SVLuaCommonUtils.h"

@interface SVAddBaseScriptsChecker ()

@property(nonatomic, copy)NSString *requireStrings;

@end

@implementation SVAddBaseScriptsChecker

- (void)dealloc
{
    self.requireStrings = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    NSMutableString *allRequireStrings = [NSMutableString string];
    NSBundle *baseScriptsBundle = [SVAppManager baseScriptsBundle];
    NSArray *allScriptFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[baseScriptsBundle bundlePath] error:nil];
    for(NSString *scriptFile in allScriptFiles){
        [allRequireStrings appendFormat:@"require \"%@\"\n", scriptFile];
    }
    self.requireStrings = allRequireStrings;
    return self;
}

- (NSString *)checkScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    if([SVLuaCommonUtils scriptIsMainScript:script]){
        script = [NSString stringWithFormat:@"%@\n%@", self.requireStrings, script];
    }
    return script;
}

@end
