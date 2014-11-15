//
//  LIWebViewDelegate.h
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LIWebViewDelegate : NSObject <SVLuaImplentatable, UIWebViewDelegate>

@property(nonatomic, copy)NSString *shouldStartLoadWithRequest;
@property(nonatomic, copy)NSString *didStartLoad;
@property(nonatomic, copy)NSString *didFinishLoad;
@property(nonatomic, copy)NSString *didFailLoadWithError;

@end
