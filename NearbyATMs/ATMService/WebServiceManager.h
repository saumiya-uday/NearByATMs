//
//  WebServiceManager.h
//  NearBy ATM
//
//  Created by Saumiya on 24/09/16.
//  Copyright © 2016 --. All rights reserved.
//

/*
 WebserviceManager
 Responsible to fetch ATM list nearby from the latitude and longitude obtained. Completion handler updated the Maps with the annotations for the coresponding latitude,longitude on Google Map
 */
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface WebServiceManager : NSObject<NSURLSessionTaskDelegate>
-(void)fetchLocations:(CLLocationCoordinate2D)myLocation withCompletionHandler:(void(^)(NSError * err, NSArray *arrLocations))completionBlock;
@end
