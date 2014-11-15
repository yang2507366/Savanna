//
//  NSString+Substring.m
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "NSString+SVJavaLikeStringHandle.h"

@implementation NSString (SVJavaLikeStringHandle)

- (NSString *)sv_substringWithBeginIndex:(NSInteger)beginIndex endIndex:(NSInteger)endIndex
{
    if(endIndex >= beginIndex && endIndex <= self.length){
        return [self substringWithRange:NSMakeRange(beginIndex, endIndex - beginIndex)];
    }
    return nil;
}

- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex reverse:(BOOL)reverse
{
    
    return [self sv_find:str fromIndex:fromInex reverse:reverse isCaseSensitive:NO];
}

- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex reverse:(BOOL)reverse isCaseSensitive:(BOOL)isCaseSensitive
{
    if(fromInex < self.length){
        NSRange range = [self rangeOfString:str
                                    options:reverse ? NSBackwardsSearch : (isCaseSensitive ? NSLiteralSearch : NSCaseInsensitiveSearch)
                                      range:reverse ? NSMakeRange(0, fromInex) :NSMakeRange(fromInex, self.length - fromInex)];
        return range.location == NSNotFound ? -1 : range.location;
    }
    return -1;
}

- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex
{
    return [self sv_find:str fromIndex:fromInex reverse:NO];
}

- (NSInteger)sv_find:(NSString *)str
{
    return [self sv_find:str fromIndex:0];
}

@end
