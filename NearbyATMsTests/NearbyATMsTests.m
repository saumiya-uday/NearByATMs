//
//  NearbyATMsTests.m
//  NearbyATMsTests
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebServiceManager.h"

@interface NearbyATMsTests : XCTestCase{
    WebServiceManager *webServiceManager;
}

@end

@implementation NearbyATMsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    webServiceManager = [[WebServiceManager alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self testLondonLocation];
    }];
}

-(void) testLondonLocation {
    // Perform code under test
    //Simulate Location for London
    //Latitude for NY United States lat=40.759211 lng=-73.984638
    CLLocationCoordinate2D londonCoords = CLLocationCoordinate2DMake(40.759211, -73.984638);
    [webServiceManager fetchLocations:londonCoords withCompletionHandler:^(NSError *err, NSArray *arrLocations) {
        XCTAssertNotNil(arrLocations, @"Locations Nearby ATMS not available");
        XCTAssertNil(err, @"Error should be nil");
        XCTAssertNotNil(arrLocations, @"Location has ATMS nearby");
        if (err.code) {
            XCTFail("Error in fetching ATM details");
        }
        
    }];
    
}

@end
