//
//  CoreDataStack.m
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotels.h"
#import "Rooms.h"

@interface CoreDataStack()

@property (nonatomic) BOOL isTesting;

@end


@implementation CoreDataStack


-(instancetype)init{
  self = [super init];
  if (self){
    [self checkToSeed];
  }
  return self;
}

-(instancetype)initForTesting{
  self = [super init];
  if (self) {
    self.isTesting = true;
    [self checkToSeed];
  }
  
  return self;
}

-(void)checkToSeed{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Hotels"];
  
  NSError *fetchError;
  
  NSInteger numberOfResults = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  
  if (numberOfResults == 0){
    
    
    NSURL *seedURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
    NSData *dataFromSeed = [[NSData alloc] initWithContentsOfURL:seedURL];
    NSError *jsonError;
    NSDictionary *dictionaryWithHotels = [NSJSONSerialization JSONObjectWithData:dataFromSeed options:0 error:&jsonError];
    if (!jsonError){
      NSArray *arrayOfHotels = dictionaryWithHotels[@"Hotels"];
      
      for (NSDictionary *hotelDictionary in arrayOfHotels){
        
        Hotels *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotels" inManagedObjectContext:self.managedObjectContext];
        newHotel.name = hotelDictionary[@"name"];
        newHotel.locaiton = hotelDictionary[@"location"];
        newHotel.rating = hotelDictionary[@"stars"];
        
        NSArray *arrayOfRooms = hotelDictionary[@"rooms"];
        
        for (NSDictionary *roomsDictionary in arrayOfRooms){
          
          Rooms *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.managedObjectContext];
          newRoom.number = roomsDictionary[@"number"];
          newRoom.beds = roomsDictionary[@"beds"];
          newRoom.rate = roomsDictionary[@"rate"];
          newRoom.hotel = newHotel;
        }
      }
      [self.managedObjectContext save:nil];
    }
  }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "Me.CodeConference" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CodeConference" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CodeConference.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}



@end
