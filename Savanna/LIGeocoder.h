//
//  LIGeocoder.h
//  Queries
//
//  Created by yangzexin on 11/29/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVExtremeGeocoder.h"
#import "SVLuaImplentatable.h"

@interface LIGeocoder : SVExtremeGeocoder <SVLuaImplentatable>

@property(nonatomic, copy)NSString *didRecieveLocality;
@property(nonatomic, copy)NSString *didFailWithError;

@end
