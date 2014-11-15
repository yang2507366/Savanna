//
//  SVKeyValueManagerFactory.h
//  Savanna
//
//  Created by yangzexin on 13-3-8.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVKeyValueManager;

@interface SVKeyValueManagerFactory : NSObject

+ (id<SVKeyValueManager>)databaseKeyValueManagerWithName:(NSString *)name;

@end
