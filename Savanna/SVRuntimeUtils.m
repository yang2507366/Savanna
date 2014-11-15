//
//  RuntimeUtils.m
//  RuntimeUtils
//
//  Created by yangzexin on 12-10-17.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import "SVRuntimeUtils.h"
#import "SVObjectProperty.h"

@implementation SVRuntimeUtils

+ (NSString *)fixValueFormat:(NSString *)value
{
    NSMutableDictionary *replaceDict = [NSMutableDictionary dictionary];
    [replaceDict setObject:@"\\n" forKey:@"\n"];
    [replaceDict setObject:@"\\t" forKey:@"\t"];
    
    NSArray *allKeys = [replaceDict allKeys];
    for(NSString *key in allKeys){
        value = [value stringByReplacingOccurrencesOfString:key withString:[replaceDict objectForKey:key]];
    }
    return value;
}

+ (NSString *)descriptionOfObject:(id<NSObject>)obj
{
    NSMutableString *desc = [NSMutableString stringWithFormat:@"%@{\n", NSStringFromClass(obj.class)];
    
    NSArray *properties = [self.class propertiesOfObject:obj];
    for(SVObjectProperty *tmpProperty in properties){
        NSString *value = [tmpProperty getStringFromTargetObject:obj];
        if(value.length != 0 && [value rangeOfString:@"\n"].location != NSNotFound){
            [desc appendFormat:@"\t\"%@\" : [\n\t\t%@\n\t]\n", tmpProperty.name, [value stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t\t"]];
        }else{
            [desc appendFormat:@"\t\"%@\" : %@\n", tmpProperty.name, value];
        }
    }
    
    [desc appendString:@"}"];
    
    return desc;
}

+ (NSString *)descriptionOfObjects:(NSArray *)objList
{
    if(![objList isKindOfClass:[NSArray class]]){
        return [NSString stringWithFormat:@"descriptionOfObjects:%@ is not array!", objList];
    }
    NSMutableString *desc = [NSMutableString stringWithString:@"\n"];
    
    for(id<NSObject> obj in objList){
        [desc appendFormat:@"%@\n\n", [self.class descriptionOfObject:obj]];
    }
    [desc appendString:@"\n"];
    
    return desc;
}

+ (NSString *)classNameOfDesc:(NSString *)desc
{
    NSRange tmpRange = [desc rangeOfString:@"\""];
    if(tmpRange.location != NSNotFound){
        ++tmpRange.location;
        NSInteger startLocation = tmpRange.location;
        tmpRange.length = desc.length - tmpRange.location;
        tmpRange = [desc rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:tmpRange];
        if(tmpRange.location != NSNotFound){
            NSString *objectType = [desc substringWithRange:NSMakeRange(startLocation, tmpRange.location - startLocation)];
            return objectType;
        }
    }
    return nil;
}

+ (NSArray *)propertiesOfObject:(id<NSObject>)obj
{
    return [self propertiesOfObject:obj classDecider:^BOOL(Class tmpClass, BOOL *stop) {
        if(tmpClass != obj.class){
            *stop = YES;
        }
        return YES;
    }];
}

+ (NSArray *)propertiesOfObject:(id<NSObject>)obj classDecider:(BOOL(^)(Class tmpClass, BOOL *stop))classDecider
{
    return [self propertiesOfClass:obj.class classDecider:classDecider];
}

+ (NSArray *)propertiesOfClass:(Class)clss classDecider:(BOOL(^)(Class tmpClass, BOOL *stop))classDecider
{
    NSMutableArray *list = [NSMutableArray array];
    
    Class tmpClass = clss;
    while(tmpClass){
        if(classDecider){
            BOOL stop = NO;
            while(tmpClass && !classDecider(tmpClass, &stop)){
                tmpClass = class_getSuperclass(tmpClass);
            }
            if(stop){
                break;
            }
        }
        
        unsigned int count = 0;
        objc_property_t *firstProperty = class_copyPropertyList(tmpClass, &count);
        for(NSInteger i = 0; i < count; ++i){
            objc_property_t property = *(firstProperty + i);
            SVObjectProperty *tmp = [[[SVObjectProperty alloc] initWithProperty:property] autorelease];
            [list addObject:tmp];
        }
        free(firstProperty);
        
        tmpClass = class_getSuperclass(tmpClass);
    }
    return list;
}

+ (BOOL)propertyValueIsNil:(SVObjectProperty *)tmpProperty targetObject:(id)targetObject
{
    if(tmpProperty.accessType == ObjectPropertyAccessTypeReadWrite
       && (tmpProperty.type == ObjectPropertyTypeChar
           || tmpProperty.type == ObjectPropertyTypeDouble
           || tmpProperty.type == ObjectPropertyTypeFloat
           || tmpProperty.type == ObjectPropertyTypeInt
           || tmpProperty.type == ObjectPropertyTypeLong
           || tmpProperty.type == ObjectPropertyTypeLongLong
           || tmpProperty.type == ObjectPropertyTypeShort
           || tmpProperty.type == ObjectPropertyTypeUnsignedChar
           || tmpProperty.type == ObjectPropertyTypeUnsignedInt
           || tmpProperty.type == ObjectPropertyTypeUnsignedLong
           || tmpProperty.type == ObjectPropertyTypeUnsignedLongLong
           || tmpProperty.type == ObjectPropertyTypeUnsignedShort
           || (tmpProperty.type == ObjectPropertyTypeObject && [tmpProperty.className isEqualToString:@"NSString"]))){
           if(tmpProperty.type == ObjectPropertyTypeObject){
               NSString *value = [tmpProperty getStringFromTargetObject:targetObject];
               return value.length == 0;
           }else{
               return [[tmpProperty getStringFromTargetObject:targetObject] doubleValue] == 0;
           }
       }
    return YES;
}

+ (void)combineObjectPropertyValueWithObject:(id<NSObject>)firstObject,...
{
    if(firstObject){
        NSArray *objPropertyList = [self.class propertiesOfObject:firstObject];
        NSMutableArray *nilValuePropertyList = [NSMutableArray array];
        for(SVObjectProperty *tmpProperty in objPropertyList){
            if(tmpProperty.accessType == ObjectPropertyAccessTypeReadWrite
               && (tmpProperty.type == ObjectPropertyTypeChar
                   || tmpProperty.type == ObjectPropertyTypeDouble
                   || tmpProperty.type == ObjectPropertyTypeFloat
                   || tmpProperty.type == ObjectPropertyTypeInt
                   || tmpProperty.type == ObjectPropertyTypeLong
                   || tmpProperty.type == ObjectPropertyTypeLongLong
                   || tmpProperty.type == ObjectPropertyTypeShort
                   || tmpProperty.type == ObjectPropertyTypeUnsignedChar
                   || tmpProperty.type == ObjectPropertyTypeUnsignedInt
                   || tmpProperty.type == ObjectPropertyTypeUnsignedLong
                   || tmpProperty.type == ObjectPropertyTypeUnsignedLongLong
                   || tmpProperty.type == ObjectPropertyTypeUnsignedShort
                   || (tmpProperty.type == ObjectPropertyTypeObject && [tmpProperty.className isEqualToString:@"NSString"]))){
                   
                   if(tmpProperty.type == ObjectPropertyTypeObject){
                       NSString *value = [tmpProperty getStringFromTargetObject:firstObject];
                       if(value.length == 0){
                           [nilValuePropertyList addObject:tmpProperty];
                       }
                   }else{
                       if([[tmpProperty getStringFromTargetObject:firstObject] doubleValue] == 0){
                           [nilValuePropertyList addObject:tmpProperty];
                       }
                   }
               }
        }
        va_list args;
        va_start(args, firstObject);
        id<NSObject> tmpObject = va_arg(args, id<NSObject>);
        while(tmpObject){
            NSArray *tmpPList = [self.class propertiesOfObject:tmpObject];
            for(SVObjectProperty *tmpProperty in tmpPList){
                if(![self.class propertyValueIsNil:tmpProperty targetObject:tmpObject]){
                    for(SVObjectProperty *targetProperty in nilValuePropertyList){
                        if([targetProperty.name isEqualToString:tmpProperty.name]){
                            [targetProperty setWithString:[tmpProperty getStringFromTargetObject:tmpObject] targetObject:firstObject];
                        }
                    }
                }
            }
            tmpObject = va_arg(args, id<NSObject>);
        }
        va_end(args);
    }
}

+ (NSDictionary *)dictionaryByConvertingFromObjectPropertiesWithObject:(id)object
{
    NSMutableDictionary *keyPropertyValueStringValue = [NSMutableDictionary dictionary];
    NSArray *properties = [SVRuntimeUtils propertiesOfObject:object];
    for(SVObjectProperty *property in properties){
        [keyPropertyValueStringValue setObject:[property getStringFromTargetObject:object] forKey:[property name]];
    }
    return keyPropertyValueStringValue;
}

@end
