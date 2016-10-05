//
//  LocationManager.m
//  NearBy ATM
//
//  Created by Saumiya on 23/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "LocationManager.h"
#import "AlertUser.h"
#import "WebServiceManager.h"

@implementation LocationManager
#pragma mark - CLLocationManagerDelegate


/*
 * Creates shared instance of the class
 */
+ (id)sharedManager {
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/*
 * Initialize the class variables
 */
- (id)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        firstTime = TRUE;
        
    }
    return self;
}

/*
 * Start fetching location update ask user permission to access user location
 */
-(void)startUserLocation{
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if (!([CLLocationManager locationServicesEnabled]) || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) ){
        NSLog(@"location services are disabled");
        [AlertUser displayAlertWithTitle:NSLocalizedString(@"LOCATION_ALERT_TITLE", @"") message:NSLocalizedString(@"LOCATION_ALERT_MSG", @"") withDelegate:self.delegate cancelButton:NSLocalizedString(@"OK",@"")];
        return;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"location services are enabled");
        [self.locationManager startUpdatingLocation];
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        NSLog(@"about to show a dialog requesting permission");
    }
    
    
}

#pragma mark -CLLocationManager Delegate methods
//Invoked when an error has occurred.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    if (error) {
        [_delegate locationManagerWithError:error.localizedDescription];
    }
}
/*
 * Invoked when a new location is available. oldLocation may be nil if there is no previous location
 *    available.
 */

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (firstTime == TRUE) {
        firstTime = FALSE;
        self.currentLocation = newLocation;
        
        //Check for location obtained
        if (self.currentLocation != nil) {
            [manager stopUpdatingLocation];
            [self geocodeLocation:self.currentLocation];
            
            //Gaurd to check if delegate class implements the method
            if ([_delegate respondsToSelector:@selector(locationManagerWithUserLocation:)]) {
                [_delegate locationManagerWithUserLocation:self.currentLocation.coordinate];
            }
            
        }
        [self.locationManager stopUpdatingLocation];
    }
}

/*
 * Reverse geolocation method to get location address from Latitude & longitude
 */

- (void)geocodeLocation:(CLLocation*)location
{
    if(_geocoder == nil){
        _geocoder = [[CLGeocoder alloc] init];
    }
    //// reverse geocode requests
    [_geocoder reverseGeocodeLocation:location completionHandler:
     ^(NSArray* placemarks, NSError* error){
         
         if ([placemarks count] > 0)
         {
             CLPlacemark *topResult = [placemarks objectAtIndex:0];
             NSString *addressString = [[[topResult addressDictionary] valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@",\n"];
             
             //Gaurd to check if delegate class implements the method
             if ([_delegate respondsToSelector:@selector(locationManagerWithAddress:)]) {
                 [_delegate locationManagerWithAddress:addressString];
             }
             
         }
         if (error) {
             NSLog(@"Address not obtained for given location points %@",error.description);
         }
     }];
}
@end
