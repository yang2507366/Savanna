//
//  LIActionSheet.h
//  Savanna
//
//  Created by yangzexin on 2/27/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIActionSheet : UIActionSheet <SVLuaImplentatable>

@property(nonatomic, copy)NSString *clickedButtonAtIndex;
@property(nonatomic, copy)NSString *actionSheetCancel;
@property(nonatomic, copy)NSString *willDismissWithButtonIndex;
@property(nonatomic, copy)NSString *didDismissWithButtonIndex;

@end
