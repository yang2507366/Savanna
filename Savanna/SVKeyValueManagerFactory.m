//
//  SVKeyValueManagerFactory.m
//  Savanna
//
//  Created by yangzexin on 13-3-8.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVKeyValueManagerFactory.h"
#import "SVDatabaseKeyValueManager.h"

@implementation SVKeyValueManagerFactory

+ (id<SVKeyValueManager>)databaseKeyValueManagerWithName:(NSString *)name
{
    return [[[SVDatabaseKeyValueManager alloc] initWithDBName:name] autorelease];
}

@end
