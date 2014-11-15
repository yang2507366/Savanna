//
//  RequireReplaceChecker.m
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVRequireReplaceChecker.h"
#import "NSString+SVJavaLikeStringHandle.h"
#import "SVLuaConstants.h"

@implementation SVRequireReplaceChecker

- (NSString *)checkScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    NSMutableString *resultString = [NSMutableString stringWithString:script];
    
    NSString *findStr = @"require";
    NSInteger beginIndex = [resultString sv_find:findStr];
    while(beginIndex != -1){
        NSInteger endIndex = [resultString sv_find:@"\"" fromIndex:beginIndex + findStr.length];
        if(endIndex != -1){
            NSString *innerString = [resultString sv_substringWithBeginIndex:beginIndex + findStr.length endIndex:endIndex];
            innerString = [innerString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(innerString.length == 0){
                [resultString insertString:[NSString stringWithFormat:@"%@%@", bundleId, lua_require_separator] atIndex:endIndex + 1];
                beginIndex = [resultString sv_find:findStr fromIndex:endIndex + bundleId.length + 1];
            }
        }else{
            break;
        }
    }
    
    return resultString;
}

@end
