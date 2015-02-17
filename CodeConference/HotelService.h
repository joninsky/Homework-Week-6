//
//  HotelService.h
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"
#import "Hotels.h"
#import "Rooms.h"
#import "Reservations.h"
#import "Guests.h"

@interface HotelService : NSObject

@property (strong, nonatomic) CoreDataStack *coreDataStack;

+(id)sharedService;
-(instancetype)initForTesting;
-(NSArray *)fetchHotels;
-(Reservations*)createReservation:(Rooms*)theRoom withStartData:(NSDate*)startDate withEndDate:(NSDate*)endDate;
-(NSArray*)fetchAvailableRoomsForHotelAfterDate: (NSDate*)after beforeDate:(NSDate*)before;
-(NSArray*)fetchReservationsForRoom:(Rooms*)theRoom;

@end
