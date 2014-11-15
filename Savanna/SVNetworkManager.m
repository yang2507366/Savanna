//
//  NetworkManager.m
//  Fitness
//
//  Created by gewara on 12-6-8.
//  Copyright (c) 2012年 gewara. All rights reserved.
//

#import "SVNetworkManager.h"

NSString *kNetworkStatusDidBecomeReachableNotification = @"kNetworkStatusDidBecomeReachableNotification";
NSString *kNetworkStatusDidChangeNotification = @"kNetworkStatusDidChangeNotification";

@interface SVNetworkManager ()

@property(nonatomic, retain)Reachability *reachability;

@end

@implementation SVNetworkManager

@synthesize currentNetworkStatus = _currentStatus;

@synthesize reachability = _reachability;

+ (SVNetworkManager *)sharedInstance
{
    static SVNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_reachability stopNotifier];
    [_reachability release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(onNetworkStatusChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    _currentStatus = [self.reachability currentReachabilityStatus];
    
    return self;
}

- (void)startListen
{
    [self.reachability startNotifier];
}

- (void)stopListen
{
    [self.reachability stopNotifier];
}

- (void)onNetworkStatusChanged:(NSNotification *)notification
{
    _currentStatus = self.reachability.currentReachabilityStatus;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusDidChangeNotification 
                                                        object:nil];
    
    if(_currentStatus != NotReachable){
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusDidBecomeReachableNotification 
                                                            object:nil];
    }
}

@end
