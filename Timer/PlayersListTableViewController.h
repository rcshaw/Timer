//
//  PlayersListTableViewController.h
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersListTableViewController : UITableViewController
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@property NSMutableArray *players;


@end
