//
//  Label.m
//  Queries
//
//  Created by yangzexin on 11/18/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LILabel.h"
#import "SVObjectManager.h"

@implementation LILabel

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    [super dealloc];
}

+ (NSString *)create:(NSString *)appId
{
    LILabel *tmpLabel = [[[LILabel alloc] init] autorelease];
    tmpLabel.font = [UIFont systemFontOfSize:14.0f];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.text = @"LILabel";
    tmpLabel.frame = CGRectMake(0, 0, [tmpLabel.text sizeWithFont:tmpLabel.font].width, tmpLabel.font.lineHeight);
    
    tmpLabel.appId = appId;
    tmpLabel.objId = [SVObjectManager addObject:tmpLabel group:appId];
    
    return tmpLabel.objId;
}

@end
