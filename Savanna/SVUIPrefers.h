//
//  UIPerfers.h
//  imyvoa
//
//  Created by yangzexin on 13-3-13.
//
//

#import <Foundation/Foundation.h>

@protocol SVUIPrefers <NSObject>

@optional
- (id)configureView:(UIView *)view;
- (id)configureActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;
- (id)configureBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (id)configureButton:(UIButton *)button;
- (id)configureImageView:(UIImageView *)imageView;
- (id)configureLabel:(UILabel *)label;
- (id)configureNavigationBar:(UINavigationBar *)navigationBar;
- (id)configurePageControl:(UIPageControl *)pageControl;
- (id)configureProgressView:(UIProgressView *)progressView;
- (id)configureScrollView:(UIScrollView *)scrollView;
- (id)configureSearchBar:(UISearchBar *)searchBar;
- (id)configureSegmentedControl:(UISegmentedControl *)segmentedControl;
- (id)configureSlider:(UISlider *)slider;
- (id)configureStepper:(UIStepper *)stepper;
- (id)configureSwitch:(UISwitch *)uiswitch;
- (id)configureTabBar:(UITabBar *)tabbar;
- (id)configureTableView:(UITableView *)tableView;
- (id)configureTableViewCell:(UITableViewCell *)tableViewCell;
- (id)configureTextField:(UITextField *)textField;
- (id)configureTextView:(UITextView *)textView;
- (id)configureToolbar:(UIToolbar *)toolbar;
- (id)configureWebView:(UIWebView *)webView;

@end
