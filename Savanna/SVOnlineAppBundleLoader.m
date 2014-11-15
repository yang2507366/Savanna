//
//  OnlineAppBundle.m
//  Queries
//
//  Created by yangzexin on 11/4/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//
// https://github.com/yang2507366/TestZip/blob/master/TestZip/gtrans.zip
#import "SVOnlineAppBundleLoader.h"
#import "SVHTTPRequest.h"

@interface SVOnlineAppBundleLoader ()

@property(nonatomic, copy)NSString *URLString;
@property(nonatomic, retain)SVHTTPRequest *request;

@end

@implementation SVOnlineAppBundleLoader

- (void)dealloc
{
    self.URLString = nil;
    [self cancel]; self.request = nil;
    [super dealloc];
}

- (id)initWithURLString:(NSString *)urlString
{
    self = [super init];
    
    self.URLString = urlString;
    
    return self;
}

- (void)loadWithCompletion:(void(^)(NSString *))completion
{
    [self.request cancel];
    self.request = [[SVHTTPRequest new] autorelease];
    [self.request requestWithURLString:self.URLString returnData:^(NSData *data, NSError *error) {
        if(data.length != 0){
            NSString *tmpFile = [[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]]
                                 stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *filePath = [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), tmpFile];
            [data writeToFile:filePath atomically:NO];
            completion(filePath);
        }else{
            completion(nil);
        }
    }];
}

- (void)cancel
{
    [self.request cancel];
}

- (BOOL)providerShouldBeRemoveFromPool
{
    return ![self.request isExecuting];
}
- (BOOL)providerIsExecuting
{
    return [self.request isExecuting];
}
- (void)providerWillRemoveFromPool
{
    [self cancel];
}

@end
