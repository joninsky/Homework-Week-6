//
//  ReservationListViewController.h
//  CodeConference
//
//  Created by Jon Vogel on 2/11/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rooms.h"

@interface ReservationListViewController : UIViewController < UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Rooms *theRoom;

@end
