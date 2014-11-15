//
//  TaskQueue.h
//  VOA
//
//  Created by yangzexin on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVTaskExecutable <NSObject>

@required
- (void)execute:(id)userData;
@optional
- (BOOL)autoExecuteNextTask;
- (NSString *)taskDescription;

@end

@class SVTaskQueue;

@protocol SVTaskQueueDelegate <NSObject>

@optional
- (void)taskQueue:(SVTaskQueue *)taskQueue willStartTask:(id<SVTaskExecutable>)task;
- (void)taskQueueDidStarted:(SVTaskQueue *)taskQueue;
- (void)taskQueueDidInterrupted:(SVTaskQueue *)taskQueue;
- (void)taskQueueDidFinished:(SVTaskQueue *)taskQueue;

@end

@interface SVTaskQueue : NSObject {
    id<SVTaskQueueDelegate> _delegate;
    
    NSMutableArray *taskList_;
    NSMutableDictionary *_userDataDict;
    NSCondition *taskListCondition_;
}

@property(nonatomic, assign)id<SVTaskQueueDelegate> delegate;

+ (SVTaskQueue *)taskQueue;
- (void)addTask:(id<SVTaskExecutable>)task;
- (void)addTask:(id<SVTaskExecutable>)task userData:(id)userData;
- (void)removeTask:(id<SVTaskExecutable>)task;
- (void)start;
- (void)executeNextTask;
- (void)skipTask:(NSInteger)count;
- (void)skipAllTask;
- (void)interrupt;

@end
