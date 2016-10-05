//
//  WebServiceManager.m
//  NearBy ATM
//
//  Created by Saumiya on 24/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "WebServiceManager.h"
#import "Location.h"


@implementation WebServiceManager

/*
 * Create request for user location and get response from webservice
 */

-(void)fetchLocations:(CLLocationCoordinate2D)myLocation withCompletionHandler:(void(^)(NSError * err, NSArray *arrLocations))completionBlock{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?lat=%f&lng=%f",kBaseURL,myLocation.latitude,myLocation.longitude]];
  
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionBlock(error,nil);
        }
        else{
            if (data) {
                
                //Parse webservice json response
                NSError* jerror;
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jerror];
                NSArray *arrLocation =responseDict[@"locations"];
                NSMutableArray *locations = [[NSMutableArray alloc]init];
                
                //Create Location model from webservice response
                for (NSDictionary *dictLocation in arrLocation) {
                    Location *tempLocation = [[Location alloc]init];
                    tempLocation.lName = dictLocation[@"name"] != [NSNull null]? dictLocation[@"name"]:@"";
                    tempLocation.lState = dictLocation[@"state"] != [NSNull null] ? dictLocation[@"state"]:@"";
                    tempLocation.lLocType = dictLocation[@"locType"] != [NSNull null] ? dictLocation[@"locType"]:@"";
                    if ([tempLocation.lLocType caseInsensitiveCompare:@"ATM"] == NSOrderedSame) {
                        tempLocation.lLocationType = LocationATM;
                    }
                    else if([tempLocation.lLocType caseInsensitiveCompare:@"BRANCH"] == NSOrderedSame){
                         tempLocation.lLocationType = LocationBranch;
                    }
                    tempLocation.lLabel = dictLocation[@"label"] != [NSNull null]? dictLocation[@"label"]:@"";
                    tempLocation.lAddress = dictLocation[@"address"]!= [NSNull null] ? dictLocation[@"address"]:@"";
                    tempLocation.lCity = dictLocation[@"city"]!= [NSNull null] ? dictLocation[@"city"]:@"";
                    tempLocation.lZip = dictLocation[@"zip"] != [NSNull null]? dictLocation[@"zip"]:@"";
                    tempLocation.lLat = dictLocation[@"lat"] != [NSNull null]? dictLocation[@"lat"]:@"";
                    tempLocation.lLong = dictLocation[@"lng"] != [NSNull null]? dictLocation[@"lng"]:@"";
                    tempLocation.lBank = dictLocation[@"bank"]!= [NSNull null] ? dictLocation[@"bank"]:@"";
                    tempLocation.lType = dictLocation[@"type"] != [NSNull null]? dictLocation[@"type"]:@"";
                    tempLocation.lLobbyHrs = dictLocation[@"lobbyHrs"] != [NSNull null]? dictLocation[@"lobbyHrs"]:nil;
                    tempLocation.lDriveUpHrs = dictLocation[@"driveUpHrs"]!= [NSNull null] ? dictLocation[@"driveUpHrs"]:nil;
                    tempLocation.lService = dictLocation[@"services"] != [NSNull null]? dictLocation[@"services"]:@"";
                    tempLocation.lPhone = dictLocation[@"phone"]!= [NSNull null] ? dictLocation[@"phone"]:@"";
                    tempLocation.lDistance = [NSNumber numberWithFloat:[dictLocation[@"distance"]floatValue]];
                    tempLocation.lAtms = [NSNumber numberWithFloat:[dictLocation[@"atms"]floatValue]];
                     [locations addObject:tempLocation];
                }
                completionBlock(nil,locations);
            }
        }
    }];
    [postDataTask resume];
}

@end
