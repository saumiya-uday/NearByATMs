//
//  ViewController.m
//  NearbyATMs
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "NAMapController.h"
#import "NALocationController.h"
#import "WebServiceManager.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "AlertUser.h"
#import "Location.h"
#import "MapAnnotation.h"


@interface NAMapController (){
    MBProgressHUD *hud;
    __weak IBOutlet UILabel *lblMyLocation;
}
@property (nonatomic,weak)IBOutlet GMSMapView *mapView;
@property (nonatomic,strong)NSMutableArray *arrLocationForMap;
@property (nonatomic,strong) LocationManager *locationManager;
@property (nonatomic)Reachability *internetReachability;

@end

@implementation NAMapController
@synthesize mapView;

#pragma mark- View Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //Setup google map
    self.mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    
    //Intialize location service to fetch user location
    _locationManager = [LocationManager sharedManager];
    [_locationManager startUserLocation];
    _locationManager.delegate = self;
    
    //Network connectivity check
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    //Loading View displayed until location details are fetched
    if (hud == nil) {
        hud = [[MBProgressHUD alloc]initWithView:self.view];
        [hud setOpacity:0.5f];
        hud.labelText = @"Fetching Location";
        [self.view addSubview:hud];
        
    }
    [hud show:YES];
    
}

/* 
 * addMarker method called from delegate after receiving reponse from webservice
 * Configure Google map with pins lat,long, description
 * create bound of all points and focus map camera on markers
 */
- (void)addMarkerOnMap {
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    CLLocationCoordinate2D locationCord;

    GMSMutablePath *gmspath = [GMSMutablePath path];
    for (Location *eachLocation in self.arrLocationForMap) {
        MapAnnotation *mapMarker = [[MapAnnotation alloc] init];
        locationCord.latitude = [eachLocation.lLat floatValue];
        locationCord.longitude = [eachLocation.lLong floatValue];
        mapMarker.position = CLLocationCoordinate2DMake(locationCord.latitude, locationCord.longitude);
        bounds = [bounds includingCoordinate:mapMarker.position];
        mapMarker.markerDetails = eachLocation;
        mapMarker.title = eachLocation.lLabel;
        mapMarker.snippet = [NSString stringWithFormat:@"Distance %@miles %@",eachLocation.lDistance,[eachLocation.lLocType uppercaseString]];
        mapMarker.map = self.mapView;
        mapMarker.appearAnimation = kGMSMarkerAnimationPop;
        if (eachLocation.lLocationType == LocationATM) {
             mapMarker.icon = [MapAnnotation markerImageWithColor:[UIColor greenColor]];
        }
        else{
             mapMarker.icon = [MapAnnotation markerImageWithColor:[UIColor redColor]];
        }
       
        [gmspath addCoordinate: mapMarker.position];
    }
    
    GMSCoordinateBounds *markerBounds = [[GMSCoordinateBounds alloc] initWithPath:gmspath];
    GMSCameraUpdate  *updatedCamera = [GMSCameraUpdate fitBounds:markerBounds withPadding:30.0f];
    [self.mapView animateWithCameraUpdate:updatedCamera];
}

#pragma mark- LocationManagerDelegate Methods

/*
 * Method called from LocationManager when user location fails
 */
-(void)locationManagerWithError:(NSString *)errMsg{
    [hud hide:YES];
    
    [AlertUser displayAlertWithTitle:NSLocalizedString(@"LOCATION_NOT_FOUND_ALERT_TITLE", @"") message:@"" withDelegate:self cancelButton:NSLocalizedString(@"OK", @"")];
    
}

/*
 * Method called from LocationManager when user location is obtained
 */
-(void)locationManagerWithUserLocation:(CLLocationCoordinate2D )location{
    
    __weak NAMapController *weakSelf = self;
    
    WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
    [webServiceManager fetchLocations:location withCompletionHandler:^(NSError *err, NSArray *arrLocations) {
        if (err) {
            
        }
        else{
            if (arrLocations != nil) {
                weakSelf.arrLocationForMap = [NSMutableArray arrayWithArray:arrLocations];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];
                    [weakSelf addMarkerOnMap];
                });
            }
        }
    }];
}

/*
 * Reverse Geolocation response from LocationManager
 */
-(void)locationManagerWithAddress:(NSString *)strAddress{
    
    lblMyLocation.text = [NSString stringWithFormat:@"%@\n",strAddress];
}

#pragma mark- Google Map Delegate Methods

/*
 * Callback for user click on GoogleMap pin Info Window
 */
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    [self performSegueWithIdentifier:@"LocationDetailSegue" sender:marker];
}

/*
 * Navigate user to LocationDetail Screen
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapAnnotation *pin = (MapAnnotation *)sender;
    if ([[segue identifier] isEqualToString:@"LocationDetailSegue"]) {
        
        NALocationController *locationViewController = [segue destinationViewController];
        locationViewController.locationdetails = pin.markerDetails;
        
    }
}

/*
 * Internet Rechability Callback
 */

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    
    if (netStatus == NotReachable && connectionRequired == NO)
    {
        [AlertUser displayAlertWithTitle:NSLocalizedString(@"NO_INTERNET_ALERT_TITLE", @"") message:@"" withDelegate:self cancelButton:NSLocalizedString(@"OK", @"")];
    }
    else{
        if (_locationManager.currentLocation == nil) {
            [_locationManager startUserLocation];
        }
    }
}







@end
