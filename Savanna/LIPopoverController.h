//
//  LIPopoverController.h
//  Queries
//
//  Created by yangzexin on 2/9/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIPopoverController : UIPopoverController <SVLuaImplentatable>

@property(nonatomic, copy)NSString *shouldDismiss;
@property(nonatomic, copy)NSString *didDismiss;

@end
