//
//  HTTPDownloader.h
//  VOA
//
//  Created by yangzexin on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVHTTPDownload.h"
#import "SVProviderPool.h"

@class SVHTTPDownloader;

@protocol SVHTTPDownloaderDelegate <NSObject>

@optional
- (void)HTTPDownloaderDidStarted:(SVHTTPDownloader *)downloader;
- (void)HTTPDownloaderDidFinished:(SVHTTPDownloader *)downloader;
- (void)HTTPDownloader:(SVHTTPDownloader *)downloader didErrored:(NSError *)error;
- (void)HTTPDownloaderDownloading:(SVHTTPDownloader *)downloader downloaded:(long long)downloaded total:(long long)total;

@end

@interface SVHTTPDownloader : NSObject <SVHTTPDownload, SVProviderPoolable> {
    id<SVHTTPDownloaderDelegate> _delegate;
    
    NSString *_URLString;
    NSString *_filePathForSave;
    
    NSURLRequest *_request;
    NSFileHandle *_fileHandle;
    NSURLConnection *_urlConnection;
    
    long long _contentDownloaded;
    long long _contentLength;
    
    BOOL _downloading;
}

- (id)init;
- (id)initWithURLString:(NSString *)URLString saveToPath:(NSString *)path;

@property(nonatomic, assign)id<SVHTTPDownloaderDelegate> delegate;
@property(nonatomic, copy)NSString *URLString;
@property(nonatomic, assign)BOOL downloading;

- (void)startDownload;
- (void)cancel;
- (NSString *)pathForSave;

@end
