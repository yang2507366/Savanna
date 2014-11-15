//
//  LIMutableArrayComparator.m
//  Savanna
//
//  Created by yangzexin on 13-3-14.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LIMutableArrayComparator.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LIMutableArrayComparator ()

@property(nonatomic, copy)NSComparator comparator;

@end

@implementation LIMutableArrayComparator

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    self._comparator = nil;
    self._complete = nil;
    self.comparator = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.comparator = ^NSComparisonResult(id obj1, id obj2){
        if(self._comparator.length != 0){
            NSString *obj1Id = [SVObjectManager addObject:obj1 group:self.appId];
            NSString *obj2Id = [SVObjectManager addObject:obj2 group:self.appId];
            NSInteger order = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._comparator parameters:self.objId, obj1Id, obj2Id, nil] integerValue];
            [SVObjectManager releaseObjectWithId:obj1Id group:self.appId];
            [SVObjectManager releaseObjectWithId:obj2Id group:self.appId];
            return order;
        }
        return NSOrderedSame;
    };
    
    return self;
}

- (void)sortWithArray:(NSMutableArray *)array
{
    [array sortUsingComparator:self.comparator];
    if(self._complete.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._complete
                                                                parameters:self.objId, nil];
    }
}

+ (id)create:(NSString *)appId
{
    LIMutableArrayComparator *tmp = [[LIMutableArrayComparator new] autorelease];
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
