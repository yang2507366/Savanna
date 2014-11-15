//
//  TableView.m
//  Queries
//
//  Created by yangzexin on 11/13/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LITableView.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LITableView ()

@end

@implementation LITableView

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    [super dealloc];
}

+ (NSString *)create:(NSString *)appId style:(UITableViewStyle)style
{
    LITableView *tmp = [[[LITableView alloc] initWithFrame:CGRectZero style:style] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

+ (NSString *)create:(NSString *)appId
{
    return [self create:appId style:UITableViewStylePlain];
}

@end
