//
//  ReservationListViewController.m
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "ReservationListViewController.h"
#import "Reservations.h"

@interface ReservationListViewController ()
@property (strong,nonatomic) NSArray *arrayOfReservations;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ReservationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;
  
  self.arrayOfReservations = [[NSArray alloc]initWithArray:[self.theRoom.reservation allObjects]];
    // Do any additional setup after loading the view.
}


//MARK:Table view datasource funcitons
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if (self.arrayOfReservations.count != 0){
    return self.arrayOfReservations.count;
  }else{
    return 1;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *Cell = [self.myTableView dequeueReusableCellWithIdentifier:@"reservationCell" forIndexPath:indexPath];
  if (self.arrayOfReservations.count != 0){
    Reservations *theReservation = self.arrayOfReservations[indexPath.row];
    NSString *theString = [[NSString alloc]initWithFormat:@"%@ through %@", theReservation.startDate, theReservation.endDate];
    Cell.textLabel.text = theString;
    
  }else{
    Cell.textLabel.text = @"No Reservations";
  }
  
  return Cell;
  
  
}



@end
