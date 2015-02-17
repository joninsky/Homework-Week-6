//
//  ReservationViewController.m
//  CodeConference
//
//  Created by Jon Vogel on 2/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "ReservationViewController.h"
#import "Reservations.h"
#import <CoreData/CoreData.h>
#import "HotelService.h"
#import "ReservationListViewController.h"

@interface ReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *pickStart;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickEnd;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirm;
@end

@implementation ReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)bookTheRoom:(id)sender {
  Reservations *newReservation = [[HotelService sharedService] createReservation:self.theRoom withStartData:self.pickStart.date withEndDate:self.pickEnd.date];
  NSString *lblText = [[NSString alloc] initWithFormat:@"Booked! Start: %@ End:%@", newReservation.startDate, newReservation.endDate ];
  self.lblConfirm.text = lblText;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  ReservationListViewController *DVC = segue.destinationViewController;
  DVC.theRoom = self.theRoom;
}

@end
