//
//  SVActionDialog.h
//  Savanna
//
//  Created by yangzexin on 13-3-14.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVActionDialog : NSObject

+   (void)showWithTitle:(NSString *)title
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitles, ...;
+   (void)showWithTitle:(NSString *)title
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
   otherButtonTitleList:(NSArray *)otherButtonTitleList;

@end
