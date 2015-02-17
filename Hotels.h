//
//  Hotels.h
//  CodeConference
//
//  Created by Jon Vogel on 2/10/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rooms;

@interface Hotels : NSManagedObject

@property (nonatomic, retain) NSString * locaiton;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *rooms;
@end

@interface Hotels (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(Rooms *)value;
- (void)removeRoomsObject:(Rooms *)value;
- (void)addRooms:(NSSet *)values;
- (void)removeRooms:(NSSet *)values;

@end
