//
//  SVScriptBundleManager.h
//  Savanna
//
//  Created by yangzexin on 3/15/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVScriptBundle;

@protocol SVScriptBundleRepository <NSObject>

- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle;
- (void)repositScriptBundle:(id<SVScriptBundle>)scriptBundle newBundleId:(NSString *)newBundleId;
- (id<SVScriptBundle>)scriptBundleWithBundleId:(NSString *)bundleId;

@end

@interface SVScriptBundleRepository : NSObject <SVScriptBundleRepository>

+ (id)defaultRespository;

@end
