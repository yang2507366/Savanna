//
//  OnlineAppBundle.h
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptBundle.h"

@interface SVLocalAppBundle : NSObject <SVScriptBundle>

- (id)initWithDirectory:(NSString *)dirPath;
- (id)initWithDirectory:(NSString *)dirPath bundleId:(NSString *)bundleId;
- (id)initWithPackageFile:(NSString *)packageFile;

@end
