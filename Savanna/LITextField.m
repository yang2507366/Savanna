//
//  TextField.m
//  Queries
//
//  Created by yangzexin on 11/18/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LITextField.h"
#import "SVObjectManager.h"

@interface LITextField ()

@end

@implementation LITextField

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    [self addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    return self;
}

- (void)textFieldDone
{
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    [super setDelegate:delegate];
    
    [self addTarget:delegate action:@selector(textValueDidChanged) forControlEvents:UIControlEventEditingChanged];
}

+ (NSString *)create:(NSString *)appId
{
    LITextField *tf = [[LITextField new] autorelease];
    tf.frame = CGRectMake(0, 0, 80, 37);
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.returnKeyType = UIReturnKeyDone;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    tf.appId = appId;
    tf.objId = [SVObjectManager addObject:tf group:appId];
    
    return tf.objId;
}

@end
