//
//  LIHTTP.h
//  Savanna
//
//  Created by yangzexin on 3/13/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIHTTP : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *_response;
@property(nonatomic, copy)NSString *_progress;

+ (NSString *)HTTPGetWithURLString:(NSString *)URLString appId:(NSString *)appId;
+ (NSString *)HTTPPostWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters appId:(NSString *)appId;
+ (NSString *)HTTPDownloadWithURLString:(NSString *)URLString appId:(NSString *)appId;
+ (NSString *)HTTPCachePageWithURLString:(NSString *)URLString appId:(NSString *)appId;

@end
