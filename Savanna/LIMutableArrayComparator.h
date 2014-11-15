//
//  LIMutableArrayComparator.h
//  Savanna
//
//  Created by yangzexin on 13-3-14.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIMutableArrayComparator : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *_comparator;
@property(nonatomic, copy)NSString *_complete;

@end
