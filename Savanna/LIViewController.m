//
//  ViewController.m
//  Queries
//
//  Created by yangzexin on 11/17/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LIViewController.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@implementation LIViewController

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    
    self._loadView = nil;
    self._viewDidLoad = nil;
    self._viewWillAppear = nil;
    self._viewDidDismiss = nil;
    self._viewDidAppear = nil;
    self._viewWillDisappear = nil;
    self._viewDidDisappear = nil;
    self._viewDidPop = nil;
    self._didReceiveMemoryWarning = nil;
    self._shouldAutorotate = nil;
    self._supportedInterfaceOrientations = nil;
    self._canPerformAction = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    if(self._loadView.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._loadView parameters:self.objId, nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self._viewDidLoad.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewDidLoad parameters:self.objId, nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self._viewWillAppear.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewWillAppear parameters:self.objId, nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self._viewDidAppear.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewDidAppear parameters:self.objId, nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self._viewWillDisappear.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewWillDisappear parameters:self.objId, nil];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(self._viewDidDisappear.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewDidDisappear parameters:self.objId, nil];
    }
    if(self.navigationController == nil){
        [self viewDidPop];
    }
    if(self.presentingViewController == nil){
        [self viewDidDismiss];
    }
}

- (void)viewDidDismiss
{
    if(self._viewDidDismiss.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewDidDismiss parameters:self.objId, nil];
    }
}

- (void)viewDidPop
{
    if(self._viewDidPop.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._viewDidPop parameters:self.objId, nil];
    }
}

- (void)didReceiveMemoryWarning
{
    if(self._didReceiveMemoryWarning.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._didReceiveMemoryWarning parameters:self.objId, nil];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(self._canPerformAction.length != 0){
        NSString *actionName = NSStringFromSelector(action);
        NSString *senderId = [SVObjectManager addObject:sender group:self.appId];
        NSString *can = [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._canPerformAction parameters:self.objId, actionName, senderId, nil];
        [SVObjectManager releaseObjectWithId:senderId group:self.appId];
        return [can boolValue];
    }
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)defaultPerformAction:(NSString *)actionName withSender:(id)sender
{
    return [super canPerformAction:NSSelectorFromString(actionName) withSender:sender];
}

- (BOOL)shouldAutorotate
{
    if(self._shouldAutorotate.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._shouldAutorotate parameters:self.objId, nil] boolValue];
    }
    return [super shouldAutorotate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if(self._supportedInterfaceOrientations.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId]
                 callFunction:self._supportedInterfaceOrientations parameters:self.objId, nil] intValue];
    }
    return [super supportedInterfaceOrientations];
}

+ (NSString *)create:(NSString *)appId
{
    LIViewController *vc = [[[LIViewController alloc] init] autorelease];
    vc.appId = appId;
    vc.objId = [SVObjectManager addObject:vc group:appId];
    
    return vc.objId;
}

@end
