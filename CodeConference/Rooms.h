//
//  Rooms.h
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotels, Reservations;

@interface Rooms : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotels *hotel;
@property (nonatomic, retain) NSSet *reservation;
@end

@interface Rooms (CoreDataGeneratedAccessors)

- (void)addReservationObject:(Reservations *)value;
- (void)removeReservationObject:(Reservations *)value;
- (void)addReservation:(NSSet *)values;
- (void)removeReservation:(NSSet *)values;

@end
