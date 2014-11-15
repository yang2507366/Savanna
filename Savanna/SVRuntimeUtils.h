//
//  RuntimeUtils.h
//  RuntimeUtils
//
//  Created by yangzexin on 12-10-17.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface SVRuntimeUtils : NSObject

+ (NSString *)descriptionOfObject:(id<NSObject>)obj;
+ (NSString *)descriptionOfObjects:(NSArray *)objList;

+ (NSString *)classNameOfDesc:(NSString *)desc;

+ (NSArray *)propertiesOfObject:(id<NSObject>)obj;
+ (NSArray *)propertiesOfObject:(id<NSObject>)obj classDecider:(BOOL(^)(Class tmpClass, BOOL *stop))classDecider;
+ (NSArray *)propertiesOfClass:(Class)clss classDecider:(BOOL(^)(Class tmpClass, BOOL *stop))classDecider;

+ (void)combineObjectPropertyValueWithObject:(id<NSObject>)firstObject,...;

+ (NSDictionary *)dictionaryByConvertingFromObjectPropertiesWithObject:(id)object;

@end
