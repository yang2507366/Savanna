//
//  SVPropertyDefineChecker.m
//  Savanna
//
//  Created by yangzexin on 13-3-18.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVPropertyDefineChecker.h"
#import "NSString+SVJavaLikeStringHandle.h"
#import "SVLuaCommonUtils.h"

@implementation SVPropertyDefineChecker


+ (BOOL)paramValid:(NSString *)param className:(NSString **)className propertyName:(NSString **)propertyName
{
    BOOL valid = NO;
    NSArray *arr = [param componentsSeparatedByString:@","];
    if(arr.count == 2){
        *className = [[arr objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        *propertyName = [[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        valid = [*className length] != 0 && [*propertyName length] != 0;
    }
    return valid;
}

+ (NSString *)getterMethodNameWithPropertyName:(NSString *)propertyName
{
    return propertyName;
}

+ (NSString *)setterMethodNameWithPropertyName:(NSString *)propertyName
{
    if(propertyName.length > 0){
        NSString *firstLetter = [propertyName substringToIndex:1];
        firstLetter = [firstLetter uppercaseString];
        NSString *methodName = [NSString stringWithFormat:@"set%@%@", firstLetter, [propertyName substringFromIndex:1]];
        return methodName;
    }
    return nil;
}

+ (NSString *)handleScript:(NSString *)script propertyNameBlock:(void(^)(NSString *className, NSString *propertyName))propertyNameBlock
{
    NSString *classDefinition =@"function $class:$setter(obj) self.__$propertyName = obj; end function $class:$getter() return self.__$propertyName; end";
    NSInteger lastEndIndex = 0;
    NSInteger beginIndex = 0;
    NSInteger endIndex = 0;
    NSMutableString *resultString = [NSMutableString string];
    while((beginIndex = [script sv_find:@"property" fromIndex:endIndex]) != -1){
        char preCh = ' ';
        if(beginIndex != 0 && script.length != 0){
            preCh = [script characterAtIndex:beginIndex - 1];
        }
        if([SVLuaCommonUtils isAlphbelt:preCh]){
            endIndex = beginIndex + 8;
            continue;
        }
        
        NSInteger leftBracketLocation = [script sv_find:@"(" fromIndex:beginIndex + 8];
        endIndex = [script sv_find:@")" fromIndex:beginIndex + 8];
        if(leftBracketLocation != -1 && endIndex != -1){
            NSString *leftInnerText = [script sv_substringWithBeginIndex:beginIndex + 8 endIndex:leftBracketLocation];
            leftInnerText = [leftInnerText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(![SVLuaCommonUtils isAlphbelts:leftInnerText]){
                endIndex = beginIndex + 8;
                continue;
            }
            NSString *paramText = [script sv_substringWithBeginIndex:leftBracketLocation + 1 endIndex:endIndex];
            NSString *className = nil;
            NSString *propertyName = nil;
            if(leftInnerText.length == 0 && [self.class paramValid:paramText className:&className propertyName:&propertyName]){
                if(propertyNameBlock){
                    propertyNameBlock(className, propertyName);
                }
                [resultString appendString:[script sv_substringWithBeginIndex:lastEndIndex endIndex:beginIndex]];
                NSString *tmpClassDefinition = [classDefinition stringByReplacingOccurrencesOfString:@"$class" withString:className];
                tmpClassDefinition = [tmpClassDefinition stringByReplacingOccurrencesOfString:@"$setter" withString:[self.class setterMethodNameWithPropertyName:propertyName]];
                tmpClassDefinition = [tmpClassDefinition stringByReplacingOccurrencesOfString:@"$getter" withString:[self.class getterMethodNameWithPropertyName:propertyName]];
                tmpClassDefinition = [tmpClassDefinition stringByReplacingOccurrencesOfString:@"$propertyName" withString:propertyName];
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
    return [self.class handleScript:script propertyNameBlock:nil];
}

@end
