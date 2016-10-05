//
//  NSString+StringAdditional.m
//  NearbyATMs
//
//  Created by Saumiya on 26/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "NSString+StringAdditional.h"

@implementation NSString (StringAdditional)

+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}
@end
