//
//  LocationManager.h
//  NearBy ATM
//
//  Created by Saumiya on 23/09/16.
//  Copyright © 2016 --. All rights reserved.
//

/*
 * SingleTon Class to manage location updates
 * Reverse Geolocation to get user address from latitude and longitude
 * Helper Class that has Location Service setup like accuracy, distance for user location tracing.
 * Delegate method of this class update NAMapController about user location latitude, longitude.
 * This Location details is given to WebserviceManager to retrieve list of nearby ATMS/ Branches from backend server.
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>
-(void)locationManagerWithError:(NSString *)errMsg;
-(void)locationManagerWithUserLocation:(CLLocationCoordinate2D)location;
-(void)locationManagerWithAddress:(NSString *)strAddress;
@end

@interface LocationManager : NSObject<CLLocationManagerDelegate>{
    BOOL firstTime;
}

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic)CLLocation *currentLocation;
@property (nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic,weak) id <LocationManagerDelegate> delegate;

+ (id)sharedManager;
-(void)startUserLocation;

@end
