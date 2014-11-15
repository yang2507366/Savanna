//
//  GroupedObjectManager.m
//  Queries
//
//  Created by yangzexin on 10/21/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVObjectManager.h"
#import "SVObjectWrapper.h"
#import "SVLuaConstants.h"

@interface SVObjectManager ()

@property(nonatomic, retain)NSMutableDictionary *groupDictionary;

@end

@implementation SVObjectManager

- (void)dealloc
{
    self.groupDictionary = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.groupDictionary = [NSMutableDictionary dictionary];
    
    return self;
}

#pragma mark - instance methods
- (NSString *)idForObject:(id)object
{
    return [NSString stringWithFormat:@"%@%d", lua_obj_prefix,(NSInteger)object];
}

- (NSString *)addObject:(id)object group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(!objectDictionary){
        objectDictionary = [NSMutableDictionary dictionary];
        [self.groupDictionary setObject:objectDictionary forKey:group];
    }
    NSString *containObjectId = [self containsObject:object group:group];
    if(containObjectId.length != 0){
#ifdef DEBUGLOG
        DEBUGLOG(@"%@ exists", containObjectId);
#endif
        [self retainObjectWithId:containObjectId group:group];
        return containObjectId;
    }else{
//        DEBUGLOG(@"add object:%d:%@, group:%@", (NSInteger)object, object, group);
        NSString *objectId = [self idForObject:object];
        [objectDictionary setObject:[SVObjectWrapper objectWrapperWithObject:object] forKey:objectId];
#ifdef DEBUGLOG
        DEBUGLOG(@"add object:%@, %d", object, [object retainCount]);
#endif
#ifdef PRINT_OBJECT_COUNT
        NSLog(@"add object count:%d", [self statisticObjectCount]);
#endif
        return objectId;
    }
}

- (void)removeGroup:(NSString *)group
{
    [self.groupDictionary removeObjectForKey:group];
}

- (void)removeObjectWithId:(NSString *)objectId group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        [objectDictionary removeObjectForKey:objectId];
#ifdef DEBUGLOG
        DEBUGLOG(@"removeObjectWithId:%@", objectId);
#endif
    }
#ifdef PRINT_OBJECT_COUNT
    NSLog(@"remove object count:%d", [self statisticObjectCount]);
#endif
}

- (NSString *)containsObject:(id)object group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        NSString *objectId = [self idForObject:object];
        SVObjectWrapper *tmp = [objectDictionary objectForKey:objectId];
        return tmp == nil ? nil : objectId;
    }
    return nil;
}

- (id)objectWithId:(NSString *)objectId group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        SVObjectWrapper *tmp = [objectDictionary objectForKey:objectId];
        if(!tmp){
#ifdef DEBUGLOG
            DEBUGLOG(@"%@ not exists", objectId);
#endif
        }
        return tmp.object;
    }
    return nil;
}

- (void)retainObjectWithId:(NSString *)objectId group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        SVObjectWrapper *tmp = [objectDictionary objectForKey:objectId];
        if(tmp){
            ++tmp.referenceCount;
#ifdef DEBUGLOG
            DEBUGLOG(@"retaining object:%@, %@, retainCount:%d", tmp.object, objectId, tmp.referenceCount);
#endif
        }
    }
}

- (BOOL)releaseObjectWithId:(NSString *)objectId group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        SVObjectWrapper *tmp = [objectDictionary objectForKey:objectId];
        if(tmp){
            --tmp.referenceCount;
#ifdef DEBUGLOG
            DEBUGLOG(@"releasing object:%@, %@, retainCount:%d", tmp.object, objectId, tmp.referenceCount);
#endif
            if(tmp.referenceCount == 0){
#ifdef DEBUGLOG
                DEBUGLOG(@"remove object for release:%@", objectId);
#endif
                [self removeObjectWithId:objectId group:group];
                return YES;
            }
        }
    }
    return NO;
}

- (NSInteger)objectRetainCountForId:(NSString *)objectId group:(NSString *)group
{
    NSMutableDictionary *objectDictionary = [self.groupDictionary objectForKey:group];
    if(objectDictionary){
        SVObjectWrapper *tmp = [objectDictionary objectForKey:objectId];
        return tmp.referenceCount;
    }
    return -1;
}

- (NSInteger)statisticObjectCount
{
    NSInteger i = 0;
#ifdef DEBUGLOG
    NSArray *allKeys = [self.groupDictionary allKeys];
    for(NSString *group in allKeys){
        NSDictionary *tmpDict = [self.groupDictionary objectForKey:group];
        NSArray *allObjectKeys = [tmpDict allKeys];
        for(NSString *objectKey in allObjectKeys){
            ++i;
            DEBUGLOG(@"statis item:%@", [[tmpDict objectForKey:objectKey] object]);
        }
    }
#endif
    return i;
}

#pragma mark - class methods
+ (id)sharedInstance
{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

+ (NSString *)addObject:(id)object group:(NSString *)group
{
    return [[self sharedInstance] addObject:object group:group];
}

+ (void)removeGroup:(NSString *)group
{
    [[self sharedInstance] removeGroup:group];
}

+ (void)removeObjectWithId:(NSString *)objectId group:(NSString *)group
{
    [[self sharedInstance] removeObjectWithId:objectId group:group];
}

+ (NSString *)containsObject:(id)object group:(NSString *)group
{
    return [[self sharedInstance] containsObject:object group:group];
}

+ (NSString *)objectWithId:(NSString *)objectId group:(NSString *)group
{
#ifdef DEBUGLOG
    DEBUGLOG(@"get with object id:%@, group:%@", objectId, group);
#endif
    return [[self sharedInstance] objectWithId:objectId group:group];
}

+ (void)retainObjectWithId:(NSString *)objectId group:(NSString *)group
{
    [[self sharedInstance] retainObjectWithId:objectId group:group];
}

+ (BOOL)releaseObjectWithId:(NSString *)objectId group:(NSString *)group
{
    return [[self sharedInstance] releaseObjectWithId:objectId group:group];
}

+ (NSInteger)objectRetainCountForId:(NSString *)objectId group:(NSString *)group
{
    return [[self sharedInstance] objectRetainCountForId:objectId group:group];
}

@end
