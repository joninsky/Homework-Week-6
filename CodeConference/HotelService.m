//
//  HotelService.m
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService


+(id)sharedService {
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    mySharedService = [[self alloc] init];
  });
  return mySharedService;
}


-(instancetype)init {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] init];
  }
  return self;
}

-(instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}

//MARK: Core Data Funcitons
-(NSArray *)fetchHotels{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotels"];
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:nil];
  return results;
}

-(Reservations*)createReservation:(Rooms*)theRoom withStartData:(NSDate*)startDate withEndDate:(NSDate*)endDate{
  Reservations *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservations" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  newReservation.startDate = startDate;
  newReservation.endDate = endDate;
  newReservation.room = theRoom;
  [self.coreDataStack.managedObjectContext save:nil];
  return newReservation;
}

-(NSArray*)fetchAvailableRoomsForHotelAfterDate:(NSDate*)after beforeDate:(NSDate*)before{
  //NSLog(@"After:%@ Before:%@", after, before);
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Rooms"];
  //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate >= %@ and endDate <= %@",before, after];
  //NSPredicate *predicateTwo = [NSPredicate predicateWithFormat:@"Rooms.reservation.endDate ]
 // fetchRequest.predicate = predicate;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:nil];
  NSMutableArray *mutatingResults = [[NSMutableArray alloc]initWithArray:results];
  for (int i = 0; i < [mutatingResults count]; i++){
    Rooms *theRoom = [mutatingResults objectAtIndex:i];
    NSMutableArray *reservations = [[NSMutableArray alloc]initWithArray:[theRoom.reservation allObjects]];
    for (Reservations *res in reservations){
      if (res.startDate <= before && res.endDate >= after) {
        //NSLog(@"Start:%@ End:%@", res.startDate, res.endDate);
        [mutatingResults removeObjectAtIndex:i];
      }
    }
  }
  //NSLog(@"%lu", (unsigned long)mutatingResults.count);
  return mutatingResults;
}

-(NSArray*)fetchReservationsForRoom:(Rooms *)theRoom{
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservations"];
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"room == %@", theRoom];
  fetchRequest.predicate = thePredicate;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:nil];
  return results;

}

@end
