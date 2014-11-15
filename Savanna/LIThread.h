//
//  LIThread.h
//  Savanna
//
//  Created by yangzexin on 3/9/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIThread : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *runFuncName;

@end
