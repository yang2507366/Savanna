//
//  LITableViewDataSource.m
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LITableViewDataSource.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"
#import <objc/runtime.h>

@interface LITableViewDataSource ()

@property(nonatomic, retain)UITableViewCell *nullTableViewCell;

@end

@implementation LITableViewDataSource

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    self.objId = nil;
    self.appId = nil;
    self.nullTableViewCell = nil;
    
    self.numberOfRowsInSection = nil;
    self.cellForRowAtIndexPath = nil;
    self.numberOfSections = nil;
    self.titleForHeaderInSection = nil;
    self.titleForFooterInSection = nil;
    self.canEditRowAtIndexPath = nil;
    self.canMoveRowAtIndexPath = nil;
    self.sectionIndexTitles = nil;
    self.sectionForSectionIndexTitle = nil;
    self.commitEditingStyle = nil;
    self.moveRowAtIndexPath = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.nullTableViewCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    self.nullTableViewCell.textLabel.text = @"null";
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.numberOfRowsInSection.length == 0){
        return 0;
    }
    return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.numberOfRowsInSection
                                                                   parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.cellForRowAtIndexPath.length == 0){
        return nil;
    }
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSString *cellId = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.cellForRowAtIndexPath
                                                                              parameters:self.objId, indexPathId, nil];
    id cell = [[SVObjectManager objectWithId:cellId group:self.appId] retain];
    if(!cell){
        cell = self.nullTableViewCell;
    }
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    [SVObjectManager releaseObjectWithId:cellId group:self.appId];
    return [cell autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.numberOfSections.length == 0){
        return 1;
    }
    return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.numberOfSections
                                                                   parameters:self.objId, nil] intValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.titleForHeaderInSection.length == 0){
        return nil;
    }
    NSString *title = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.titleForHeaderInSection
                                                                             parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil];
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(self.titleForFooterInSection.length == 0){
        return nil;
    }
    NSString *title = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.titleForFooterInSection
                                                                             parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil];
    return title;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    BOOL can = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.canEditRowAtIndexPath
                                                                       parameters:self.objId, indexPathId, nil] boolValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return can;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    BOOL can = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.canMoveRowAtIndexPath
                                                                       parameters:self.objId, indexPathId, nil] boolValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return can;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSString *titleArrayId = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.sectionIndexTitles
                                                                                    parameters:self.objId, nil];
    return [SVObjectManager objectWithId:titleArrayId group:self.appId];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.sectionForSectionIndexTitle
                                                                   parameters:self.objId, title, [NSString stringWithFormat:@"%d", index], nil] intValue];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.commitEditingStyle
                                                           parameters:self.objId, [NSString stringWithFormat:@"%d", editingStyle], indexPathId, nil];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *sourceIndexPathId = [SVObjectManager addObject:sourceIndexPath group:self.appId];
    NSString *destinationIndexPathId = [SVObjectManager addObject:destinationIndexPath group:self.appId];
    [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.moveRowAtIndexPath
                                                           parameters:self.objId, sourceIndexPathId, destinationIndexPathId, nil];
    [SVObjectManager releaseObjectWithId:sourceIndexPathId group:self.appId];
    [SVObjectManager releaseObjectWithId:destinationIndexPathId group:self.appId];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString *selectorName = NSStringFromSelector(aSelector);
    
    if([selectorName isEqualToString:@"tableView:canEditRowAtIndexPath:"] && self.canEditRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:canMoveRowAtIndexPath:"] && self.canMoveRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:moveRowAtIndexPath:toIndexPath:"] && self.moveRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:sectionForSectionIndexTitle:atIndex:"] && self.sectionForSectionIndexTitle.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:commitEditingStyle:forRowAtIndexPath:"] && self.commitEditingStyle.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"sectionIndexTitlesForTableView:"] && self.sectionIndexTitles.length == 0){
        return NO;
    }
    
    BOOL responds = class_respondsToSelector(self.class, aSelector);
    return responds;
}

+ (id)create:(NSString *)appId
{
    LITableViewDataSource *tmp = [[LITableViewDataSource new] autorelease];
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    tmp.appId = appId;
    
    return tmp.objId;
}

@end
