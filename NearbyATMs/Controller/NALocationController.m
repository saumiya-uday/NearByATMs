//
//  NALocationController.m
//  NearbyATMs
//
//  Created by Saumiya on 25/09/16.
//  Copyright © 2016 --. All rights reserved.
//

#import "NALocationController.h"
#import "NSString+StringAdditional.h"

@interface NALocationController (){
    
    //UI Components to display details of ATM/ Branch location
    
    __weak IBOutlet UILabel *lblMiles;
    __weak IBOutlet UILabel *lblLabel;
    __weak IBOutlet UILabel *lblAddress;
    __weak IBOutlet UILabel *lblPhone;
    __weak IBOutlet UILabel *lblBranch;
    __weak IBOutlet UILabel *lblLobbyWeekDays;
    __weak IBOutlet UILabel *lblATM;
    __weak IBOutlet UILabel *lblBusinessWeekDay;
    __weak IBOutlet UILabel *lblBusinessHeader;
    __weak IBOutlet UILabel *lblLobbyHourHeader;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *btnCall;
    __weak IBOutlet UILabel *lblService;
    __weak IBOutlet UILabel *lblServiceDetails;
}


@end

@implementation NALocationController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    
    self.title = [NSString stringWithFormat:@"%@",_locationdetails.lLocType.uppercaseString];
    lblLabel.text = _locationdetails.lLabel;
    lblMiles.text = [NSString stringWithFormat:@"%@miles",_locationdetails.lDistance];
    lblAddress.text = [NSString stringWithFormat:@"%@\n%@,%@",_locationdetails.lAddress,_locationdetails.lCity,_locationdetails.lZip];
    if (_locationdetails.lPhone.length == 0) {
        btnCall.hidden = YES;
        lblPhone.text = @"";
    }
    else{
        lblPhone.text = _locationdetails.lPhone;

    }
    lblBranch.text = [_locationdetails.lAtms intValue] == 0? NSLocalizedString(@"ATM_ONLY", @""):[NSString stringWithFormat:@"Branch with %@ ATMs",_locationdetails.lAtms];
    lblATM.text = NSLocalizedString(@"ATM_24_HR", @"");
    NSString *lobbyHrs = [self workingHours:_locationdetails.lLobbyHrs];
    if ([lobbyHrs isEqualToString:@""]) {
        lblLobbyWeekDays.text = @"";
        lblLobbyHourHeader.text = @"";
    }
    else{
        lblLobbyHourHeader.text = NSLocalizedString(@"LOBBY_HR", @"");
        lblLobbyWeekDays.text = lobbyHrs;
    }
    NSString *driveUpHours = [self workingHours:_locationdetails.lDriveUpHrs];
    if ([driveUpHours isEqualToString:@""]) {
        lblBusinessWeekDay.text = @"";
        lblBusinessHeader.text = @"";
    }
    else{
        
        lblBusinessHeader.text = NSLocalizedString(@"BUSINESS_HR", @"");
        lblBusinessWeekDay.text = driveUpHours;


    }
    if (_locationdetails.lService.count > 0) {
        lblService.hidden = NO;
        lblServiceDetails.text = [_locationdetails.lService componentsJoinedByString:@"\n"];
        
    }
    else{
        lblService.hidden = YES;
        lblServiceDetails.hidden = YES;
    }
}

/*
 * Filter working hours
 */

-(NSString *)workingHours:(NSArray *)arrayHrs {
    NSString *workingHRs =@"";
    NSString* filter = @"SELF == ''";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:filter];
    NSArray* filteredData = [arrayHrs filteredArrayUsingPredicate:predicate];
    if (filteredData.count == arrayHrs.count) {
        workingHRs = @"";
    }
    else{
            NSString *sundayTime= @"";
            NSString *weekDayTime = @"";
            NSString *satDayTime = @"";
            for (int index = 0; index < arrayHrs.count; index ++) {
                NSString *time = [arrayHrs objectAtIndex:index];
                    switch (index) {
                        case 0:
                            sundayTime = NSLocalizedString(@"SUNDAY", @"");
                            break;
                        case 1:
                            weekDayTime = [NSString stringWithFormat:@"Mon-Fri %@",time];
                            break;
                        case 6:
                            satDayTime = [NSString stringWithFormat:@"Sat %@",[NSString isStringEmpty:time]?@"Closed":time];
                            break;
        
                        default:
                            break;
                    }
            }
        workingHRs =  [NSString stringWithFormat:@"%@ \n%@\n%@",weekDayTime,satDayTime,sundayTime];
    }

    return workingHRs;
}
#pragma mark - IBOutlet
- (IBAction)callButtonTap:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_locationdetails.lPhone]];
}


@end
