//
//  LIWaiting.h
//  Savanna
//
//  Created by yangzexin on 7/2/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIWaiting : NSObject

+ (void)showWaiting:(BOOL)waiting inView:(UIView *)view;
+ (void)showLoading:(BOOL)waiting inView:(UIView *)view;

@end
