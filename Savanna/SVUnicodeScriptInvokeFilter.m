//
//  UnicodeScriptInvokeFilter.m
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVUnicodeScriptInvokeFilter.h"
#import "SVCommonUtils.h"
#import "SVEncryptUtils.h"

@implementation SVUnicodeScriptInvokeFilter

- (NSString *)filterParameter:(NSString *)parameter
{
    if([SVCommonUtils stringContainsChinese:parameter]){
        parameter = [SVEncryptUtils stringByEscapingUnicode:parameter];
    }
    return parameter;
}

- (NSString *)filterReturnValue:(NSString *)returnValue
{
    return [SVEncryptUtils stringByRestoringEscapedString:returnValue];
}

@end
