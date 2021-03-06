//
//  HTTPRequest.m
//  Queries
//
//  Created by yangzexin on 10/20/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVHTTPRequest.h"
#import "SVDelayController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface SVHTTPRequest ()

@property(nonatomic, copy)void (^callback)(NSString *, NSError *);
@property(nonatomic, copy)void(^returnDataCallback)(NSData *, NSError *);
@property(nonatomic, assign)BOOL recyclable;
@property(nonatomic, retain)ASIHTTPRequest *httpRequest;

@end

@implementation SVHTTPRequest

+ (id)requestWithURLString:(NSString *)URLString identifier:(NSString *)identifier completion:(void (^)(NSString *, NSError *))completion
{
    SVHTTPRequest *req = [[[SVHTTPRequest alloc] init] autorelease];
    [req requestWithURLString:URLString completion:completion];
    [SVProviderPool addProviderToSharedPool:req identifier:identifier];
    return req;
}

+ (void)cancelRequestWithIdentifier:(NSString *)identifier
{
    [SVProviderPool cleanWithIdentifier:identifier];
}

- (void)dealloc
{
    self.callback = nil;
    self.returnDataCallback = nil;
    [self.httpRequest clearDelegatesAndCancel]; self.httpRequest = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.recyclable = NO;
    [ASIHTTPRequest setDefaultUserAgentString:@"Queries"];
    
    return self;
}

- (void)requestWithURLString:(NSString *)URLString
{
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URLString]];
    self.httpRequest.delegate = self;
    self.httpRequest.didFinishSelector = @selector(httpRequestDidFinish:);
    self.httpRequest.didFailSelector = @selector(httpRequestDidError:);
    [self.httpRequest startAsynchronous];
}

- (void)requestWithURLString:(NSString *)URLString completion:(void (^)(NSString *, NSError *))completion
{
    self.callback = completion;
    [self requestWithURLString:URLString];
}

- (void)requestWithURLString:(NSString *)URLString returnData:(void(^)(NSData *data, NSError *error))returnData
{
    self.returnDataCallback = returnData;
    [self requestWithURLString:URLString];
}

- (void)postWithParameters:(NSDictionary *)params baseURLString:(NSString *)baseURLString
{
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:baseURLString]];
    for(NSString *key in params){
        [formRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    self.httpRequest = formRequest;
    self.httpRequest.delegate = self;
    self.httpRequest.didFinishSelector = @selector(httpRequestDidFinish:);
    self.httpRequest.didFailSelector = @selector(httpRequestDidError:);
    [self.httpRequest startAsynchronous];
}

- (void)postWithParameters:(NSDictionary *)params baseURLString:(NSString *)baseURLString completion:(void (^)(NSString *, NSError *))completion
{
    self.callback = completion;
    [self postWithParameters:params baseURLString:baseURLString];
}

- (void)postWithParameters:(NSDictionary *)params
             baseURLString:(NSString *)baseURLString
                returnData:(void(^)(NSData *data, NSError *error))returnData
{
    self.returnDataCallback = returnData;
    [self postWithParameters:params baseURLString:baseURLString];
}

- (BOOL)isExecuting
{
    return self.httpRequest.isExecuting;
}

- (void)cancel
{
    self.callback = nil;
    [self.httpRequest clearDelegatesAndCancel];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.httpRequest.url.absoluteString];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)httpRequestDidFinish:(ASIHTTPRequest *)req
{
    self.recyclable = YES;
    if(self.callback){
        self.callback(req.responseString, nil);
    }
    
    if(self.returnDataCallback){
        self.returnDataCallback(req.responseData, nil);
    }
}

- (void)httpRequestDidError:(ASIHTTPRequest *)req
{
    self.recyclable = YES;
    
    NSError *error = req.error;
    
    if(self.callback){
        self.callback(nil, error);
    }
    if(self.returnDataCallback){
        self.returnDataCallback(nil, error);
    }
}

#pragma mark - ProviderPoolable
- (void)providerWillRemoveFromPool
{
    [self cancel];
}

- (BOOL)providerIsExecuting
{
    return self.isExecuting;
}

- (BOOL)providerShouldBeRemoveFromPool
{
    return self.recyclable;
}

@end
