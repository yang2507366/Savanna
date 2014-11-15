//
//  SVPropertyDefineChecker.h
//  Savanna
//
//  Created by yangzexin on 13-3-18.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPropertyDefineChecker : NSObject

+ (NSString *)getterMethodNameWithPropertyName:(NSString *)propertyName;
+ (NSString *)setterMethodNameWithPropertyName:(NSString *)propertyName;
+ (NSString *)handleScript:(NSString *)script propertyNameBlock:(void(^)(NSString *className, NSString *propertyName))propertyNameBlock;

@end
