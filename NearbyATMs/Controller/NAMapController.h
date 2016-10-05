//
//  ViewController.h
//  NearbyATMs
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LocationManager.h"

@interface NAMapController : UIViewController<LocationManagerDelegate,GMSMapViewDelegate,UIAlertViewDelegate>

@end

