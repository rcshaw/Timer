//
//  AddPlayerViewController.h
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface AddPlayerViewController : UIViewController

@property Player *player;
@property (weak, nonatomic) IBOutlet UITextField *playerNameField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
