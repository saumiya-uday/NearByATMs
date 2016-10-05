//
//  AlertUser.h
//  NearbyATMs
//
//  Created by Saumiya on 26/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertUser : UIView
+(void)displayAlertWithTitle:(NSString *)title message:(NSString *)msg withDelegate:(id)delegate cancelButton:(NSString *)btnName;
@end
