//
//  AbstractHTTPRequest.h
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProviderPool.h"

@protocol SVHTTPGetRequest <SVProviderPoolable>

- (void)requestWithURLString:(NSString *)URLString completion:(void(^)(NSString *responseString, NSError *error))completion;
- (void)requestWithURLString:(NSString *)URLString returnData:(void(^)(NSData *data, NSError *error))returnData;
- (BOOL)isExecuting;
- (void)cancel;

@end
