//
//  LIGridView.h
//  Queries
//
//  Created by yangzexin on 12-12-7.
//  Copyright (c) 2012年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIGridView : UITableView <SVLuaImplentatable>

@property(nonatomic, copy)NSString *configureViewAtIndex;
@property(nonatomic, copy)NSString *numberOfItemsInGridViewWrapper;
@property(nonatomic, copy)NSString *viewItemDidTappedAtIndex;

@property(nonatomic, assign)NSInteger numberOfColumns;

@end
