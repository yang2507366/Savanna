//
//  LuaImplentatable.h
//  Queries
//
//  Created by yangzexin on 11/12/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVLuaImplentatable <NSObject>

@property(nonatomic, copy)NSString *appId;
@property(nonatomic, copy)NSString *objId;

+ (id)create:(NSString *)appId;

@end
