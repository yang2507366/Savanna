//
//  SVOnlineAppBundle.h
//  Savanna
//
//  Created by yangzexin on 13-3-7.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptBundle.h"

@interface SVOnlineAppBundle : NSObject <SVScriptBundle>

- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url timeoutInterval:(NSTimeInterval)timeoutInterval;

@end
