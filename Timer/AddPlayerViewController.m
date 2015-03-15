//
//  AddPlayerViewController.m
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import "AddPlayerViewController.h"

@interface AddPlayerViewController ()

@end

@implementation AddPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.saveButton) return;
    if (self.playerNameField.text.length > 0) {
        self.player = [[Player alloc] init];
        self.player.playerName = self.playerNameField.text;
    }
}


@end
