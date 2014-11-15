//
//  SVPDF.m
//  Savanna
//
//  Created by yangzexin on 3/23/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "SVPDF.h"
#import "SVPDFUtils.h"

@interface SVPDF ()

@property(nonatomic, assign)CGPDFDocumentRef document;

@end

@implementation SVPDF

- (void)dealloc
{
    CGPDFDocumentRelease(_document);
    [super dealloc];
}

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    
    self.document = CGPDFDocumentCreateWithURL((CFURLRef)url);
    if(!_document){
        return nil;
    }
    
    return self;
}

- (NSInteger)numberOfPages
{
    return CGPDFDocumentGetNumberOfPages(self.document);
}

- (BOOL)exportPageAsFileWithPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)toFilePath
{
    return [SVPDFUtils exportPDFPageAsFileWithPDFDocument:self.document atPageIndex:pageIndex toFilePath:toFilePath];
}

@end
