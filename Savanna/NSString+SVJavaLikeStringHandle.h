//
//  NSString+Substring.h
//  Queries
//
//  Created by yangzexin on 11/2/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SVJavaLikeStringHandle)

- (NSString *)sv_substringWithBeginIndex:(NSInteger)beginIndex endIndex:(NSInteger)endIndex;
- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex reverse:(BOOL)reverse isCaseSensitive:(BOOL)isCaseSensitive;
- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex reverse:(BOOL)reverse;
- (NSInteger)sv_find:(NSString *)str fromIndex:(NSInteger)fromInex;
- (NSInteger)sv_find:(NSString *)str;

@end
