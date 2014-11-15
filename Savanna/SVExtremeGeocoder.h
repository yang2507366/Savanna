//
//  ExtremeGeocoder.h
//  GWV2
//
//  Created by yangzexin on 12-10-11.
//
//

#import <Foundation/Foundation.h>
#import "SVGeocoder.h"

@interface SVExtremeGeocoder : NSObject <SVGeocoder>

- (id)initWithGeocoderList:(NSArray *)pGeocoderList;

@end
