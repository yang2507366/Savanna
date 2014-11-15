//
//  Toast.h
//  imyvoa
//
//  Created by gewara on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVDelayController;

@interface SVToast : NSObject {
    UIView *_view;
    UIView *_roundRectView;
    UILabel *_label;
    
    SVDelayController *_delayController;
    SVDelayController *_animationDelayController;
}

+ (SVToast *)defaultToast;
+ (void)showToastWithString:(NSString *)string hideAfterInterval:(NSTimeInterval)interval;

- (void)showToastInView:(UIView *)parentView withString:(NSString *)string hideAfterInterval:(NSTimeInterval)interval;
- (void)showToastWithString:(NSString *)string hideAfterInterval:(NSTimeInterval)interval;

@end
