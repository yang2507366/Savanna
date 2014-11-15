//
//  LIWebView.h
//  Queries
//
//  Created by yangzexin on 12/10/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIWebView : UIWebView <SVLuaImplentatable>

- (void)setActionMenuItem:(NSString *)menuItem;

@property(nonatomic, copy)NSString *_shouldShowMenuItemWithSelectedText;
@property(nonatomic, copy)NSString *_menuItemTapped;
@property(nonatomic, copy)NSString *_scrollViewDidScroll;

@end
