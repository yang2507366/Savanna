//
//  NavigationController.h
//  Queries
//
//  Created by yangzexin on 11/17/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LINavigationController : UINavigationController <SVLuaImplentatable>

@property(nonatomic, copy)void(^stopButtonTapBlock)();
@property(nonatomic, copy)void(^consoleButtonTapBlock)();

@end
