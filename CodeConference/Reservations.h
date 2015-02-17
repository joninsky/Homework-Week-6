//
//  Reservations.h
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guests, Rooms;

@interface Reservations : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Guests *guest;
@property (nonatomic, retain) Rooms *room;

@end
