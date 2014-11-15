//
//  LIScrollViewDelegate.h
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIScrollViewDelegate : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *_scrollViewDidScroll;

@end
