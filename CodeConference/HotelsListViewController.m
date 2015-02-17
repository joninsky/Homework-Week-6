//
//  HotelsListViewController.m
//  CodeConference
//
//  Created by Jon Vogel on 2/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "HotelsListViewController.h"
#import "Hotels.h"
#import "Rooms.h"
#import "AppDelegate.h"
#import "RoomsListViewController.h"
#import "HotelService.h"


@interface HotelsListViewController ()




//The Table View Property
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
//Set properties so we can get the managed object context.
@property (strong, nonatomic) NSManagedObjectContext *myManagedObjectContext;
@property (strong, nonatomic) NSArray *arrayOfHotels;

@end

@implementation HotelsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //Set up the managed object context
  self.myManagedObjectContext = [[HotelService sharedService] coreDataStack].managedObjectContext;
  
  //Set the data source and delegate for the table view
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;
  //Fetch the Hotels from the Hotelservice shared instance
  self.arrayOfHotels = [[HotelService sharedService] fetchHotels];
  
}

//MARK: Table View Datasource and delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.arrayOfHotels){
    return self.arrayOfHotels.count;
  }else{
    return 0;
  }
  
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell" forIndexPath:indexPath];
  
  if (self.arrayOfHotels){
    Hotels *hotel = self.arrayOfHotels[indexPath.row];
    Cell.textLabel.text = hotel.name;
  }else{
    Cell.textLabel.text = @"No Hotels";
  }
  return Cell;
}


//MARK: Prepare for seque funciton
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  RoomsListViewController *DVC = segue.destinationViewController;
  NSIndexPath *indexPathOfSelected = [self.myTableView indexPathForSelectedRow];
  Hotels *hotelToPass = self.arrayOfHotels[indexPathOfSelected.row];
  DVC.theHotel = hotelToPass;
}


@end
