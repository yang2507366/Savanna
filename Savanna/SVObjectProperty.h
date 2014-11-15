//
//  ObjectProperty.h
//  RuntimeUtils
//
//  Created by yangzexin on 12-10-17.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef enum{
    ObjectPropertyTypeObject,
    ObjectPropertyTypeChar,
    ObjectPropertyTypeInt,
    ObjectPropertyTypeShort,
    ObjectPropertyTypeLong,
    ObjectPropertyTypeLongLong,
    ObjectPropertyTypeUnsignedChar,
    ObjectPropertyTypeUnsignedInt,
    ObjectPropertyTypeUnsignedShort,
    ObjectPropertyTypeUnsignedLong,
    ObjectPropertyTypeUnsignedLongLong,
    ObjectPropertyTypeFloat,
    ObjectPropertyTypeDouble,
    ObjectPropertyTypeBOOL,
    ObjectPropertyTypeVoid,
    ObjectPropertyTypeCharPoint,
    ObjectPropertyTypeClass,
    ObjectPropertyTypeSEL,
    ObjectPropertyTypeArray,
    ObjectPropertyTypeStructure,
    ObjectPropertyTypeUnion,
    ObjectPropertyTypeBit,
    ObjectPropertyTypePointerToType,
    ObjectPropertyTypeUnknown,
}ObjectPropertyType;

typedef enum{
    ObjectPropertyAccessTypeReadOnly,
    ObjectPropertyAccessTypeReadWrite,
}ObjectPropertyAccessType;

@interface SVObjectProperty : NSObject

- (id)initWithProperty:(objc_property_t)property;

@property(nonatomic, assign)objc_property_t objc_property;
@property(nonatomic, readonly)NSString *name;
@property(nonatomic, readonly)NSString *className;
@property(nonatomic, readonly)ObjectPropertyType type;
@property(nonatomic, readonly)ObjectPropertyAccessType accessType;
@property(nonatomic, readonly)NSString *setterMethodName;
@property(nonatomic, readonly)NSString *getterMethodName;

- (void)setWithString:(NSString *)string targetObject:(id<NSObject>)obj;
- (NSString *)getStringFromTargetObject:(id<NSObject>)obj;

@end
