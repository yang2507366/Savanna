//
//  DialogTools.h
//  GewaraSport
//
//  Created by yangzexin on 12-9-21.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVAlertDialog : NSObject

+ (void)showWithTitle:(NSString *)title
                message:(NSString *)message
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (void)showWithTitle:(NSString *)title
                message:(NSString *)message
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitleList:(NSArray *)titleList;

@end
