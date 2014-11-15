//
//  LIMoviePlayerController.m
//  Savanna
//
//  Created by yangzexin on 3/17/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LIMoviePlayerController.h"
#import "SVObjectManager.h"

@implementation LIMoviePlayerController

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    [super dealloc];
}

+ (id)create:(NSString *)appId
{
    return nil;
}

+ (id)create:(NSString *)appId url:(NSURL *)url
{
    LIMoviePlayerController *tmp = [[[LIMoviePlayerController alloc] initWithContentURL:url] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
