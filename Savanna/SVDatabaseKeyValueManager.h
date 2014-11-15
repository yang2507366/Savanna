//
//  DBKeyValueCache.h
//  imyvoa
//
//  Created by yzx on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVKeyValueManager.h"
#import "sqlite3.h"

@interface SVDatabaseKeyValueManager : NSObject <SVKeyValueManager> {
    NSString *_dbName;
    NSString *_dbFilePath;
    
    sqlite3 *_db;
}

- (id)initWithDBName:(NSString *)dbName;
- (id)initWithDBName:(NSString *)dbName atFilePath:(NSString *)filePath;
- (id)initWithDBName:(NSString *)dbName atFolder:(NSString *)folderPath;

@end
