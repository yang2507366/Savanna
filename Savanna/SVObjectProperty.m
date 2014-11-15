//
//  ObjectProperty.m
//  RuntimeUtils
//
//  Created by yangzexin on 12-10-17.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import "SVObjectProperty.h"
#import "SVMethodInvoker.h"

@interface SVObjectProperty ()

@property(nonatomic, copy)NSString *attributes;
@property(nonatomic, copy)NSString *setterMethodName;
@property(nonatomic, copy)NSString *getterMethodName;

@end

@implementation SVObjectProperty

@synthesize objc_property;
@synthesize name;
@synthesize type;
@synthesize accessType;
@synthesize attributes;
@synthesize className;
@synthesize setterMethodName;
@synthesize getterMethodName;

- (void)dealloc
{
    [name release];
    [attributes release];
    [className release];
    self.setterMethodName = nil;
    self.getterMethodName = nil;
    [super dealloc];
}

- (id)initWithProperty:(objc_property_t)property
{
    self = [super init];
    
    self.objc_property = property;
    
    return self;
}

- (void)setObjc_property:(objc_property_t)property
{
    objc_property = property;
    
    if(objc_property){
        const char *cname = property_getName(property);
        const char *cattributes = property_getAttributes(property);
        
        if(name){
            [name release];
        }
        name = [[NSString stringWithFormat:@"%s", cname] retain];
        
        self.attributes = [NSString stringWithFormat:@"%s", cattributes];
        
        NSArray *attributeList = [self.attributes componentsSeparatedByString:@","];
        if(attributeList.count > 1){
            type = [self.class typeOfDesc:[attributeList objectAtIndex:0]];
            if(self.type == ObjectPropertyTypeObject){
                className = [[self.class classNameOfDesc:[attributeList objectAtIndex:0]] copy];
            }
            accessType = [self.class accessTypeOfDesc:[attributeList objectAtIndex:1]];
        }
        
        NSString *firstLetter = [self.name substringToIndex:1];
        firstLetter = [firstLetter uppercaseString];
        self.setterMethodName = [NSString stringWithFormat:@"set%@%@:", firstLetter, [self.name substringFromIndex:1]];
        self.getterMethodName = self.name;
        for(NSString *tmpAttribute in attributeList){
            if([tmpAttribute hasPrefix:@"S"]){
                self.setterMethodName = [tmpAttribute substringFromIndex:1];
            }else if([tmpAttribute hasPrefix:@"G"]){
                self.getterMethodName = [tmpAttribute substringFromIndex:1];
            }
        }
    }
}

- (void)setWithString:(NSString *)value targetObject:(id<NSObject>)obj
{
    [SVMethodInvoker invokeWithObject:obj methodName:[self setterMethodName] parameters:value, nil];
}

- (NSString *)getStringFromTargetObject:(id)obj
{
    id value = [obj valueForKey:self.name];
    
    return value == nil ? @"" : [NSString stringWithFormat:@"%@", value];
}

+ (ObjectPropertyAccessType)accessTypeOfDesc:(NSString *)desc
{
    if(desc.length == 1){
        return [desc isEqualToString:@"R"] ? ObjectPropertyAccessTypeReadOnly : ObjectPropertyAccessTypeReadWrite;
    }
    return ObjectPropertyAccessTypeReadOnly;
}

+ (NSString *)classNameOfDesc:(NSString *)desc
{
    return [[desc stringByReplacingOccurrencesOfString:@"T@" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
}

+ (ObjectPropertyType)typeOfDesc:(NSString *)desc
{
    if([desc hasPrefix:@"T"] && desc.length > 1){
        const unsigned char ctype = [desc characterAtIndex:1];
        switch(ctype){
            case 'c':
                return ObjectPropertyTypeChar;
            case 'i':
                return ObjectPropertyTypeInt;
            case 's':
                return ObjectPropertyTypeShort;
            case 'l':
                return ObjectPropertyTypeLong;
            case 'q':
                return ObjectPropertyTypeLongLong;
            case 'C':
                return ObjectPropertyTypeUnsignedChar;
            case 'I':
                return ObjectPropertyTypeUnsignedInt;
            case 'S':
                return ObjectPropertyTypeUnsignedShort;
            case 'L':
                return ObjectPropertyTypeUnsignedLong;
            case 'Q':
                return ObjectPropertyTypeUnsignedLongLong;
            case 'f':
                return ObjectPropertyTypeFloat;
            case 'd':
                return ObjectPropertyTypeDouble;
            case 'B':
                return ObjectPropertyTypeBOOL;
            case 'v':
                return ObjectPropertyTypeVoid;
            case '*':
                return ObjectPropertyTypeCharPoint;
            case '@':
                return ObjectPropertyTypeObject;
            case '#':
                return ObjectPropertyTypeClass;
            case ':':
                return ObjectPropertyTypeSEL;
            case '[':
                return ObjectPropertyTypeArray;
            case '{':
                return ObjectPropertyTypeStructure;
            case '(':
                return ObjectPropertyTypeUnion;
            case 'b':
                return ObjectPropertyTypeBit;
            case '^':
                return ObjectPropertyTypePointerToType;
            case '?':
                return ObjectPropertyTypeUnknown;
            default:
                return ObjectPropertyTypeUnknown;
        }
    }
    return ObjectPropertyTypeUnknown;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.name, self.className];
}

@end
