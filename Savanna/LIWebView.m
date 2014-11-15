//
//  LIWebView.m
//  Queries
//
//  Created by yangzexin on 12/10/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "LIWebView.h"
#import "SVObjectManager.h"
#import "SVAppManager.h"
#import "UIWebViewAdditions.h"

@interface LIWebView () <UIWebViewDelegate>

@property(nonatomic, copy)NSString *menuItemName;

@end

@implementation LIWebView

@synthesize appId;
@synthesize objId;

- (void)dealloc
{
    [self setActionMenuItem:nil];
    self.appId = nil;
    self.objId = nil;
    self._shouldShowMenuItemWithSelectedText = nil;
    self._menuItemTapped = nil;
    self._scrollViewDidScroll = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    [self removeShadow];
    
    return self;
}

- (void)setActionMenuItem:(NSString *)menuItemString
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    NSMutableArray *menuItems = [NSMutableArray arrayWithArray:menuController.menuItems];
    if(self.menuItemName.length != 0){
        NSInteger existsMenuItemIndex = -1;
        for(NSInteger i = 0; i < menuItems.count; ++i){
            UIMenuItem *menuItem = [menuItems objectAtIndex:i];
            if([menuItem.title isEqualToString:self.menuItemName]){
                existsMenuItemIndex = i;
                break;
            }
        }
        if(existsMenuItemIndex != -1){
            [menuItems removeObjectAtIndex:existsMenuItemIndex];
        }
    }
    self.menuItemName = menuItemString;
    if(menuItemString.length != 0){
        BOOL newMenuItemNameExists = NO;
        for(NSInteger i = 0; i < menuItems.count; ++i){
            UIMenuItem *menuItem = [menuItems objectAtIndex:i];
            if([menuItem.title isEqualToString:self.menuItemName]){
                newMenuItemNameExists = YES;
                break;
            }
        }
        if(!newMenuItemNameExists){
            UIMenuItem *dictMenuItem = [[[UIMenuItem alloc] initWithTitle:self.menuItemName
                                                                   action:@selector(menuItemTapped)] autorelease];
            [menuItems addObject:dictMenuItem];
        }
    }
    menuController.menuItems = menuItems;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(self.menuItemName && action == @selector(menuItemTapped)){
        NSString *selectedText = [self getSelectedText];
        if([selectedText length] != 0){
            return [self shouldShowMenuItemWithSelectedText:selectedText];
        }
    }
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)shouldShowMenuItemWithSelectedText:(NSString *)text
{
    if(self._shouldShowMenuItemWithSelectedText.length != 0){
        return [[[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._shouldShowMenuItemWithSelectedText parameters:self.objId, text, nil] boolValue];
    }
    return YES;
}

- (void)menuItemTapped
{
    if(self._menuItemTapped.length != 0){
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._menuItemTapped parameters:self.objId, nil];
    }
}

- (void)loadURLString:(NSString *)URLString
{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [self loadRequest:req];
}

- (void)loadURL:(NSURL *)url
{
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self._scrollViewDidScroll.length != 0){
        NSString *svId = [SVObjectManager addObject:scrollView group:self.appId];
        [[SVAppManager scriptInteractionWithAppId:self.appId] callFunction:self._scrollViewDidScroll parameters:self.objId, svId, nil];
        [SVObjectManager releaseObjectWithId:svId group:self.appId];
    }
}

+ (NSString *)create:(NSString *)appId
{
    LIWebView *tmp = [[LIWebView new] autorelease];
    tmp.multipleTouchEnabled = YES;
    tmp.appId = appId;
    tmp.objId = [SVObjectManager addObject:tmp group:appId];
    
    return tmp.objId;
}

@end
