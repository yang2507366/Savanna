//
//  SVViewController.m
//  Savanna
//
//  Created by yangzexin on 5/21/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "SVViewController.h"

@interface SVViewController ()

@end

@implementation SVViewController

- (void)dealloc
{
    [_parentTransparentViewController release];
    [super dealloc];
}

- (void)presentTransparentModalViewController:(SVViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion
{
    UIView *parentView = self.navigationController.view;
    if(!parentView){
        parentView = self.view;
    }
    viewController.view.frame = CGRectMake(0, parentView.frame.size.height, parentView.frame.size.width, parentView.frame.size.height);
    viewController.view.backgroundColor = [UIColor clearColor];
    if(viewController->_parentTransparentViewController != self){
        [viewController->_parentTransparentViewController release];
        viewController->_parentTransparentViewController = [self retain];
    }
    [parentView addSubview:viewController.view];
    if(animated){
        [UIView animateWithDuration:0.25f animations:^{
            CGRect tmpRect = viewController.view.frame;
            tmpRect.origin.y = 0;
            viewController.view.frame = tmpRect;
        } completion:^(BOOL finished) {
            if(completion){
                completion();
            }
        }];
    }else{
        CGRect tmpRect = viewController.view.frame;
        tmpRect.origin.y = 0;
        viewController.view.frame = tmpRect;
        if(completion){
            completion();
        }
    }
    
}

- (void)dismissTransparentModalViewControllerAnimated:(BOOL)animated completion:(void(^)())completion
{
    
}

@end
