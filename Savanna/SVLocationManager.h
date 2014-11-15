//
//  LocationManager.h
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@protocol SVLocationManagerDelegate <NSObject>

@optional
- (void)locationManager:(id)locationManager didUpdateToLocation:(CLLocation *)location;
- (void)locationManager:(id)locationManager didFailWithError:(NSError *)error;

@end

@protocol SVLocationManager <NSObject>

@property(nonatomic, assign)id<SVLocationManagerDelegate>delegate;
- (void)startUpdatingLocation;
- (void)cancel;

@end
