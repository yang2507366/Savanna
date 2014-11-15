//
//  LITextFieldDelegate.h
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LITextFieldDelegate : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *shouldBeginEditing;
@property(nonatomic, copy)NSString *didBeginEditing;
@property(nonatomic, copy)NSString *shouldEndEditing;
@property(nonatomic, copy)NSString *didEndEditing;
@property(nonatomic, copy)NSString *shouldChangeCharactersInRange;
@property(nonatomic, copy)NSString *shouldClear;
@property(nonatomic, copy)NSString *shouldReturn;
@property(nonatomic, copy)NSString *textValueChanged;

@end
