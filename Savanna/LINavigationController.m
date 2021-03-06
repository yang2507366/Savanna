//
//  NavigationController.m
//  Queries
//
//  Created by yangzexin on 11/17/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LINavigationController.h"
#import "SVObjectManager.h"

@interface LINavigationController ()

@property(nonatomic, retain)UIButton *stopButton;
@property(nonatomic, retain)UIButton *consoleButton;

@end

@implementation LINavigationController

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    self.stopButtonTapBlock = nil;
    self.consoleButtonTapBlock = nil;
    self.stopButton = nil;
    self.consoleButton = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    [self wrap:self];
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    [self wrap:self];
    return self;
}

- (void)wrap:(UINavigationController *)navigationController
{
    UINavigationBar *naviBar = navigationController.navigationBar;
    
    self.stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.stopButton.frame = CGRectMake(40, 0, 60, 35);
    [self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(stopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:self.stopButton];
    self.stopButton.hidden = YES;
    
    self.consoleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.consoleButton.frame = CGRectMake(self.stopButton.frame.origin.x + self.stopButton.frame.size.width + 5,
                                     self.stopButton.frame.origin.y,
                                     70,
                                     self.stopButton.frame.size.height);
    [self.consoleButton addTarget:self action:@selector(consoleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.consoleButton setTitle:@"Console" forState:UIControlStateNormal];
    [naviBar addSubview:self.consoleButton];
    self.consoleButton.hidden = YES;
}

- (void)stopButtonTapped
{
    if(self.stopButtonTapBlock){
        self.stopButtonTapBlock();
    }
}

- (void)consoleButtonTapped
{
    if(self.consoleButtonTapBlock){
        self.consoleButtonTapBlock();
    }
}

- (void)setStopButtonTapBlock:(void (^)())stopButtonTapBlock
{
    if(_stopButtonTapBlock != stopButtonTapBlock){
        Block_release(_stopButtonTapBlock);
        _stopButtonTapBlock = Block_copy(stopButtonTapBlock);
    }
    self.stopButton.hidden = _stopButtonTapBlock == nil;
}

- (void)setConsoleButtonTapBlock:(void (^)())consoleButtonTapBlock
{
    if(_consoleButtonTapBlock != consoleButtonTapBlock){
        Block_release(_consoleButtonTapBlock);
        _consoleButtonTapBlock = Block_copy(consoleButtonTapBlock);
    }
    self.consoleButton.hidden = _consoleButtonTapBlock == nil;
}

+ (NSString *)create:(NSString *)appId
{
    LINavigationController *nc = [[LINavigationController new] autorelease];
    nc.appId = appId;
    nc.objId = [SVObjectManager addObject:nc group:appId];
    
    return nc.objId;
}

@end
