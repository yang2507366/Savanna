//
//  ZipHandlerFactory.m
//  Queries
//
//  Created by yangzexin on 13-2-19.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVZipHandlerFactory.h"
#import "SVZKZipHandlerAdapter.h"

@implementation SVZipHandlerFactory

+ (id<SVZipHandler>)defaultZipHandler
{
    return [[SVZKZipHandlerAdapter new] autorelease];
}

@end
