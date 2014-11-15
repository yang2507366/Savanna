//
//  LITableViewDelegate.m
//  Savanna
//
//  Created by yangzexin on 3/10/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LITableViewDelegate.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"
#import <objc/runtime.h>

@implementation LITableViewDelegate

- (void)dealloc
{   
    self.willDisplayCell = nil;
    self.willDisplayHeaderView = nil;
    self.willDisplayFooterView = nil;
    self.didEndDisplayingCell = nil;
    self.didEndDisplayingHeaderView = nil;
    self.didEndDisplayingFooterView = nil;
    self.heightForRowAtIndexPath = nil;
    self.heightForHeaderInSection = nil;
    self.heightForFooterInSection = nil;
    self.viewForHeaderInSection = nil;
    self.viewForFooterInSection = nil;
    self.accessoryTypeForRowWithIndexPath = nil;
    self.accessoryButtonTappedForRowWithIndexPath = nil;
    self.shouldHighlightRowAtIndexPath = nil;
    self.didHighlightRowAtIndexPath = nil;
    self.didUnhighlightRowAtIndexPath = nil;
    self.willSelectRowAtIndexPath = nil;
    self.willDeselectRowAtIndexPath = nil;
    self.didSelectRowAtIndexPath = nil;
    self.didDeselectRowAtIndexPath = nil;
    self.editingStyleForRowAtIndexPath = nil;
    self.titleForDeleteConfirmationButtonForRowAtIndexPath = nil;
    self.shouldIndentWhileEditingRowAtIndexPath = nil;
    self.willBeginEditingRowAtIndexPath = nil;
    self.didEndEditingRowAtIndexPath = nil;
    self.targetIndexPathForMoveFromRowAtIndexPath = nil;
    self.indentationLevelForRowAtIndexPath = nil;
    self.shouldShowMenuForRowAtIndexPath = nil;
    self.canPerformAction = nil;
    self.performAction = nil;
    [super dealloc];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.willDisplayCell.length != 0){
        NSString *cellId = [SVObjectManager addObject:cell group:self.appId];
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willDisplayCell parameters:self.objId, cellId, indexPathId, nil];
        [SVObjectManager releaseObjectWithId:cellId group:self.appId];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if(self.willDisplayHeaderView.length != 0){
        NSString *viewId = [SVObjectManager addObject:view group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willDisplayHeaderView
                                                               parameters:self.objId, viewId, [NSString stringWithFormat:@"%d", section], nil];
        [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if(self.willDisplayFooterView.length != 0){
        NSString *viewId = [SVObjectManager addObject:view group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willDisplayFooterView
                                                               parameters:self.objId, viewId, [NSString stringWithFormat:@"%d", section], nil];
        [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didEndDisplayingCell.length != 0){
        NSString *cellId = [SVObjectManager addObject:cell group:self.appId];
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didEndDisplayingCell parameters:self.objId, cellId, indexPathId, nil];
        [SVObjectManager releaseObjectWithId:cellId group:self.appId];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if(self.didEndDisplayingHeaderView.length != 0){
        NSString *viewId = [SVObjectManager addObject:view group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didEndDisplayingHeaderView
                                                                parameters:self.objId, viewId, [NSString stringWithFormat:@"%d", section], nil];
        [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if(self.didEndDisplayingFooterView.length != 0){
        NSString *viewId = [SVObjectManager addObject:view group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didEndDisplayingFooterView
                                                                parameters:self.objId, viewId, [NSString stringWithFormat:@"%d", section], nil];
        [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    CGFloat height = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.heightForRowAtIndexPath
                                                                             parameters:self.objId, indexPathId, nil] floatValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = [[[SVAppManager scriptInteractionWithAppId:self.appId]
                       callFunction:self.heightForHeaderInSection parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil] floatValue];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = [[[SVAppManager scriptInteractionWithAppId:self.appId]
                       callFunction:self.heightForFooterInSection parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil] floatValue];
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *viewId = [[SVAppManager scriptInteractionWithAppId:self.appId]
                        callFunction:self.viewForHeaderInSection parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil];
    UIView *view = [[SVObjectManager objectWithId:viewId group:self.appId] retain];
    [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    
    return [view autorelease];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *viewId = [[SVAppManager scriptInteractionWithAppId:self.appId]
                        callFunction:self.viewForFooterInSection parameters:self.objId, [NSString stringWithFormat:@"%d", section], nil];
    UIView *view = [[SVObjectManager objectWithId:viewId group:self.appId] retain];
    [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    
    return [view autorelease];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(self.accessoryButtonTappedForRowWithIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.accessoryButtonTappedForRowWithIndexPath
                                                                parameters:self.objId, indexPathId, nil] floatValue];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    BOOL should = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldHighlightRowAtIndexPath
                                                                          parameters:self.objId, indexPathId, nil] boolValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return should;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didHighlightRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didHighlightRowAtIndexPath
                                                                parameters:self.objId, indexPathId, nil] boolValue];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didUnhighlightRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didUnhighlightRowAtIndexPath
                                                                parameters:self.objId, indexPathId, nil] boolValue];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSString *newIndexPathId = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willSelectRowAtIndexPath
                                                                                      parameters:self.objId, indexPathId, nil];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    NSIndexPath *newIndexPath = [[SVObjectManager objectWithId:newIndexPathId group:self.appId] retain];
    [SVObjectManager releaseObjectWithId:newIndexPathId group:self.appId];
    
    return [newIndexPath autorelease];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSString *newIndexPathId = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willDeselectRowAtIndexPath
                                                                                      parameters:self.objId, indexPathId, nil];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    NSIndexPath *newIndexPath = [[SVObjectManager objectWithId:newIndexPathId group:self.appId] retain];
    [SVObjectManager releaseObjectWithId:newIndexPathId group:self.appId];
    
    return [newIndexPath autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didSelectRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didSelectRowAtIndexPath
                                                               parameters:self.objId, indexPathId, nil];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didDeselectRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didDeselectRowAtIndexPath
                                                               parameters:self.objId, indexPathId, nil];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSInteger editingStyle = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.editingStyleForRowAtIndexPath
                                                                                     parameters:self.objId, indexPathId, nil] intValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSString *title = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.titleForDeleteConfirmationButtonForRowAtIndexPath
                                                                             parameters:self.objId, indexPathId, nil];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return title;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    BOOL should = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldIndentWhileEditingRowAtIndexPath
                                                                          parameters:self.objId, indexPathId, nil] boolValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return should;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.willBeginEditingRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.willBeginEditingRowAtIndexPath
                                                                parameters:self.objId, indexPathId, nil] boolValue];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didEndEditingRowAtIndexPath.length != 0){
        NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
        [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didEndEditingRowAtIndexPath
                                                                parameters:self.objId, indexPathId, nil] boolValue];
        [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSString *sourceIndexPathId = [SVObjectManager addObject:sourceIndexPath group:self.appId];
    NSString *destinationIndexPathId = [SVObjectManager addObject:proposedDestinationIndexPath group:self.appId];
    NSString *resultIndexPathId = [[SVAppManager scriptInteractionWithAppId:self.appId]
                                   callFunction:self.targetIndexPathForMoveFromRowAtIndexPath parameters:self.objId, sourceIndexPathId, destinationIndexPathId, nil];
    [SVObjectManager releaseObjectWithId:sourceIndexPathId group:self.appId];
    [SVObjectManager releaseObjectWithId:destinationIndexPathId group:self.appId];
    NSIndexPath *resultIndexPath = [[SVObjectManager objectWithId:resultIndexPathId group:self.appId] retain];
    [SVObjectManager releaseObjectWithId:resultIndexPathId group:self.objId];
    return [resultIndexPath autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    NSInteger indentationLevel = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.indentationLevelForRowAtIndexPath
                                                                                         parameters:self.objId, indexPathId, nil] intValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return indentationLevel;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathId = [SVObjectManager addObject:indexPath group:self.appId];
    BOOL should = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldShowMenuForRowAtIndexPath
                                                                          parameters:self.objId, indexPathId, nil] boolValue];
    [SVObjectManager releaseObjectWithId:indexPathId group:self.appId];
    return should;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString *selectorName = NSStringFromSelector(aSelector);
    if([selectorName isEqualToString:@"tableView:heightForRowAtIndexPath:"] && self.heightForRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:heightForHeaderInSection:"] && self.heightForHeaderInSection.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:heightForFooterInSection:"] && self.heightForFooterInSection.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:viewForFooterInSection:"] && self.viewForFooterInSection.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:viewForHeaderInSection:"] && self.viewForHeaderInSection.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:shouldHighlightRowAtIndexPath:"] && self.shouldHighlightRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:willSelectRowAtIndexPath:"] && self.willSelectRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:willDeselectRowAtIndexPath:"] && self.willDeselectRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:editingStyleForRowAtIndexPath:"]
             && self.editingStyleForRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:"]
             && self.titleForDeleteConfirmationButtonForRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:shouldIndentWhileEditingRowAtIndexPath:"]
             && self.shouldIndentWhileEditingRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:"]
             && self.targetIndexPathForMoveFromRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:indentationLevelForRowAtIndexPath:"]
             && self.indentationLevelForRowAtIndexPath.length == 0){
        return NO;
    }else if([selectorName isEqualToString:@"tableView:shouldShowMenuForRowAtIndexPath:"]
             && self.shouldShowMenuForRowAtIndexPath.length == 0){
        return NO;
    }
    BOOL responds = class_respondsToSelector(self.class, aSelector);
    return responds;
}

+ (id)create:(NSString *)appId
{
    LITableViewDelegate *tmp = [[LITableViewDelegate new] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
