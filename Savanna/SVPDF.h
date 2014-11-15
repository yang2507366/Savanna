//
//  SVPDF.h
//  Savanna
//
//  Created by yangzexin on 3/23/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPDF : NSObject

- (id)initWithURL:(NSURL *)url;
- (NSInteger)numberOfPages;
- (BOOL)exportPageAsFileWithPageIndex:(NSInteger)pageIndex toFilePath:(NSString *)toFilePath;

@end
