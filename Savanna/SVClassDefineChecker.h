//
//  ClassDefineReplaceChecker.h
//  Queries
//
//  Created by yangzexin on 13-2-22.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaScriptChecker.h"

@interface SVClassDefineChecker : NSObject <SVLuaScriptChecker>

+ (BOOL)paramValid:(NSString *)param className:(NSString **)className baseClassName:(NSString **)baseClassName;
+ (NSString *)handleScript:(NSString *)script classNameBlock:(void(^)(NSString *))classNameBlock;

@end
