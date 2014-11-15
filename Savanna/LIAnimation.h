//
//  AnimationImpl.h
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVScriptInteraction.h"

@interface LIAnimation : NSObject

+ (NSString *)animateWithAppId:(NSString *)appId
                            si:(id<SVScriptInteraction>)si
                        animId:(NSString *)animId
             animationDuration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                       options:(UIViewAnimationOptions)options
                 animationFunc:(NSString *)animationFuc
                  completeFunc:(NSString *)completeFunc;

@end
