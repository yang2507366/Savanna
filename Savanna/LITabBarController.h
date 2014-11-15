//
//  LITabViewController.h
//  Queries
//
//  Created by yangzexin on 1/17/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LITabBarController : UITabBarController <SVLuaImplentatable>

@property(nonatomic, copy)NSString *shouldSelectViewController;
@property(nonatomic, copy)NSString *didSelectViewController;

@end
