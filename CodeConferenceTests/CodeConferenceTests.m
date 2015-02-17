//
//  CodeConferenceTests.m
//  CodeConferenceTests
//
//  Created by Jon Vogel on 2/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Reservations.h"
#import "HotelService.h"
#import "Rooms.h"
#import "CoreDataStack.h"

@interface CodeConferenceTests : XCTestCase

@property (strong, nonatomic) CoreDataStack *coreDataStack;
@property (strong, nonatomic) HotelService *service;



@end

@implementation CodeConferenceTests

- (void)setUp {
    [super setUp];
  
  
  self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  self.service = [[HotelService alloc] initForTesting];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(void)testCreateReservation {
  Reservations *theReservation;
  Rooms *theRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.service.coreDataStack.managedObjectContext];
  theRoom.number = [[NSNumber alloc] initWithInt:100];
  theRoom.rate = [[NSNumber alloc] initWithInt:100];
  theRoom.beds = [[NSNumber alloc]initWithInt:2];
  NSDate *startDate = [[NSDate alloc] init];
  NSDate *endDate = [[NSDate alloc]initWithTimeInterval:60000 sinceDate:startDate];
  
  theReservation = [self.service createReservation:theRoom withStartData:startDate withEndDate:endDate];
  
  
  //[self.service createReservation:theRoom withStartData:startDate withEndDate:endDate];
  
  XCTAssertNotNil(theReservation, @"The Reservation is not nill");
}


-(void)testHotelSearchForDate{
  NSArray *theArray;
  NSDate *startDate = [[NSDate alloc] init];
  NSDate *endDate = [[NSDate alloc]initWithTimeInterval:60000 sinceDate:startDate];
  
  theArray = [self.service fetchAvailableRoomsForHotelAfterDate:startDate beforeDate:endDate];
  
  XCTAssertNotNil(theArray,@"The array is not nil");
  
}

-(void)testFetchReservationsForRoom{
  NSArray *theArray;
  Rooms *theRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Rooms" inManagedObjectContext:self.service.coreDataStack.managedObjectContext];
  theRoom.number = [[NSNumber alloc] initWithInt:100];
  theRoom.rate = [[NSNumber alloc] initWithInt:100];
  theRoom.beds = [[NSNumber alloc]initWithInt:2];
  
  theArray = [self.service fetchReservationsForRoom:theRoom];
  
  XCTAssertNotNil(theArray, @"Got reservations");
  
}

@end
