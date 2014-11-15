//
//  SVUIPrefersManager.m
//  imyvoa
//
//  Created by yangzexin on 13-3-13.
//
//

#import "SVUIPrefersManager.h"

NSString *kUIPrefersManagerCurrentPrefersDidChangeNotification = @"kUIPrefersManagerCurrentPrefersDidChangeNotification";

@interface SVSelectorWrapper  : NSObject

@property(nonatomic, assign)SEL selector;

@end

@implementation SVSelectorWrapper

- (void)dealloc
{
    [super dealloc];
}

+ (id)createWithSelector:(SEL)selector
{
    SVSelectorWrapper *tmp = [[SVSelectorWrapper new] autorelease];
    tmp.selector = selector;
    
    return tmp;
}

@end

@interface SVUIPrefersManager ()

@property(nonatomic, assign)BOOL currentPrefersSetted;
@property(nonatomic, retain)NSDictionary *keyClassNameValueSelector;

@end

@implementation SVUIPrefersManager

@synthesize currentPrefers;

+ (id<SVUIPrefersManager>)defaultManager
{
    static id instance = nil;
    if(instance == nil){
        instance = [self.class new];
    }
    return instance;
}

- (void)dealloc
{
    self.currentPrefers = nil;
    self.keyClassNameValueSelector = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    NSDictionary *defaultKeyClassNameValueSelector = @{NSStringFromClass([UIView class]) : [SVSelectorWrapper createWithSelector:@selector(configureView:)],
                                                       NSStringFromClass([UIActivityIndicatorView class]) : [SVSelectorWrapper createWithSelector:@selector(configureActivityIndicatorView:)],
                                                       NSStringFromClass([UIBarButtonItem class]) : [SVSelectorWrapper createWithSelector:@selector(configureBarButtonItem:)],
                                                       NSStringFromClass([UIButton class]) : [SVSelectorWrapper createWithSelector:@selector(configureButton:)],
                                                       NSStringFromClass([UIImageView class]) : [SVSelectorWrapper createWithSelector:@selector(configureImageView:)],
                                                       NSStringFromClass([UILabel class]) : [SVSelectorWrapper createWithSelector:@selector(configureLabel:)],
                                                       NSStringFromClass([UINavigationBar class]) : [SVSelectorWrapper createWithSelector:@selector(configureNavigationBar:)],
                                                       NSStringFromClass([UIPageControl class]) : [SVSelectorWrapper createWithSelector:@selector(configurePageControl:)],
                                                       NSStringFromClass([UIProgressView class]) : [SVSelectorWrapper createWithSelector:@selector(configureProgressView:)],
                                                       NSStringFromClass([UIScrollView class]) : [SVSelectorWrapper createWithSelector:@selector(configureScrollView:)],
                                                       NSStringFromClass([UISearchBar class]) : [SVSelectorWrapper createWithSelector:@selector(configureSearchBar:)],
                                                       NSStringFromClass([UISegmentedControl class]) : [SVSelectorWrapper createWithSelector:@selector(configureSegmentedControl:)],
                                                       NSStringFromClass([UISlider class]) : [SVSelectorWrapper createWithSelector:@selector(configureSlider:)],
                                                       NSStringFromClass([UIStepper class]) : [SVSelectorWrapper createWithSelector:@selector(configureStepper:)],
                                                       NSStringFromClass([UISwitch class]) : [SVSelectorWrapper createWithSelector:@selector(configureSwitch:)],
                                                       NSStringFromClass([UITabBar class]) : [SVSelectorWrapper createWithSelector:@selector(configureActivityIndicatorView:)],
                                                       NSStringFromClass([UITableView class]) : [SVSelectorWrapper createWithSelector:@selector(configureTableView:)],
                                                       NSStringFromClass([UITableViewCell class]) : [SVSelectorWrapper createWithSelector:@selector(configureTableViewCell:)],
                                                       NSStringFromClass([UITextField class]) : [SVSelectorWrapper createWithSelector:@selector(configureTextField:)],
                                                       NSStringFromClass([UITextView class]) : [SVSelectorWrapper createWithSelector:@selector(configureTextView:)],
                                                       NSStringFromClass([UIToolbar class]) : [SVSelectorWrapper createWithSelector:@selector(configureToolbar:)],
                                                       NSStringFromClass([UIWebView class]) : [SVSelectorWrapper createWithSelector:@selector(configureWebView:)]};
    self.keyClassNameValueSelector = defaultKeyClassNameValueSelector;
    
    return self;
}

