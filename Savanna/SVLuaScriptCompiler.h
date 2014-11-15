//
//  LuaScriptCompiler.h
//  Queries
//
//  Created by yangzexin on 2/24/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptCompiler.h"

@interface SVLuaScriptCompiler : NSObject <SVScriptCompiler>

+ (id)defaultScriptCompiler;

@end
