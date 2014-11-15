//
//  UnicodeChecker.m
//  Queries
//
//  Created by yangzexin on 10/21/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVUnicodeChecker.h"
#import "SVEncryptUtils.h"

@implementation SVUnicodeChecker

- (NSString *)checkScript:(NSString *)script scriptName:(NSString *)scriptName bundleId:(NSString *)bundleId
{
    script = [SVEncryptUtils stringByEscapingUnicode:script];
    return script;
}

@end
