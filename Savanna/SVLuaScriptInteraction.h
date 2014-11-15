//
//  LuaScriptInteraction.h
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptInteraction.h"
#import "SVLuaScriptInvokeFilter.h"

@interface SVLuaScriptInteraction : NSObject <SVScriptInteraction>

@property(nonatomic, copy)NSString *script;
@property(nonatomic, retain)id<SVLuaScriptInvokeFilter> scriptInvokeFilter;
@property(nonatomic, copy)void(^errorMsgThrowBlock)(NSString *);

- (id)initWithScript:(NSString *)script;
- (id)initWithScript:(NSString *)script errorMsgThrowBlock:(void(^)(NSString *))errorMsgThrowBlock;

@end
