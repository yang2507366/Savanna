//
//  SVPDFUtils.h
//  Savanna
//
//  Created by yangzexin on 3/23/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPDFUtils : NSObject

+ (BOOL)exportPDFPageAsFileWithPdfURL:(NSURL *)srcPdfFileURL atPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)saveToPath;
+ (BOOL)exportPDFPageAsFileWithPDFDocument:(CGPDFDocumentRef)pdfDocRef atPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)saveToPath;

@end
