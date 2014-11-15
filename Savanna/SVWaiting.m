//
//  Waiting.m
//  Queries
//
//  Created by yangzexin on 11/3/12.
//  Copyright (c) 2012 yangzexin. All rights reserved.
//

#import "SVWaiting.h"
#import <QuartzCore/QuartzCore.h>
#import "SVKeyboardState.h"

@interface SVWaitingView : UIView

@property(nonatomic, retain)UIView *blockView;
@property(nonatomic, retain)UIView *containerView;
@property(nonatomic, retain)UIView *backgroundRoundView;
@property(nonatomic, retain)UILabel *textLabel;
@property(nonatomic, retain)UIActivityIndicatorView *indicatorView;
@property(nonatomic, assign)SVWaitingIndicatorPosition indicatorPosition;

@end

@implementation SVWaitingView

- (void)dealloc
{
    self.blockView = nil;
    self.containerView = nil;
    self.backgroundRoundView = nil;
    self.textLabel = nil;
    self.indicatorView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.blockView = [[[UIView alloc] init] autorelease];
    [self addSubview:_blockView];
    
    self.containerView = [[[UIView alloc] init] autorelease];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    self.backgroundRoundView = [[[UIView alloc] init] autorelease];
    _backgroundRoundView.backgroundColor = [UIColor blackColor];
    _backgroundRoundView.layer.cornerRadius = 12.0f;
    _backgroundRoundView.alpha = 0.72f;
    [_containerView addSubview:_backgroundRoundView];
    
    self.indicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [_containerView addSubview:_indicatorView];
    
    self.textLabel = [[[UILabel alloc] init] autorelease];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.hidden = YES;
    [_containerView addSubview:_textLabel];
    self.indicatorPosition = SVWaitingIndicatorPositionBottom;
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat containerViewWidth = 72.0f;
    CGFloat containerViewHeight = 72.0f;
    CGFloat textLabelHeight = 50.0f;
    
    _containerView.frame = CGRectMake((self.frame.size.width - containerViewWidth) / 2,
                                      (self.frame.size.height - containerViewHeight) / 2,
                                      containerViewWidth,
                                      containerViewHeight);
    _backgroundRoundView.frame = _containerView.bounds;
    _indicatorView.frame = CGRectMake(0, 0, containerViewWidth, containerViewHeight - 20);
    
    CGFloat size = 40.0f;
    if(self.indicatorPosition == SVWaitingIndicatorPositionLeft || self.indicatorPosition == SVWaitingIndicatorPositionRight){
        size = 20.0f;
    }
    _indicatorView.frame = CGRectMake((containerViewWidth - size) / 2, (containerViewHeight - size) / 2, size, size);
    _textLabel.frame = CGRectMake(0, containerViewHeight - textLabelHeight, containerViewWidth, textLabelHeight);
}

@end

@implementation SVWaiting

+ (NSMutableDictionary *)viewDictionary
{
    static NSMutableDictionary *dict = nil;
    @synchronized(self.class){
        if(dict == nil){
            dict = [[NSMutableDictionary dictionary] retain];
        }
    }
    return dict;
}

+ (void)showWaiting:(BOOL)waiting inView:(UIView *)view
{
    NSString *viewId = [NSString stringWithFormat:@"%d", (NSInteger)view];
    SVWaitingView *tmpWaitingView = nil;
    if(waiting){
        if([[self viewDictionary] objectForKey:viewId] == nil){
            tmpWaitingView = [[[SVWaitingView alloc] initWithFrame:view.bounds] autorelease];
            if([SVKeyboardState sharedInstance].keyboardVisible){
                CGRect tmpRect = tmpWaitingView.frame;
                tmpRect.origin.y -= 120.0f;
                tmpWaitingView.frame = tmpRect;
            }
            tmpWaitingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [[self viewDictionary] setObject:tmpWaitingView forKey:viewId];
            
            [view addSubview:tmpWaitingView];
            tmpWaitingView.textLabel.text = @"请稍候";
            [tmpWaitingView.indicatorView startAnimating];
        }
    }else{
        tmpWaitingView = [[self viewDictionary] objectForKey:viewId];
        [UIView animateWithDuration:0.25f animations:^{
            tmpWaitingView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [tmpWaitingView removeFromSuperview];
            [[self viewDictionary] removeObjectForKey:viewId];
        }];
    }
}

+ (void)showLoading:(BOOL)loading inView:(UIView *)view
{
    NSString *viewId = [NSString stringWithFormat:@"%d", (NSInteger)view];
    SVWaitingView *tmpWaitingView = nil;
    if(loading){
        if([[self viewDictionary] objectForKey:viewId] == nil){
            tmpWaitingView = [[[SVWaitingView alloc] initWithFrame:view.bounds] autorelease];
            tmpWaitingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [[self viewDictionary] setObject:tmpWaitingView forKey:viewId];
            
            [view addSubview:tmpWaitingView];
            tmpWaitingView.textLabel.text = @"请稍候";
            tmpWaitingView.backgroundRoundView.hidden = YES;
            tmpWaitingView.textLabel.textColor = [UIColor blackColor];
            tmpWaitingView.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            if([tmpWaitingView.indicatorView respondsToSelector:@selector(color)]){
                tmpWaitingView.indicatorView.color = [UIColor blackColor];
            }
            tmpWaitingView.backgroundColor = [UIColor whiteColor];
            [tmpWaitingView.indicatorView startAnimating];
        }
    }else{
        tmpWaitingView = [[self viewDictionary] objectForKey:viewId];
        [tmpWaitingView removeFromSuperview];
        [[self viewDictionary] removeObjectForKey:viewId];
    }
}

@end