- (void)setCurrentPrefers:(id<SVUIPrefers>)pcurrentPrefers
{
    if(currentPrefers != pcurrentPrefers){
        [currentPrefers release];
        currentPrefers = [pcurrentPrefers retain];
    }
    
    if(!self.currentPrefersSetted){
        self.currentPrefersSetted = YES;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kUIPrefersManagerCurrentPrefersDidChangeNotification object:nil];
    }
}

- (void)configureViews:(NSArray *)views
{
    NSArray *viewClassNames = [self.keyClassNameValueSelector allKeys];
    NSMutableArray *viewClasses = [NSMutableArray array];
    for(NSString *viewClassName in viewClassNames){
        [viewClasses addObject:NSClassFromString(viewClassName)];
    }
    for(id view in views){
        [self configureView:view viewClasses:viewClasses];
    }
}

- (void)configureView:(id)view viewClasses:(NSArray *)viewClasses
{
    NSMutableArray *matchingClasses = [NSMutableArray array];
    for(Class tmpClass in viewClasses){
        if([view isKindOfClass:tmpClass]){
            [matchingClasses addObject:tmpClass];
        }
    }
    Class nearestClass = [self nearestClassInClassList:matchingClasses];
    //NSLog(@"%@, %@", matchingClasses, nearestClass);
    if(nearestClass){
        NSString *className = NSStringFromClass(nearestClass);
        SVSelectorWrapper *selectorWrapper = [self.keyClassNameValueSelector objectForKey:className];
        [self performSelector:selectorWrapper.selector withObject:view];
    }
}

- (Class)nearestClassInClassList:(NSArray *)classList
{
    if(classList.count == 1){
        return [classList objectAtIndex:0];
    }else{
        NSMutableArray *tmpClassList = [NSMutableArray arrayWithArray:classList];
        [tmpClassList sortUsingComparator:^NSComparisonResult(Class class1, Class class2) {
            return [class1 isSubclassOfClass:class2] ? NSOrderedAscending : NSOrderedDescending;
        }];
        return [tmpClassList objectAtIndex:0];
    }
    return nil;
}

- (id)configureView:(UIView *)view
{
    if([self.currentPrefers respondsToSelector:@selector(configureView:)]){
        return [self.currentPrefers configureView:view];
    }
    return view;
}

- (id)configureActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView
{
    if([self.currentPrefers respondsToSelector:@selector(configureActivityIndicatorView:)]){
        return [self.currentPrefers configureActivityIndicatorView:activityIndicatorView];
    }
    return activityIndicatorView;
}

- (id)configureBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if([self.currentPrefers respondsToSelector:@selector(configureBarButtonItem:)]){
        return [self.currentPrefers configureBarButtonItem:barButtonItem];
    }
    return barButtonItem;
}

-(id)configureButton:(UIButton *)button
{
    if([self.currentPrefers respondsToSelector:@selector(configureButton:)]){
        return [self.currentPrefers configureButton:button];
    }
    return button;
}

- (id)configureImageView:(UIImageView *)imageView
{
    if([self.currentPrefers respondsToSelector:@selector(configureImageView:)]){
        return [self.currentPrefers configureImageView:imageView];
    }
    return imageView;
}

- (id)configureLabel:(UILabel *)label
{
    if([self.currentPrefers respondsToSelector:@selector(configureLabel:)]){
        return [self.currentPrefers configureLabel:label];
    }
    return label;
}

