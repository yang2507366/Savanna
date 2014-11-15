//
//  ClassDefineReplaceChecker.m
//  Queries
//
//  Created by yangzexin on 13-2-22.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVClassDefineChecker.h"
#import "NSString+SVJavaLikeStringHandle.h"
#import "SVLuaCommonUtils.h"

@implementation SVClassDefineChecker

+ (BOOL)paramValid:(NSString *)param className:(NSString **)className baseClassName:(NSString **)baseClassName
{
    BOOL valid = NO;
    NSArray *arr = [param componentsSeparatedByString:@","];
    if(arr.count == 2){
        *className = [[arr objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        *baseClassName = [[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        valid = [*className length] != 0 && [*baseClassName length] != 0;
    }else if(arr.count == 1){
        NSString *tmpClassName = [arr objectAtIndex:0];
        tmpClassName = [tmpClassName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(tmpClassName.length != 0){
            valid = YES;
            *className = tmpClassName;
            *baseClassName = @"Object";
        }
    }
    return valid;
}

+ (NSString *)handleScript:(NSString *)script classNameBlock:(void(^)(NSString *))classNameBlock
{
    NSString *classDefinition =@"$class = {};$class.__index = $class;$class.__classname = \"$class\";setmetatable($class, $baseClass)";
    NSInteger lastEndIndex = 0;
    NSInteger beginIndex = 0;
    NSInteger endIndex = 0;
    NSMutableString *resultString = [NSMutableString string];
    while((beginIndex = [script sv_find:@"class" fromIndex:endIndex]) != -1){
        char preCh = ' ';
        if(beginIndex != 0 && script.length != 0){
            preCh = [script characterAtIndex:beginIndex - 1];
        }
        if([SVLuaCommonUtils isAlphbelt:preCh]){
            endIndex = beginIndex + 5;
            continue;
        }
        
        NSInteger leftBracketLocation = [script sv_find:@"(" fromIndex:beginIndex + 5];
        endIndex = [script sv_find:@")" fromIndex:beginIndex + 5];
        if(leftBracketLocation != -1 && endIndex != -1){
            NSString *leftInnerText = [script sv_substringWithBeginIndex:beginIndex + 5 endIndex:leftBracketLocation];
            leftInnerText = [leftInnerText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(![SVLuaCommonUtils isAlphbelts:leftInnerText]){
                endIndex = beginIndex + 5;
                continue;
            }
            NSString *paramText = [script sv_substringWithBeginIndex:leftBracketLocation + 1 endIndex:endIndex];
            NSString *className = nil;
            NSString *baseClassName = nil;
            if(leftInnerText.length == 0 && [self.class paramValid:paramText className:&className baseClassName:&baseClassName]){
                if(classNameBlock){
                    classNameBlock(className);
                }
                [resultString appendString:[script sv_substringWithBeginIndex:lastEndIndex endIndex:beginIndex]];
                NSString *tmpClassDefinition = [classDefinition stringByReplacingOccurrencesOfString:@"$class" withString:className];
                tmpClassDefinition = [tmpClassDefinition stringByReplacingOccurrencesOfString:@"$baseClass" withString:baseClassName];
                [resultString appendString:tmpClassDefinition];
                lastEndIndex = endIndex + 1;
            }else{
                break;
            }
        }else{
            break;
        }
    }
    [resultString appendString:[script sv_substringWithBeginIndex:lastEndIndex endIndex:script.length]];
    return resultString;
}

- (NSString *)checkScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    return [self.class handleScript:script classNameBlock:nil];
}

@end
