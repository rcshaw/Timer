//
//  PlayersListTableViewController.m
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import "PlayersListTableViewController.h"
#import "Player.h"
#import "AddPlayerViewController.h"
#import "PlayerTableViewCell.h"
#import "limits.h"

@interface PlayersListTableViewController (){
    long min;
    long max;
    bool clicked;
    UITableViewCell *currentCell;
}

@property Player *slowestPlayer;
@property Player *fastestPlayer;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;



@end

@implementation PlayersListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    AddPlayerViewController *source = [segue sourceViewController];
    Player *newPlayer = source.player;
    if (newPlayer != nil) {
        [self.players addObject:newPlayer];
        [self.tableView reloadData];
    }
    
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    self.players = [[NSMutableArray alloc] init];
    [self loadInitialData];
} 
 */

// Override the default accessors of the tableview and view
- (UITableView*)tableView { return tableViewReference; }
- (UIView*)view { return viewReference; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // instantiate the new self.view, similar to the tableview
    self.players = [[NSMutableArray alloc] init];
    [self loadInitialData];
    viewReference = [[UIView alloc] initWithFrame:tableViewReference.frame];
    [viewReference setBackgroundColor:tableViewReference.backgroundColor];
    viewReference.autoresizingMask = tableViewReference.autoresizingMask;
    // add it as a subview
    [viewReference addSubview:tableViewReference];
    
     [self.view addSubview:myView];
    /* remainder of viewDidLoad */
    
}

- (void)loadInitialData {
    Player *p1 = [[Player alloc] init];
    p1.playerName = @"Justin";
    [self.players addObject:p1];
    
    Player *p2 = [[Player alloc] init];
    p2.playerName = @"Rose";
    [self.players addObject:p2];
    
    self.slowestPlayerLabel.text = @"None yet!";
    self.fastestPlayerLabel.text = @"None yet!";
    min = INT_MAX;
    max = INT_MIN;
    //min = 0;
    //max = 0;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.players count];
}

-(void)resetButtonClicked:(UIButton*)sender
{
    Player *player = [self.players objectAtIndex:sender.tag];
    //YOU CAN ONLY RESET WHEN THE TIMER IS NOT RUNNING FOR THIS PARTICULAR PLAYER.
    if (player.running){
        return;
    }
    
    player.counter = 0;

    UIButton *button = (UIButton*)sender;
    UIView *view = button.superview; //Cell contentView
    PlayerTableViewCell *cell = (PlayerTableViewCell *)view.superview;
    
    NSInteger count = player.counter;
    NSNumber *theDouble = [NSNumber numberWithDouble:count];
    
    int inputSeconds = [theDouble intValue];
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
    
    cell.timeLabel.text = theTime;
    
    //apparently as of this line, the label is still not showing. so i believe i have to refresh.
    
    UITableView *tableView = (UITableView *)cell.superview.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



    //this method seems to be called at the beginning, when i first start it.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerTableViewCell" forIndexPath:indexPath];
    Player *player = [self.players objectAtIndex:indexPath.row];
    cell.nameLabel.text = player.playerName;
    
    cell.resetButton.tag = indexPath.row;
    [cell.resetButton addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    NSInteger count = player.counter;
    NSNumber *theDouble = [NSNumber numberWithDouble:count];
    
    int inputSeconds = [theDouble intValue];
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
    
    cell.timeLabel.text = theTime;

    
    if (player.running){
        player.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                            target:self
                                                          selector:@selector(updateTimer:)
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 player, @"value1",
                                                                 cell, @"value2", nil]
                                                           repeats:YES];
    }
    
    //update the slowest & fastest player here
    min = INT_MAX;
    max = INT_MIN;
    if (clicked){
        for (Player* player in self.players)
        {
            if (player.counter < min || player.counter == 0){
                self.fastestPlayer = player;
                min = player.counter;
            }
            if (player.counter > max){
                self.slowestPlayer = player;
                max = player.counter;
            }
        }
    }
    
    
    if (min !=INT_MAX || max != INT_MIN){
        self.slowestPlayerLabel.text = self.slowestPlayer.playerName;
        self.fastestPlayerLabel.text = self.fastestPlayer.playerName;
    }

    return cell;
}



- (void)updateTimer:(NSTimer*)theTimer {
    Player *thePlayer = [[theTimer userInfo] objectForKey:@"value1"];
    
    PlayerTableViewCell *cell =[[theTimer userInfo] objectForKey:@"value2"];
    
    NSInteger count = thePlayer.counter;
    
    
    NSNumber *theDouble = [NSNumber numberWithDouble:count];
    
    int inputSeconds = [theDouble intValue];
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
    
    
    
    cell.timeLabel.text = theTime;
    
    
    ++thePlayer.counter;
    
    //update fastest/slowest if someone overtook the spot
    //update the slowest & fastest player here
    min = INT_MAX;
    max = INT_MIN;
    if (clicked){
        for (Player* player in self.players)
        {
            if (player.counter < min || player.counter == 0){
                self.fastestPlayer = player;
                min = player.counter;
            }
            if (player.counter > max){
                self.slowestPlayer = player;
                max = player.counter;
            }
        }
    }
    
    
    if (min !=INT_MAX || max != INT_MIN){
        self.slowestPlayerLabel.text = self.slowestPlayer.playerName;
        self.fastestPlayerLabel.text = self.fastestPlayer.playerName;
    }
    

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    clicked = true;
    min = INT_MAX;
    max = INT_MIN;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Player *tappedItem = [self.players objectAtIndex:indexPath.row];
    tappedItem.running = !tappedItem.running;
    
    //reload..not sure what this is exactly for, taken from tutorial
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (!tappedItem.running){
        [tappedItem.timer invalidate];
        tappedItem.timer = nil;
    }
    

}

@end
