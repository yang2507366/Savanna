//
//  View.h
//  Queries
//
//  Created by yangzexin on 11/19/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIView : UIView <SVLuaImplentatable>

@property(nonatomic, copy)NSString *_touchesBegan;
@property(nonatomic, copy)NSString *_touchesCancelled;
@property(nonatomic, copy)NSString *_touchesEnded;
@property(nonatomic, copy)NSString *_touchesMoved;
@property(nonatomic, copy)NSString *_layoutSubviews;

@end
