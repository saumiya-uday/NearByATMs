//
//  AlertUser.m
//  NearbyATMs
//
//  Created by Saumiya on 26/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "AlertUser.h"

@implementation AlertUser

+(void)displayAlertWithTitle:(NSString *)title message:(NSString *)msg withDelegate:(id)delegate cancelButton:(NSString *)btnName{
    
    //Gaurd for ios 8
    if([UIAlertView class]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:btnName otherButtonTitles: nil];
        [alert show];
        
    } else {
        
        //ios 9
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:msg
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(btnName, @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
        UIViewController *presenterController = (UIViewController *)delegate;
        
        [alertController addAction:cancelAction];
        [presenterController presentViewController:alertController animated:YES completion:nil];
    }
}

@end
