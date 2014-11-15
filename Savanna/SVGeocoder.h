//
//  GeocoderProvider.h
//  GWV2
//
//  Created by gewara on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVLocationDescription;

@protocol SVGeocoderDelegate <NSObject>

@optional
- (void)geocoder:(id)geocoder didRecieveLocality:(SVLocationDescription *)info;
- (void)geocoder:(id)geocoder didError:(NSError *)error;

@end

@protocol SVGeocoder <NSObject>

@property(nonatomic, assign)id<SVGeocoderDelegate> delegate;

- (void)geocodeWithLatitude:(double)latitude longitude:(double)longitude;
- (void)cancel;

@end
