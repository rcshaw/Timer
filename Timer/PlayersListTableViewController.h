//
//  PlayersListTableViewController.h
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#

@interface PlayersListTableViewController : UITableViewController{
    IBOutlet UITableView *tableViewReference; // to keep a reference to the tableview
    UIView *viewReference; // a reference to the new background view
    IBOutlet UIView *myView;
    
}
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@property NSMutableArray *players;

@property (weak, nonatomic) IBOutlet UILabel *slowestPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *fastestPlayerLabel;



@end
