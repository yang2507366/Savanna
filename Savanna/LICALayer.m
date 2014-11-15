//
//  LICALayer.m
//  Savanna
//
//  Created by yangzexin on 13-3-15.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LICALayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation LICALayer

+ (void)setShadowColor:(UIColor *)color target:(CALayer *)layer
{
    [layer setShadowColor:color.CGColor];
}

+ (void)setBorderColor:(UIColor *)color target:(CALayer *)layer
{
    [layer setBorderColor:color.CGColor];
}

+ (void)setBackgroundColor:(UIColor *)color target:(CALayer *)layer
{
    [layer setBackgroundColor:color.CGColor];
}

+ (UIColor *)shadowColorWithTarget:(CALayer *)layer
{
    return [UIColor colorWithCGColor:layer.shadowColor];
}

+ (UIColor *)backgroundColorWithTarget:(CALayer *)layer
{
    return [UIColor colorWithCGColor:layer.backgroundColor];
}

+ (UIColor *)borderColorWithTarget:(CALayer *)layer
{
    return [UIColor colorWithCGColor:layer.borderColor];
}

@end
