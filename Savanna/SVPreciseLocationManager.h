//
//  BestLocationManager.h
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SVLocationManager.h"

@interface SVPreciseLocationManager : NSObject <SVLocationManager> {
    id<SVLocationManagerDelegate> _delegate;
    
    CLLocationManager *_locationManager;
}

@end
