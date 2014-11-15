//
//  FileBaseScriptManager.h
//  Queries
//
//  Created by yangzexin on 13-2-25.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVBaseScriptManager.h"

@interface SVMemoryBasedScriptManager : NSObject <SVScriptManager>

- (id)initWithBaseScriptsDirectory:(NSString *)dir;

@end
