//
//  Guests.h
//  CodeConference
//
//  Created by Jon Vogel on 2/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservations;

@interface Guests : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Guests (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservations *)value;
- (void)removeReservationsObject:(Reservations *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
