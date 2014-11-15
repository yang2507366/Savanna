//
//  SVActionDialog.m
//  Savanna
//
//  Created by yangzexin on 13-3-14.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "SVActionDialog.h"

@interface SVActionDialog () <UIActionSheetDelegate>

@property(nonatomic, retain)UIActionSheet *actionSheet;
@property(nonatomic, copy)void(^completion)(NSInteger, NSString *);

@end

@implementation SVActionDialog

- (void)dealloc
{
    self.actionSheet = nil;
    self.completion = nil;
    [super dealloc];
}

-   (void)showWithTitle:(NSString *)title
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
      otherButtonTitles:(NSArray *)otherButtonTitles
{
    [self retain];
    self.completion = completion;
    self.actionSheet = [[UIActionSheet new] autorelease];
    self.actionSheet.delegate = self;
    for(NSString *title in otherButtonTitles){
        [self.actionSheet addButtonWithTitle:title];
    }
    NSInteger count = otherButtonTitles.count;
    if(destructiveButtonTitle.length != 0){
        [self.actionSheet addButtonWithTitle:destructiveButtonTitle];
        self.actionSheet.destructiveButtonIndex = count++;
    }
    if(cancelButtonTitle.length != 0){
        [self.actionSheet addButtonWithTitle:cancelButtonTitle];
        self.actionSheet.cancelButtonIndex = count;
    }
    
    [self.actionSheet showInView:[[UIApplication sharedApplication].windows lastObject]];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.completion){
        self.completion(buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    }
    [self release];
}

+   (void)showWithTitle:(NSString *)title
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
      otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSMutableArray *titleList = [NSMutableArray array];
    va_list params;
    va_start(params, otherButtonTitles);
    for(id item = otherButtonTitles; item != nil; item = va_arg(params, id)){
        [titleList addObject:item];
    }
    va_end(params);
    [self.class showWithTitle:title
                   completion:completion
            cancelButtonTitle:cancelButtonTitle
       destructiveButtonTitle:destructiveButtonTitle
         otherButtonTitleList:titleList];
}

+   (void)showWithTitle:(NSString *)title
             completion:(void(^)(NSInteger buttonIndex, NSString *buttonTitle))completion
      cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
   otherButtonTitleList:(NSArray *)otherButtonTitleList
{
    
    [[[SVActionDialog new] autorelease] showWithTitle:title
                                           completion:completion
                                    cancelButtonTitle:cancelButtonTitle
                               destructiveButtonTitle:destructiveButtonTitle
                                    otherButtonTitles:otherButtonTitleList];
}

@end
