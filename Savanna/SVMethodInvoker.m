//if(ctype == 'c'){//char
//}else if(ctype == 'i'){//integer
//}else if(ctype == 's'){//short
//}else if(ctype == 'l'){//long
//}else if(ctype == 'q'){//long long
//}else if(ctype == 'C'){//unsigned char
//}else if(ctype == 'I'){//unsigned int
//}else if(ctype == 'S'){//unsigned short
//}else if(ctype == 'L'){//unsigned long
//}else if(ctype == 'Q'){//unsigned long long
//}else if(ctype == 'f'){//float
//}else if(ctype == 'd'){//double
//}else if(ctype == 'B'){//bool
//}else if(ctype == 'v'){//void
//}else if(ctype == '*'){//char *
//}else if(ctype == '@'){//id
//}else if(ctype == '#'){//Class
//}else if(ctype == ':'){//SEL
//}else if(ctype == '['){//C array
//}else if(ctype == '{'){//struct
//}else if(ctype == '('){//union
//}else if(ctype == 'b'){//bit
//}else if(ctype == '^'){//pointer to type
//}else if(ctype == '?'){//unknown
//}

#import "SVMethodInvoker.h"

@implementation SVMethodInvoker

+ (NSString *)invokeWithObject:(id)object methodName:(NSString *)methodName parameters:(NSString *)firstParameter, ...
{
    if(firstParameter && ![methodName hasSuffix:@":"]){
        methodName = [NSString stringWithFormat:@"%@:", methodName];
    }
    SEL selector = NSSelectorFromString(methodName);
    NSMethodSignature *methodSignature = [object methodSignatureForSelector:selector];
    if( methodSignature){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = object;
        invocation.selector = selector;
        
        va_list params;
        NSInteger i = 2;
        NSInteger numberOfArguments = [methodSignature numberOfArguments];
        va_start(params, firstParameter);
        for(NSString *tmpParam = firstParameter; tmpParam && i < numberOfArguments; tmpParam = va_arg(params, NSString *), ++i){
            const unsigned char ctype = *[methodSignature getArgumentTypeAtIndex:i];
            void *argumentData = NULL;
            if(ctype == 'c'){//char
                if(tmpParam.length != 0){
                    char c = [tmpParam characterAtIndex:0];
                    
                    tmpParam = [tmpParam lowercaseString];
                    if([tmpParam isEqualToString:@"yes"] || [tmpParam isEqualToString:@"true"] || [tmpParam isEqualToString:@"1"]){
                        c = YES;
                    }else if([tmpParam isEqualToString:@"no"] || [tmpParam isEqualToString:@"false"] || [tmpParam isEqualToString:@"0"]){
                        c = NO;
                    }
                    argumentData = &c;
                }
            }else if(ctype == 'i'){//integer
                int integer = [tmpParam intValue];
                argumentData = &integer;
            }else if(ctype == 's'){//short
                short s = [tmpParam intValue];
                argumentData = &s;
            }else if(ctype == 'l'){//long
                long l = [tmpParam longLongValue];
                argumentData = &l;
            }else if(ctype == 'q'){//long long
                long long ll = [tmpParam longLongValue];
                argumentData = &ll;
            }else if(ctype == 'C'){//unsigned char
                if(tmpParam.length != 0){
                    unsigned char uc = [tmpParam characterAtIndex:0];
                    argumentData = &uc;
                }
            }else if(ctype == 'I'){//unsigned int
                unsigned int ui = [tmpParam intValue];
                argumentData = &ui;
            }else if(ctype == 'S'){//unsigned short
                unsigned short us = [tmpParam intValue];
                argumentData = &us;
            }else if(ctype == 'L'){//unsigned long
                unsigned long ul = [tmpParam longLongValue];
                argumentData = &ul;
            }else if(ctype == 'Q'){//unsigned long long
                unsigned long long ull = [tmpParam longLongValue];
                argumentData = &ull;
            }else if(ctype == 'f'){//float
                float f = [tmpParam floatValue];
                argumentData = &f;
            }else if(ctype == 'd'){//double
                double d = [tmpParam doubleValue];
                argumentData = &d;
            }else if(ctype == 'B'){//bool
                int b = [tmpParam intValue];
                argumentData = &b;
            }else if(ctype == 'v'){//void
                
            }else if(ctype == '*'){//char *
                const char *string = [tmpParam UTF8String];
                argumentData = &string;
            }else if(ctype == '@'){//id
                id obj = tmpParam;
                argumentData = &obj;
            }else if(ctype == '#'){//Class
                Class class = NSClassFromString(tmpParam);
                argumentData = &class;
            }else if(ctype == ':'){//SEL
                SEL s = NSSelectorFromString(tmpParam);
                argumentData = &s;
            }else if(ctype == '['){//C array
            }else if(ctype == '{'){//struct
                /*NSString *structType = [NSString stringWithFormat:@"%s", [methodSignature getArgumentTypeAtIndex:i]];
                if([structType hasPrefix:@"{CGSize"]){
                    CGSize size = [self CGSizeWithString:tmpParam];
                    argumentData = &size;
                }else if([structType hasPrefix:@"{CGPoint"]){
                    CGPoint point = [self CGPointWithString:tmpParam];
                    argumentData = &point;
                }else if([structType hasPrefix:@"{CGRect"]){
                    CGRect rect = [self CGRectWithString:tmpParam];
                    argumentData = &rect;
                }else if([structType hasPrefix:@"{NSRange"]){
                    NSRange range = [self NSRangeWithString:tmpParam];
                    argumentData = &range;
                }else if([structType hasPrefix:@"{UIEdgeInsets"]){
                    UIEdgeInsets insets = [self UIEdgeInsetsWithString:tmpParam];
                    argumentData = &insets;
                }else if([structType hasPrefix:@"{UIOffset"]){
                    UIOffset offset = [self UIOffsetWithString:tmpParam];
                    argumentData = &offset;
                }else if([structType hasPrefix:@"{CATransform3D"]){
                    CATransform3D t3d = [self CATransform3DWithString:tmpParam];
                    argumentData = &t3d;
                }else if([structType hasPrefix:@"{CGAffineTransform"]){
                    CGAffineTransform t = [self CGAffineTransformWithString:tmpParam];
                    argumentData = &t;
                }*/
            }else if(ctype == '('){//union
            }else if(ctype == 'b'){//bit
            }else if(ctype == '^'){//pointer to type
            }else if(ctype == '?'){//unknown
            }
            
            if(argumentData){
                [invocation setArgument:argumentData atIndex:i];
            }
        }
        va_end(params);
        
        [invocation invoke];
        if([methodSignature methodReturnLength] != 0){
            const char ctype = *[methodSignature methodReturnType];
            if(ctype == 'c'){//char
                char c;
                [invocation getReturnValue:&c];
                if(c == '\x01'){
                    return @"YES";
                }else if(c == '\0'){
                    return @"NO";
                }
                return [NSString stringWithFormat:@"%c", c];
            }else if(ctype == 'i'){//integer
                int i;
                [invocation getReturnValue:&i];
                return [NSString stringWithFormat:@"%d", i];
            }else if(ctype == 's'){//short
                short s;
                [invocation getReturnValue:&s];
                return [NSString stringWithFormat:@"%d", s];
            }else if(ctype == 'l'){//long
                long l;
                [invocation getReturnValue:&l];
                return [NSString stringWithFormat:@"%lu", l];
            }else if(ctype == 'q'){//long long
                long long l;
                [invocation getReturnValue:&l];
                return [NSString stringWithFormat:@"%llu", l];
            }else if(ctype == 'C'){//unsigned char
                unsigned char c;
                [invocation getReturnValue:&c];
                return [NSString stringWithFormat:@"%c", c];
            }else if(ctype == 'I'){//unsigned int
                unsigned int i;
                [invocation getReturnValue:&i];
                return [NSString stringWithFormat:@"%d", i];
            }else if(ctype == 'S'){//unsigned short
                unsigned short s;
                [invocation getReturnValue:&s];
                return [NSString stringWithFormat:@"%d", s];
            }else if(ctype == 'L'){//unsigned long
                unsigned long l;
                [invocation getReturnValue:&l];
                return [NSString stringWithFormat:@"%ld", l];
            }else if(ctype == 'Q'){//unsigned long long
                unsigned long long l;
                [invocation getReturnValue:&l];
                return [NSString stringWithFormat:@"%lld", l];
            }else if(ctype == 'f'){//float
                float f;
                [invocation getReturnValue:&f];
                return [NSString stringWithFormat:@"%f", f];
            }else if(ctype == 'd'){//double
                double d;
                [invocation getReturnValue:&d];
                return [NSString stringWithFormat:@"%f", d];
            }else if(ctype == 'B'){//bool
                bool b;
                [invocation getReturnValue:&b];
                return [NSString stringWithFormat:@"%@", b == 0 ? @"false" : @"true"];
            }else if(ctype == 'v'){//void
            }else if(ctype == '*'){//char *
                char *chars;
                [invocation getReturnValue:&chars];
                return [NSString stringWithFormat:@"%s", chars];
            }else if(ctype == '@'){//id
                id obj;
                [invocation getReturnValue:&obj];
                return obj;
            }else if(ctype == '#'){//Class
                Class class;
                [invocation getReturnValue:&class];
                return NSStringFromClass(class);
            }else if(ctype == ':'){//SEL
                SEL sel;
                [invocation getReturnValue:&sel];
                return NSStringFromSelector(sel);
            }else if(ctype == '['){//C array
            }else if(ctype == '{'){//struct
                /*NSString *structType = [NSString stringWithFormat:@"%s", [methodSignature methodReturnType]];
                if([structType hasPrefix:@"{CGSize"]){
                    CGSize size;
                    [invocation getReturnValue:&size];
                    return [NSString stringWithFormat:@"%f,%f", size.width, size.height];
                }else if([structType hasPrefix:@"{CGPoint"]){
                    CGPoint point;
                    [invocation getReturnValue:&point];
                    return [NSString stringWithFormat:@"%f,%f", point.x, point.y];
                }else if([structType hasPrefix:@"{CGRect"]){
                    CGRect rect;
                    [invocation getReturnValue:&rect];
                    return [NSString stringWithFormat:@"%f,%f,%f,%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
                }else if([structType hasPrefix:@"{NSRange"]){
                    NSRange range;
                    [invocation getReturnValue:&range];
                    return [NSString stringWithFormat:@"%d,%d", range.location, range.length];
                }else if([structType hasPrefix:@"{UIEdgeInsets"]){
                    UIEdgeInsets insets;
                    [invocation getReturnValue:&insets];
                    return [NSString stringWithFormat:@"%f,%f,%f,%f", insets.top, insets.left, insets.bottom, insets.right];
                }else if([structType hasPrefix:@"{UIOffset"]){
                    UIOffset offset;
                    [invocation getReturnValue:&offset];
                    return [NSString stringWithFormat:@"%f,%f", offset.horizontal, offset.vertical];
                }else if([structType hasPrefix:@"{CATransform3D"]){
                    CATransform3D t3d;
                    [invocation getReturnValue:&t3d];
                    return [NSString stringWithFormat:@"%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f",
                            t3d.m11, t3d.m12, t3d.m13, t3d.m14,
                            t3d.m21, t3d.m22, t3d.m23, t3d.m24,
                            t3d.m31, t3d.m32, t3d.m33, t3d.m34,
                            t3d.m41, t3d.m42, t3d.m43, t3d.m44
                            ];
                }else if([structType hasPrefix:@"{CGAffineTransform"]){
                    CGAffineTransform t;
                    [invocation getReturnValue:&t];
                    return [NSString stringWithFormat:@"%f,%f,%f,%f,%f,%f", t.a, t.b, t.c, t.d, t.tx, t.ty];
                }*/
            }else if(ctype == '('){//union
            }else if(ctype == 'b'){//bit
            }else if(ctype == '^'){//pointer to type
            }else if(ctype == '?'){//unknown
            }
        }
    }
    return @"";
}

