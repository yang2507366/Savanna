//
//  ZipHandlerFactory.h
//  Queries
//
//  Created by yangzexin on 13-2-19.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVZipHandler;

@interface SVZipHandlerFactory : NSObject

+ (id<SVZipHandler>)defaultZipHandler;

@end
