//
//  BarButtonItem.h
//  Queries
//
//  Created by yangzexin on 11/18/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIBarButtonItem : UIBarButtonItem <SVLuaImplentatable>

@property(nonatomic, copy)NSString *tapped;

+ (NSString *)createWithAppId:(NSString *)appId systemItem:(NSInteger)systemItem;

@end
