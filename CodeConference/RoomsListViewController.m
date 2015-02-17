//
//  RoomsListViewController.m
//  CodeConference
//
//  Created by Jon Vogel on 2/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "RoomsListViewController.h"
#import "Rooms.h"
#import "Hotels.h"
#import "ReservationViewController.h"

@interface RoomsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *arrayOfRooms;

@end

@implementation RoomsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.myTableView.dataSource = self;
  self.arrayOfRooms = [self.theHotel.rooms allObjects];
  
  
}



//MARK: TableView Datasource funcitons
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.arrayOfRooms){
    return self.arrayOfRooms.count;
  }else{
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"roomsCell" forIndexPath:indexPath];
  
  if (self.arrayOfRooms){
    
    Rooms *theRoom = self.arrayOfRooms[indexPath.row];
    Cell.textLabel.text = [NSString stringWithFormat:@"%@", theRoom.number];
  }else{
    Cell.textLabel.text = @"No Rooms";
  }
  
  
  return Cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  ReservationViewController *DVC = segue.destinationViewController;
  NSIndexPath *thePath = self.myTableView.indexPathForSelectedRow;
  DVC.theRoom = self.arrayOfRooms[thePath.row];
}

@end
