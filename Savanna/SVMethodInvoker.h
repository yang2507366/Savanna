//
//  MethodInvoker.h
//  RuntimeUtils
//
//  Created by yangzexin on 12-10-24.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVMethodInvoker : NSObject

+ (NSString *)invokeWithObject:(id)object methodName:(NSString *)methodName parameters:(NSString *)firstParameter, ...;

@end
