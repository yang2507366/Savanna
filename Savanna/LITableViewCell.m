//
//  LITableViewCell.m
//  Queries
//
//  Created by yangzexin on 2/10/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LITableViewCell.h"
#import "SVObjectManager.h"

@implementation LITableViewCell

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    [super dealloc];
}

+ (NSString *)create:(NSString *)appId
{
    return nil;
}

+ (NSString *)create:(NSString *)appId style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier
{
    LITableViewCell *cell = [[[LITableViewCell alloc] initWithStyle:style reuseIdentifier:identifier] autorelease];
    cell.appId = appId;
    cell.objId = [SVObjectManager addObject:cell group:appId];
    
    return cell.objId;
}

@end
