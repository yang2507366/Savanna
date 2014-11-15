//
//  Timer.h
//  imyvoa
//
//  Created by gewara on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVTimer;

@protocol SVTimerDelegate <NSObject>

@optional
- (void)timer:(SVTimer *)timer timerRunningWithInterval:(CGFloat)interval;
- (void)timerDidStart:(SVTimer *)timer;
- (void)timerDidStop:(SVTimer *)timer;

@end

@interface SVTimer : NSObject {
    id<SVTimerDelegate> _delegate;
    
    NSTimeInterval _timeInterval;
    BOOL _running;
}

@property(nonatomic, assign)id<SVTimerDelegate> delegate;

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval;
- (void)stop;
- (void)cancel;

@end
