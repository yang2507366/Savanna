//
//  TableView.h
//  Queries
//
//  Created by yangzexin on 11/13/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LITableView : UITableView <SVLuaImplentatable>

+ (NSString *)create:(NSString *)appId style:(UITableViewStyle)style;

@end
