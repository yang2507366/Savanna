//
//  Waiting.h
//  Queries
//
//  Created by yangzexin on 11/3/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SVWaitingIndicatorPositionTop,
    SVWaitingIndicatorPositionLeft,
    SVWaitingIndicatorPositionRight,
    SVWaitingIndicatorPositionBottom
}SVWaitingIndicatorPosition;

@interface SVWaiting : NSObject

+ (void)showWaiting:(BOOL)waiting inView:(UIView *)view;
+ (void)showLoading:(BOOL)loading inView:(UIView *)view;

@end
