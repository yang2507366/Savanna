//
//  CustomLocationManager.m
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SVAccurateLocationManager.h"
#import "SVMapkitLocationManager.h"
#import "SVPreciseLocationManager.h"

@interface SVAccurateLocationManager () <SVLocationManagerDelegate>

@property(nonatomic, retain)SVMapkitLocationManager *mapkitLocationMgr;
@property(nonatomic, retain)SVPreciseLocationManager *preciseLocationMgr;

@property(nonatomic, retain)CLLocation *preciseLocation;

@end

@implementation SVAccurateLocationManager

@synthesize delegate;

@synthesize mapkitLocationMgr;
@synthesize preciseLocationMgr;

@synthesize preciseLocation;

- (void)dealloc
{
    [self.mapkitLocationMgr cancel]; self.mapkitLocationMgr = nil;
    [self.preciseLocationMgr cancel]; self.preciseLocationMgr = nil;
    
    self.preciseLocation = nil;
    [super dealloc];
}

- (void)startUpdatingLocation
{
    self.preciseLocationMgr = [[[SVPreciseLocationManager alloc] init] autorelease];
    self.preciseLocationMgr.delegate = self;
    [self.preciseLocationMgr startUpdatingLocation];
}

- (void)cancel
{
    self.delegate = nil;
}

#pragma mark - private methods
- (void)notifySucceed:(CLLocation *)location
{
    if([self.delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:)]){
        [self.delegate locationManager:self didUpdateToLocation:location];
    }
}

- (void)notifyError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(locationManager:didFailWithError:)]){
        [self.delegate locationManager:self didFailWithError:error];
    }
}

#pragma mark - LocationManagerDelegate
- (void)locationManager:(id)locationManager didUpdateToLocation:(CLLocation *)location
{
//    NSLog(@"Accuracy:%f, %f", location.horizontalAccuracy, location.verticalAccuracy);
    if(locationManager == self.preciseLocationMgr){
//        NSLog(@"preciseCoordinate:%f, %f", location.coordinate.latitude, location.coordinate.longitude);
        self.preciseLocation = location;
        self.mapkitLocationMgr = [[[SVMapkitLocationManager alloc] init] autorelease];
        self.mapkitLocationMgr.delegate = self;
        [self.mapkitLocationMgr startUpdatingLocation];
    }else if(locationManager == self.mapkitLocationMgr){
//        NSLog(@"mapkitCoordinate:%f, %f", location.coordinate.latitude, location.coordinate.longitude);
        [self notifySucceed:location];
    }
}

- (void)locationManager:(id)locationManager didFailWithError:(NSError *)error
{
    if(locationManager == self.preciseLocationMgr){
        [self notifyError:error];
    }else if(locationManager == self.mapkitLocationMgr){
        if(CLLocationCoordinate2DIsValid(self.preciseLocation.coordinate)){
            [self notifySucceed:self.preciseLocation];
        }else{
            [self notifyError:error];
        }
    }
}

@end