+ (CGRect)CGRectWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    CGRect tmpRect;
    if(vl.count == 4){
        tmpRect.origin.x = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        tmpRect.origin.y = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        tmpRect.size.width = [[vl[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        tmpRect.size.height = [[vl[3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return tmpRect;
}

+ (CGSize)CGSizeWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    CGSize tmpSize;
    if(vl.count == 2){
        tmpSize.width = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        tmpSize.height = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return tmpSize;
}

+ (CGPoint)CGPointWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    CGPoint tmpPoint;
    if(vl.count == 2){
        tmpPoint.x = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        tmpPoint.y = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return tmpPoint;
}

+ (NSRange)NSRangeWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    NSRange tmpRange;
    if(vl.count == 2){
        tmpRange.location = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] intValue];
        tmpRange.length = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] intValue];
    }
    return tmpRange;
}

/*
+ (UIEdgeInsets)UIEdgeInsetsWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    UIEdgeInsets insets;
    if(vl.count == 4){
        insets.top = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        insets.left = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        insets.bottom = [[vl[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        insets.right = [[vl[3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return insets;
}

+ (UIOffset)UIOffsetWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    UIOffset offset;
    if(vl.count == 2){
        offset.horizontal = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        offset.vertical = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return offset;
}

+ (CATransform3D)CATransform3DWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    CATransform3D t3d;
    if(vl.count == 16){
        t3d.m11 = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m12 = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m13 = [[vl[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m14 = [[vl[3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m21 = [[vl[4] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m22 = [[vl[5] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m23 = [[vl[6] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m24 = [[vl[7] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m31 = [[vl[8] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m32 = [[vl[9] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m33 = [[vl[10] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m34 = [[vl[11] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m41 = [[vl[12] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m42 = [[vl[13] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m43 = [[vl[14] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t3d.m44 = [[vl[15] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return t3d;
}

+ (CGAffineTransform)CGAffineTransformWithString:(NSString *)str
{
    NSArray *vl = [str componentsSeparatedByString:@","];
    CGAffineTransform t;
    if(vl.count == 6){
        t.a = [[vl[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t.b = [[vl[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t.c = [[vl[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t.d = [[vl[3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t.tx = [[vl[4] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
        t.ty = [[vl[5] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] floatValue];
    }
    return t;
}*/

@end
