//
//  SVUIPrefersManager.h
//  imyvoa
//
//  Created by yangzexin on 13-3-13.
//
//

#import <Foundation/Foundation.h>
#import "SVUIPrefers.h"

OBJC_EXPORT NSString *kUIPrefersManagerCurrentPrefersDidChangeNotification;

@protocol SVUIPrefersManager <SVUIPrefers>

@property(nonatomic, retain)id<SVUIPrefers> currentPrefers;
- (void)configureViews:(NSArray *)views;

@end

@interface SVUIPrefersManager : NSObject <SVUIPrefersManager>

+ (id<SVUIPrefersManager>)defaultManager;

@end
