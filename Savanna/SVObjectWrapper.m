//
//  ObjectWrapper.m
//  Queries
//
//  Created by yangzexin on 10/21/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVObjectWrapper.h"

@implementation SVObjectWrapper

- (void)dealloc
{
#ifdef DEBUGLOG
    DEBUGLOG(@"recycle object:%d, %d:%@", (NSInteger)self.object, self.object.retainCount, self.object);
#endif
    self.object = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.referenceCount = 1;
    
    return self;
}

- (BOOL)recyclable
{
    return self.referenceCount == 0;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %d", self.object, self.referenceCount];
}

#pragma mark - class methods
+ (id)objectWrapperWithObject:(id)object
{
    SVObjectWrapper *tmp = [[SVObjectWrapper new] autorelease];
    tmp.object = object;
    
    return tmp;
}

@end
