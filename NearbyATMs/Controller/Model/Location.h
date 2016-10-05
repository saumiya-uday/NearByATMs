//
//  location.h
//  NearBy ATM
//
//  Created by Saumiya on 24/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Model for webservice response
 * Model stores location pin details
 */

enum {
    LocationATM,
    LocationBranch,
    
};
typedef NSInteger LocationType;

@interface Location : NSObject<NSCopying>

@property (nonatomic, strong) NSString *lName;
@property (nonatomic, strong) NSString *lState;
@property (nonatomic, strong) NSString *lLocType;
@property (nonatomic, assign) LocationType lLocationType;
@property (nonatomic, strong) NSString *lLabel;
@property (nonatomic, strong) NSString *lAddress;
@property (nonatomic, strong) NSString *lCity;
@property (nonatomic, strong) NSString *lZip;
@property (nonatomic, strong) NSString *lLat;
@property (nonatomic, strong) NSString *lLong;
@property (nonatomic, strong) NSString *lBank;
@property (nonatomic, strong) NSString *lType;
@property (nonatomic, strong) NSArray *lLobbyHrs;
@property (nonatomic, strong) NSArray *lDriveUpHrs;
@property (nonatomic, strong) NSArray *lService;
@property (nonatomic, strong) NSString *lPhone;
@property (nonatomic) NSNumber *lDistance;
@property (nonatomic) NSNumber *lAtms;

@end
