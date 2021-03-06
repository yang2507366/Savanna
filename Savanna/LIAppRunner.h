//
//  AppRunImpl.h
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIAppRunner : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *_completion;

+ (void)runWithAppId:(NSString *)appId targetAppId:(NSString *)targetAppId params:(NSString *)params relatedViewControllerId:(NSString *)rvcId;
+ (void)destoryAppWithAppId:(NSString *)appId targetAppId:(NSString *)targetAppId;
+ (void)destoryAppWithTargetAppId:(NSString *)targetAppId;

@end
