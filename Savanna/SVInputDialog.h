//
//  InputDialog.h
//  CodeEditor
//
//  Created by yangzexin on 2/16/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVInputDialog : NSObject

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
   approveButtonTitle:(NSString *)approveButtonTitle
           completion:(void(^)(NSString *input))completion;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             initText:(NSString *)initText
    cancelButtonTitle:(NSString *)cancelButtonTitle
   approveButtonTitle:(NSString *)approveButtonTitle
           completion:(void(^)(NSString *input))completion;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             initText:(NSString *)initText
      clearButtonMode:(UITextFieldViewMode)clearButtonMode
    cancelButtonTitle:(NSString *)cancelButtonTitle
   approveButtonTitle:(NSString *)approveButtonTitle
           completion:(void(^)(NSString *input))completion;

@end
