//
//  LocationManager.h
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVLocationManager.h"

@class MKMapView;

@interface SVMapkitLocationManager : NSObject <SVLocationManager> {
    id<SVLocationManagerDelegate> _delegate;
}

@property(nonatomic, assign)NSTimeInterval timeOutSeconds;

@end
