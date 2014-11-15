//
//  CodeUtils.m
//  HexTest
//
//  Created by gewara on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SVEncryptUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SVEncryptUtils

static char *customHexList = "0123456789abcdef";

+ (char)_customHexCharForByte:(unsigned char )c
{
    return *(customHexList + c);
}

+ (unsigned char)_byteForCustomHexChar:(char)c
{
    size_t len = strlen(customHexList);
    for(int i = 0; i < len; ++i){
        if(c == *(customHexList + i)){
            return i;
        }
    }
    return 0;
}

+ (NSString *)hexStringByEncodingData:(NSData *)data
{
    char *bytes = malloc(sizeof(unsigned char) * [data length]);
    [data getBytes:bytes];
    
    size_t len = sizeof(char) * [data length] * 2 + 1;
    char *result = malloc(len);
    for(int i = 0; i < [data length]; ++i){
        unsigned char tmp = *(bytes + i);
        unsigned char low = tmp & 0xF;
        unsigned char high = (tmp & 0xF0) >> 4;
        *(result + i * 2) = [SVEncryptUtils _customHexCharForByte:low];
        *(result + i * 2 + 1) = [SVEncryptUtils _customHexCharForByte:high];
    }
    free(bytes);
    
    *(result + len - 1) = '\0';
    
    NSString *str = [NSString stringWithUTF8String:result];
    free(result);
    return str;
}

+ (NSString *)hexStringByEncodingString:(NSString *)string
{
    if([string isEqualToString:@""]){
        return @"";
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self hexStringByEncodingData:data];
}

+ (NSData *)dataByDecodingHexString:(NSString *)string
{
    if([string isEqualToString:@""]){
        return nil;
    }
    if([string length] % 2 != 0){
        return nil;
    }
    size_t resultBytesLen = sizeof(char) * [string length] / 2;
    char *resultBytes = malloc(resultBytesLen);
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    char *bytes = malloc(sizeof(char) * [data length]);
    [data getBytes:bytes];
    for(int i = 0, j = 0; i < [data length]; i += 2, ++j){
        unsigned char low = [SVEncryptUtils _byteForCustomHexChar:*(bytes + i)];
        unsigned char high = [SVEncryptUtils _byteForCustomHexChar:*(bytes + i + 1)];
        unsigned char tmp = ((high << 4) & 0xF0) + low;
        *(resultBytes + j) = tmp;
    }
    
    free(bytes);
    
    NSData *resultData = [NSData dataWithBytes:resultBytes length:resultBytesLen];
    free(resultBytes);
    
    return resultData;
}

+ (NSString *)stringByDecodingHexString:(NSString *)string
{
    
    NSString *resultString = [[[NSString alloc] initWithData:[self dataByDecodingHexString:string]
                                                    encoding:NSUTF8StringEncoding] autorelease];
    
    return resultString;
}

+ (NSString *)_encodeUnichar:(unichar)unich
{
    unsigned char low = unich & 0xFF;
    unsigned char high = ((unich & 0xFF00) >> 8);
    unsigned char bytes[] = {low, high};
    NSData *data = [NSData dataWithBytes:bytes length:2];
    NSString *str = [self.class hexStringByEncodingData:data];
    return str;
}

+ (NSString *)_restoreUnichar:(NSString *)str
{
    NSData *data = [self.class dataByDecodingHexString:str];
    unsigned char bytes[2];
    [data getBytes:bytes length:2];
    unichar unich = bytes[0] + (bytes[1] << 8);
    unichar unichars[1] = {unich};
    return [NSString stringWithCharacters:unichars length:1];
}

+ (NSString *)stringByEscapingUnicode:(NSString *)string
{
    NSMutableString *allString = [NSMutableString string];
    for(NSInteger i = 0; i < string.length; i++){
        const unichar ch = [string characterAtIndex:i];
        if(ch > 255){
            [allString appendFormat:@"[u]%@[/u]", [SVEncryptUtils _encodeUnichar:ch]];
        }else{
            const unichar chs[1] = {ch};
            [allString appendString:[NSString stringWithCharacters:chs length:1]];
        }
    }
    
    return allString;
}

+ (NSString *)stringByRemovingUnicode:(NSString *)string
{
    NSMutableString *allString = [NSMutableString string];
    for(NSInteger i = 0; i < string.length; i++){
        const unichar ch = [string characterAtIndex:i];
        if(ch < 255){
            const unichar chs[1] = {ch};
            [allString appendString:[NSString stringWithCharacters:chs length:1]];
        }
    }
    
    return allString;
}

