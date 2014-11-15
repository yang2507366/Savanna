//
//  SVPDFUtils.m
//  Savanna
//
//  Created by yangzexin on 3/23/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "SVPDFUtils.h"

@implementation SVPDFUtils

+ (BOOL)exportPDFPageAsFileWithPdfURL:(NSURL *)srcPdfFileURL atPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)saveToPath
{
    CGPDFDocumentRef pdfDocRef = CGPDFDocumentCreateWithURL((CFURLRef)srcPdfFileURL);
    if(pdfDocRef){
        BOOL success = [self.class exportPDFPageAsFileWithPDFDocument:pdfDocRef atPageIndex:pageIndex toFilePath:saveToPath];
        CGPDFDocumentRelease(pdfDocRef);
        return success;
    }
    return NO;
}

+ (BOOL)exportPDFPageAsFileWithPDFDocument:(CGPDFDocumentRef)pdfDocRef atPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)saveToPath
{
    NSInteger numOfPages = CGPDFDocumentGetNumberOfPages(pdfDocRef);
    if(pageIndex < 1 || pageIndex > numOfPages){
        return NO;
    }
    CGPDFPageRef page = CGPDFDocumentGetPage(pdfDocRef, pageIndex);
    CGRect mediaRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
    UIGraphicsBeginPDFContextToFile(saveToPath, mediaRect, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f, mediaRect.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawPDFPage(context, page);
    UIGraphicsEndPDFContext();
    
    return YES;
}

@end
