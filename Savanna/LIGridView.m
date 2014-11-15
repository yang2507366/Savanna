//
//  LIGridView.m
//  Queries
//
//  Created by yangzexin on 12-12-7.
//  Copyright (c) 2012年 yangzexin. All rights reserved.
//

#import "LIGridView.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"
#import "SVGridViewWrapper.h"

@interface LIGridView () <SVGridViewWrapperDelegate>

@property(nonatomic, retain)SVGridViewWrapper *gridViewWrapper;

@end

@implementation LIGridView

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    self.numberOfItemsInGridViewWrapper = nil;
    self.configureViewAtIndex = nil;
    self.viewItemDidTappedAtIndex = nil;
    self.gridViewWrapper = nil;
    [super dealloc];
}

- (void)setNumberOfColumns:(NSInteger)pNumberOfColumns
{
    _numberOfColumns = pNumberOfColumns;
    self.gridViewWrapper = [[[SVGridViewWrapper alloc] initWithNumberOfColumns:_numberOfColumns] autorelease];
    self.gridViewWrapper.delegate = self;
    self.dataSource = self.gridViewWrapper;
}

#pragma mark - GridViewWrapper
- (void)gridViewWrapper:(SVGridViewWrapper *)gridViewWrapper configureView:(UIView *)view atIndex:(NSInteger)index
{
    if(self.configureViewAtIndex.length != 0){
        NSString *viewId = [SVObjectManager addObject:view group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.configureViewAtIndex
                                                                 parameters:self.objId, viewId, [NSString stringWithFormat:@"%d", index], nil];
        [SVObjectManager releaseObjectWithId:viewId group:self.appId];
    }
}

- (NSInteger)numberOfItemsInGridViewWrapper:(SVGridViewWrapper *)gridViewWrapper
{
    if(self.numberOfItemsInGridViewWrapper.length != 0){
        NSInteger num = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.numberOfItemsInGridViewWrapper
                                                                                  parameters:self.objId, nil] intValue];
        return num;
    }
    return 0;
}

- (void)gridViewWrapper:(SVGridViewWrapper *)gridViewWrapper viewItemTappedAtIndex:(NSInteger)index
{
    if(self.viewItemDidTappedAtIndex.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.viewItemDidTappedAtIndex
                                                                 parameters:self.objId, [NSString stringWithFormat:@"%d", index], nil];
    }
}

+ (NSString *)create:(NSString *)appId
{
    LIGridView *tmp = [[[LIGridView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
    tmp.separatorStyle = UITableViewCellSeparatorStyleNone;
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
