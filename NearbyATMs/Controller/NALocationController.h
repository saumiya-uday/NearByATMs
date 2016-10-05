//
//  NALocationController.h
//  NearbyATMs
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

/*
 * UIViewController displays location details about the branch
 */

#import <UIKit/UIKit.h>
#import "Location.h"

@interface NALocationController : UIViewController

// used to store selected pin details
@property(nonatomic,strong) Location *locationdetails;

@end
