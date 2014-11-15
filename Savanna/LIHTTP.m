//
//  LIHTTP.m
//  Savanna
//
//  Created by yangzexin on 3/13/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "LIHTTP.h"
#import "SVHTTPGetRequest.h"
#import "SVHTTPDownload.h"
#import "SVHTTPPostRequest.h"
#import "SVHTTPRequest.h"
#import "SVHTTPDownloader.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"

#define KHTTPRequestEncodingUTF8    @"UTF8"
#define kHTTPRequestEncodingGBK     @"GBK"

@interface LIHTTP ()

@property(nonatomic, retain)id<SVHTTPDownload> downloader;
@property(nonatomic, retain)id<SVHTTPGetRequest> getter;
@property(nonatomic, retain)id<SVHTTPPostRequest> poster;
@property(nonatomic, retain)ASIWebPageRequest *webPageRequest;
@property(nonatomic, copy)NSString *URLString;
@property(nonatomic, retain)NSDictionary *postParameters;
@property(nonatomic, copy)NSString *encoding;

@end

@implementation LIHTTP

@synthesize objId;
@synthesize appId;

- (void)dealloc
{
    [self cancel];
    self.objId = nil;
    self.appId = nil;
    self._response = nil;
    self._progress = nil;
    self.downloader = nil;
    self.getter = nil;
    self.poster = nil;
    self.webPageRequest = nil;
    self.URLString = nil;
    self.postParameters = nil;
    self.encoding = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.encoding = KHTTPRequestEncodingUTF8;
    
    return self;
}

+ (NSString *)dataToString:(NSData *)data encoding:(NSString *)encoding
{
    CFStringEncoding cfEncoding = kCFStringEncodingUTF8;
    if([encoding isEqualToString:kHTTPRequestEncodingGBK]){
        cfEncoding = kCFStringEncodingGB_18030_2000;
    }
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
    return [[[NSString alloc] initWithData:data encoding:enc] autorelease];
}

- (void)start
{
    __block typeof(self) bself = self;
    if(self.downloader != nil){
        [self.downloader downloadWithURLString:self.URLString progress:^(long long downloadedLength, long long totalLength) {
            [bself progressing:downloadedLength totalLength:totalLength];
        } completion:^(NSString *tmpFilePath, NSError *error) {
            if(tmpFilePath.length == 0){
                tmpFilePath = @"";
            }
            [bself response:tmpFilePath error:error];
        }];
    }else if(self.getter != nil){
        [self.getter requestWithURLString:self.URLString returnData:^(NSData *data, NSError *error) {
            [bself response:[bself.class dataToString:data encoding:bself.encoding] error:error];
        }];
    }else if(self.poster != nil){
        [self.poster postWithParameters:self.postParameters baseURLString:self.URLString returnData:^(NSData *data, NSError *error) {
            [bself response:[bself.class dataToString:data encoding:bself.encoding] error:error];
        }];
    }else if(self.webPageRequest != nil){
        self.webPageRequest.delegate = self;
        self.webPageRequest.didFinishSelector = @selector(webPageRequestDidFinish:);
        self.webPageRequest.didFailSelector = @selector(webPageRequestDidFail:);
        [self.webPageRequest startAsynchronous];
    }
}

- (void)cancel
{
    [self.downloader cancel];
    [self.getter cancel];
    [self.poster cancel];
    [self.webPageRequest clearDelegatesAndCancel];
}

- (void)progressing:(long long)downloadedLength totalLength:(long long)totalLength
{
    if(self._progress.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId]
         callFunction:self._progress parameters:self.objId, [NSString stringWithFormat:@"%lld", downloadedLength], [NSString stringWithFormat:@"%lld", totalLength], nil];
    }
}

- (void)response:(NSString *)response error:(NSError *)error
{
    if(self._response.length != 0){
        NSString *errorId = nil;
        if(error){
            errorId = [SVObjectManager addObject:error group:self.appId];
        }
        [self retain];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._response parameters:self.objId, response, errorId, nil];
        if(error){
            [SVObjectManager releaseObjectWithId:errorId group:self.appId];
        }
        [self release];
    }
}

- (void)webPageRequestDidFinish:(ASIWebPageRequest *)request
{
    [self response:[request downloadDestinationPath] error:nil];
}

- (void)webPageRequestDidFail:(ASIWebPageRequest *)request
{
    [self response:nil error:request.error];
}

- (NSString *)description
{
    if(self.downloader != nil){
        return [self.downloader description];
    }else if(self.getter != nil){
        return [self.getter description];
    }else if(self.poster != nil){
        return [self.poster description];
    }else if(self.webPageRequest != nil){
        return [[self.webPageRequest url] absoluteString];
    }
    return [super description];
}

+ (NSString *)HTTPGetWithURLString:(NSString *)URLString appId:(NSString *)appId
{
    LIHTTP *tmp = [[LIHTTP new] autorelease];
    tmp.URLString = URLString;
    tmp.getter = [[SVHTTPRequest new] autorelease];
    
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    return tmp.objId;
}

+ (NSString *)HTTPPostWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters appId:(NSString *)appId
{
    LIHTTP *tmp = [[LIHTTP new] autorelease];
    tmp.URLString = URLString;
    tmp.postParameters = parameters;
    tmp.poster = [[SVHTTPRequest new] autorelease];
    
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    return tmp.objId;
}

+ (NSString *)HTTPDownloadWithURLString:(NSString *)URLString appId:(NSString *)appId
{
    LIHTTP *tmp = [[LIHTTP new] autorelease];
    tmp.URLString = URLString;
    tmp.downloader = [[SVHTTPDownloader new] autorelease];
    
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    return tmp.objId;
}

+ (NSString *)HTTPCachePageWithURLString:(NSString *)URLString appId:(NSString *)appId
{
    LIHTTP *tmp = [[LIHTTP new] autorelease];
    tmp.webPageRequest = [ASIWebPageRequest requestWithURL:[NSURL URLWithString:URLString]];
    tmp.webPageRequest.timeOutSeconds = 60 * 10;
    [tmp.webPageRequest setDownloadCache:[ASIDownloadCache sharedCache]];
    [tmp.webPageRequest setDownloadDestinationPath:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:tmp.webPageRequest]];
    
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

+ (id)create:(NSString *)appId
{
    return nil;
}

@end
