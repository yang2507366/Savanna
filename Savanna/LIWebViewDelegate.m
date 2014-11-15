//
//  LIWebViewDelegate.m
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LIWebViewDelegate.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LIWebViewDelegate

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    self.shouldStartLoadWithRequest = nil;
    self.didStartLoad = nil;
    self.didFinishLoad = nil;
    self.didFailLoadWithError = nil;
    [super dealloc];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(self.shouldStartLoadWithRequest.length != 0){
        NSString *requestId = [SVObjectManager addObject:request group:self.appId];
        BOOL should = [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.shouldStartLoadWithRequest parameters:self.objId,
                        requestId, [NSString stringWithFormat:@"%d", navigationType], nil] boolValue];
        [SVObjectManager releaseObjectWithId:requestId group:self.appId];
        return should;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if(self.didStartLoad.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didStartLoad parameters:self.objId, nil];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(self.didFinishLoad.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didFinishLoad parameters:self.objId, nil];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if(self.didFailLoadWithError.length != 0){
        NSString *errId = [SVObjectManager addObject:error group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self.didFailLoadWithError parameters:self.objId, errId, nil];
        [SVObjectManager releaseObjectWithId:errId group:self.appId];
    }
}

+ (NSString *)create:(NSString *)appId
{
    LIWebViewDelegate *tmp = [[LIWebViewDelegate new] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
