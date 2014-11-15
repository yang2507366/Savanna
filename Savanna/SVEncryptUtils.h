//
//  CodeUtils.h
//  HexTest
//
//  Created by gewara on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVEncryptUtils : NSObject

+ (NSString *)hexStringByEncodingData:(NSData *)data;
+ (NSString *)hexStringByEncodingString:(NSString *)string;

+ (NSData *)dataByDecodingHexString:(NSString *)string;
+ (NSString *)stringByDecodingHexString:(NSString *)string;

+ (NSString *)stringByEscapingUnicode:(NSString *)string;
+ (NSString *)stringByRestoringEscapedString:(NSString *)string;
+ (NSString *)stringByRemovingUnicode:(NSString *)string;

+ (NSData *)dataByMD5EncryptingData:(NSData *)data;
+ (NSString *)hexStringByMD5EncryptingData:(NSData *)data;
+ (NSString *)hexStringByMD5EncryptingString:(NSString *)string;

+ (NSData *)dataWithHexStringData:(NSData *)hexStringData;
+ (NSData *)dataWithHexString:(NSString *)hexString;
+ (NSString *)hexStringWithData:(NSData *)data;

@end