+ (NSString *)stringByRestoringEscapedString:(NSString *)string
{
    if(string.length == 0){
        return @"";
    }
    NSMutableString *allString = [NSMutableString string];
    NSRange beginRange;
    NSRange endRange = NSMakeRange(0, string.length);
    while(true){
        beginRange = [string rangeOfString:@"[u]" options:NSCaseInsensitiveSearch range:endRange];
        if(beginRange.location == NSNotFound){
            if(endRange.location == 0){
                [allString appendString:string];
            }else if(endRange.location != string.length){
                [allString appendString:[string substringFromIndex:endRange.location]];
            }
            break;
        }
        NSString *en = [string substringWithRange:NSMakeRange(endRange.location, beginRange.location - endRange.location)];
        [allString appendString:en];
        beginRange.location += 3;
        beginRange.length = string.length - beginRange.location;
        endRange = [string rangeOfString:@"[/u]" options:NSCaseInsensitiveSearch range:beginRange];
        NSString *cn = [string substringWithRange:NSMakeRange(beginRange.location, endRange.location - beginRange.location)];
        cn = [SVEncryptUtils _restoreUnichar:cn];
        [allString appendString:cn];
        endRange.location += 4;
        endRange.length = string.length - endRange.location;
    }
    return allString;
}

+ (NSData *)dataByMD5EncryptingData:(NSData *)data
{
    unsigned char result[16];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSData dataWithBytes:result length:16];
}

+ (NSString *)hexStringByMD5EncryptingData:(NSData *)data
{
    unsigned char result[16];
    NSData *resultData = [self dataByMD5EncryptingData:data];
    [resultData getBytes:result length:16];
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)hexStringByMD5EncryptingString:(NSString *)string
{
    return [self hexStringByMD5EncryptingData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - commom hex
static char *commonHexList = "0123456789abcdef";

+ (char)_commonHexCharForByte:(unsigned char )c
{
    return *(commonHexList + c);
}

+ (unsigned char)_byteForCommonHexChar:(char)c
{
    size_t len = strlen(commonHexList);
    for(int i = 0; i < len; ++i){
        if(c == *(commonHexList + i)){
            return i;
        }
    }
    return 0;
}

+ (NSData *)dataWithHexStringData:(NSData *)hexStringData
{
    return [self.class dataWithHexString:[[[NSString alloc] initWithData:hexStringData encoding:NSASCIIStringEncoding] autorelease]];
}

+ (NSData *)dataWithHexString:(NSString *)string
{
    if([string isEqualToString:@""]){
        return nil;
    }
    if([string length] % 2 != 0){
        return nil;
    }
    string = [string lowercaseString];
    size_t resultBytesLen = sizeof(char) * [string length] / 2;
    char *resultBytes = malloc(resultBytesLen);
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    char *bytes = malloc(sizeof(char) * [data length]);
    [data getBytes:bytes];
    for(int i = 0, j = 0; i < [data length]; i += 2, ++j){
        unsigned char high = [self.class _byteForCommonHexChar:*(bytes + i)];
        unsigned char low = [self.class _byteForCommonHexChar:*(bytes + i + 1)];
        unsigned char tmp = ((high << 4) & 0xF0) + low;
        *(resultBytes + j) = tmp;
    }
    
    free(bytes);
    
    NSData *resultData = [NSData dataWithBytes:resultBytes length:resultBytesLen];
    free(resultBytes);
    
    return resultData;
}

+ (NSString *)hexStringWithData:(NSData *)data
{
    char *bytes = malloc(sizeof(unsigned char) * [data length]);
    [data getBytes:bytes];
    
    size_t len = sizeof(char) * [data length] * 2 + 1;
    char *result = malloc(len);
    for(int i = 0; i < [data length]; ++i){
        unsigned char tmp = *(bytes + i);
        unsigned char low = tmp & 0xF;
        unsigned char high = (tmp & 0xF0) >> 4;
        *(result + i * 2) = [self.class _commonHexCharForByte:high];
        *(result + i * 2 + 1) = [self.class _commonHexCharForByte:low];
    }
    free(bytes);
    
    *(result + len - 1) = '\0';
    
    NSString *str = [NSString stringWithUTF8String:result];
    free(result);
    return str;
}

@end
