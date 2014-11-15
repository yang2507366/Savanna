//
//  SVViewController.h
//  Savanna
//
//  Created by yangzexin on 5/21/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVViewController : UIViewController

@property(nonatomic, readonly)SVViewController *parentTransparentViewController;

- (void)presentTransparentModalViewController:(SVViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion;
- (void)dismissTransparentModalViewControllerAnimated:(BOOL)animated completion:(void(^)())completion;

@end
