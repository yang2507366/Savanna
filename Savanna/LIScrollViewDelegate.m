//
//  LIScrollViewDelegate.m
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import "LIScrollViewDelegate.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"

@interface LIScrollViewDelegate () <UIScrollViewDelegate>

@end

@implementation LIScrollViewDelegate

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    self.appId = nil;
    self.objId = nil;
    
    self._scrollViewDidScroll = nil;
    [super dealloc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self._scrollViewDidScroll.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._scrollViewDidScroll
                                                                parameters:self.objId, nil];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
}

+ (id)create:(NSString *)appId
{
    LIScrollViewDelegate *tmp = [[LIScrollViewDelegate new] autorelease];
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