- (id)configureNavigationBar:(UINavigationBar *)navigationBar
{
    if([self.currentPrefers respondsToSelector:@selector(configureNavigationBar:)]){
        return [self.currentPrefers configureNavigationBar:navigationBar];
    }
    return navigationBar;
}

- (id)configurePageControl:(UIPageControl *)pageControl
{
    if([self.currentPrefers respondsToSelector:@selector(configurePageControl:)]){
        return [self.currentPrefers configurePageControl:pageControl];
    }
    return pageControl;
}

- (id)configureProgressView:(UIProgressView *)progressView
{
    if([self.currentPrefers respondsToSelector:@selector(configureProgressView:)]){
        return [self.currentPrefers configureProgressView:progressView];
    }
    return progressView;
}

- (id)configureScrollView:(UIScrollView *)scrollView
{
    if([self.currentPrefers respondsToSelector:@selector(configureScrollView:)]){
        return [self.currentPrefers configureScrollView:scrollView];
    }
    return scrollView;
}

- (id)configureSearchBar:(UISearchBar *)searchBar
{
    if([self.currentPrefers respondsToSelector:@selector(configureSearchBar:)]){
        return [self.currentPrefers configureSearchBar:searchBar];
    }
    return searchBar;
}

- (id)configureSegmentedControl:(UISegmentedControl *)segmentedControl
{
    if([self.currentPrefers respondsToSelector:@selector(configureSegmentedControl:)]){
        return [self.currentPrefers configureSegmentedControl:segmentedControl];
    }
    return segmentedControl;
}

- (id)configureSlider:(UISlider *)slider
{
    if([self.currentPrefers respondsToSelector:@selector(configureSlider:)]){
        return [self.currentPrefers configureSlider:slider];
    }
    return slider;
}

- (id)configureStepper:(UIStepper *)stepper
{
    if([self.currentPrefers respondsToSelector:@selector(configureStepper:)]){
        return [self.currentPrefers configureStepper:stepper];
    }
    return stepper;
}

- (id)configureSwitch:(UISwitch *)uiswitch
{
    if([self.currentPrefers respondsToSelector:@selector(configureSwitch:)]){
        return [self.currentPrefers configureSwitch:uiswitch];
    }
    return uiswitch;
}

- (id)configureTabBar:(UITabBar *)tabbar
{
    if([self.currentPrefers respondsToSelector:@selector(configureTabBar:)]){
        return [self.currentPrefers configureTabBar:tabbar];
    }
    return tabbar;
}

- (id)configureTableView:(UITableView *)tableView
{
    if([self.currentPrefers respondsToSelector:@selector(configureTableView:)]){
        return [self.currentPrefers configureTableView:tableView];
    }
    return tableView;
}

- (id)configureTableViewCell:(UITableViewCell *)tableViewCell
{
    if([self.currentPrefers respondsToSelector:@selector(configureTableViewCell:)]){
        return [self.currentPrefers configureTableViewCell:tableViewCell];
    }
    return tableViewCell;
}

- (id)configureTextField:(UITextField *)textField
{
    if([self.currentPrefers respondsToSelector:@selector(configureTextField:)]){
        return [self.currentPrefers configureTextField:textField];
    }
    return textField;
}

- (id)configureTextView:(UITextView *)textView
{
    if([self.currentPrefers respondsToSelector:@selector(configureTextView:)]){
        return [self.currentPrefers configureTextView:textView];
    }
    return textView;
}

- (id)configureToolbar:(UIToolbar *)toolbar
{
    if([self.currentPrefers respondsToSelector:@selector(configureToolbar:)]){
        return [self.currentPrefers configureToolbar:toolbar];
    }
    return toolbar;
}

- (id)configureWebView:(UIWebView *)webView
{
    if([self.currentPrefers respondsToSelector:@selector(configureWebView:)]){
        return [self.currentPrefers configureWebView:webView];
    }
    return webView;
}

@end
