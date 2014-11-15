//
//  GridViewTableViewHelper.h
//  Queries
//
//  Created by yangzexin on 10/16/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVGridViewWrapper;

@protocol SVGridViewWrapperDelegate <NSObject>

- (NSInteger)numberOfItemsInGridViewWrapper:(SVGridViewWrapper *)gridViewWrapper;
- (void)gridViewWrapper:(SVGridViewWrapper *)gridViewWrapper configureView:(UIView *)view atIndex:(NSInteger)index;
@optional
- (void)gridViewWrapper:(SVGridViewWrapper *)gridViewWrapper viewItemTappedAtIndex:(NSInteger)index;

@end

@interface SVGridViewWrapper : NSObject <UITableViewDataSource>

@property(nonatomic, assign)id<SVGridViewWrapperDelegate> delegate;
@property(nonatomic, readonly)NSInteger numberOfColumns;

- (id)initWithNumberOfColumns:(NSInteger)columns;

@end
