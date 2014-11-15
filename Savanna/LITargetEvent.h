//
//  LITargetProxy.h
//  Savanna
//
//  Created by yangzexin on 3/11/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LITargetEvent : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *eventDidPerform;

@end
