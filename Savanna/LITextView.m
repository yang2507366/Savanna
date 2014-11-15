//
//  TextView.m
//  Queries
//
//  Created by yangzexin on 11/18/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LITextView.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LITextView

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    return self;
}

+ (NSString *)create:(NSString *)appId
{
    LITextView *tmp = [[LITextView new] autorelease];
    tmp.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tmp.autocorrectionType = UITextAutocorrectionTypeNo;
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
