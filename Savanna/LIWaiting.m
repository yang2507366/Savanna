//
//  LIWaiting.m
//  Savanna
//
//  Created by yangzexin on 7/2/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LIWaiting.h"
#import "SVWaiting.h"

@implementation LIWaiting

+ (void)showWaiting:(BOOL)waiting inView:(UIView *)view
{
    [SVWaiting showWaiting:waiting inView:view];
}

+ (void)showLoading:(BOOL)waiting inView:(UIView *)view
{
    [SVWaiting showLoading:waiting inView:view];
}

@end
