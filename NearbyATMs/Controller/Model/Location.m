//
//  Branch.m
//  NearBy ATM
//
//  Created by Saumiya on 24/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "Location.h"

@implementation Location
- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy)
    {
        // Copy NSObject subclasses
        [copy setLLabel:[self.lName copyWithZone:zone]];
        [copy setLState:[self.lState copyWithZone:zone]];
        [copy setLLocType:[self.lLocType copyWithZone:zone]];
        [copy setLName:[self.lName copyWithZone:zone]];
        [copy setLAddress:[self.lAddress copyWithZone:zone]];
        [copy setLCity:[self.lCity copyWithZone:zone]];
        [copy setLZip:[self.lZip copyWithZone:zone]];
        [copy setLLat:[self.lLat copyWithZone:zone]];
        [copy setLLong:[self.lLong copyWithZone:zone]];
        [copy setLBank:[self.lBank copyWithZone:zone]];
        [copy setLType:[self.lType copyWithZone:zone]];
        [copy setLLobbyHrs:[self.lLobbyHrs copyWithZone:zone]];
        [copy setLDriveUpHrs:[self.lDriveUpHrs copyWithZone:zone]];
        [copy setLService:[self.lService copyWithZone:zone]];
        [copy setLPhone:[self.lPhone copyWithZone:zone]];
        [copy setLDistance:[self.lDistance copyWithZone:zone]];
        [copy setLAtms:[self.lAtms copyWithZone:zone]];
        
    }
    
    return copy;
}
@end
