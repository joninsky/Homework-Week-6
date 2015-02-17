//
//  SearchReservationViewController.m
//  CodeConference
//
//  Created by Jon Vogel on 2/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "SearchReservationViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Hotels.h"
#import "Rooms.h"
#import "HotelService.h"
#import "ReservationListViewController.h"


@interface SearchReservationViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *afterDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *beforeDate;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (strong, nonatomic) NSManagedObjectContext *myManagedObjectContext;
@property (strong, nonatomic) NSArray *arrayOfRooms;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SearchReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //Set up the managed object context
  self.myManagedObjectContext = [[HotelService sharedService] coreDataStack].managedObjectContext ;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Rooms"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(reservation, $x,  ANY $x.startDate <= %@ and $x.endDate >= %@).@count = 0",self.beforeDate.date, self.afterDate.date];
  fetchRequest.predicate = predicate;
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:true];
  fetchRequest.sortDescriptors = @[sort];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.myManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
  self.fetchedResultsController.delegate = self;
  [self.fetchedResultsController performFetch:nil];
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;
}

//Get the available rooms for the selected time frame and instantiate the NSFetchedResults Controller
-(NSArray*)fetchAvailableRoomsForHotelAfterDate:(NSDate*)after beforeDate:(NSDate*)before{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Rooms"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(reservation, $x,  ANY $x.startDate <= %@ and $x.endDate >= %@).@count = 0",before, after];
  fetchRequest.predicate = predicate;
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:true];
  fetchRequest.sortDescriptors = @[sort];
  NSArray *results = [self.myManagedObjectContext executeFetchRequest:fetchRequest error:nil];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.myManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
  self.fetchedResultsController.delegate = self;
  NSLog(@"%lu", (unsigned long)results.count);
  return results;
}



-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
  [self.myTableView beginUpdates];
  
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  [self.myTableView endUpdates];
  
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.myTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.myTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
    case NSFetchedResultsChangeMove:
      [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.myTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    default:
      break;
  }
  
  
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath {
  Rooms *theRoom = [self.fetchedResultsController objectAtIndexPath:indexPath];
  NSString *roomNumber = [NSString stringWithFormat:@"%@", theRoom.number];
  cell.textLabel.text = theRoom.hotel.name;
  cell.detailTextLabel.text = roomNumber;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}


//MARK: Table View Datasource and delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  //return self.arrayOfRooms.count;
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  NSLog(@"%lu", (unsigned long)[sectionInfo numberOfObjects]);
  return  [sectionInfo numberOfObjects];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"rooms" forIndexPath:indexPath];
  
  [self configureCell:Cell atIndexPath:indexPath];

  return Cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  ReservationListViewController *DVC = segue.destinationViewController;
  NSIndexPath *thePath = [self.myTableView indexPathForSelectedRow];
  Rooms *roomToPass = [self.arrayOfRooms objectAtIndex:thePath.row];
  DVC.theRoom = roomToPass;
}




- (IBAction)searchButton:(id)sender {
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(reservation, $x,  ANY $x.startDate <= %@ and $x.endDate >= %@).@count = 0",self.beforeDate.date, self.afterDate.date];
  [self.fetchedResultsController.fetchRequest setPredicate:predicate];
  [self.fetchedResultsController performFetch:nil];
  //self.arrayOfRooms = [self fetchAvailableRoomsForHotelAfterDate:self.afterDate.date beforeDate:self.beforeDate.date];
  [self.myTableView reloadData];
}

@end
