//
//  RoomsListViewController.h
//  CodeConference
//
//  Created by Jon Vogel on 2/9/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotels.h"

@interface RoomsListViewController : UIViewController <UITableViewDataSource>
@property (strong, nonatomic) Hotels *theHotel;
@end
