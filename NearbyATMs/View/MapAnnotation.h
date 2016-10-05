//
//  MapPin.h
//  NearbyATMs
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

/*
 * Custom class to add Location Model in GMSMarker
 */

#import <GoogleMaps/GoogleMaps.h>
#import "Location.h"
@interface MapAnnotation : GMSMarker
@property(nonatomic,strong) Location *markerDetails;

@end
