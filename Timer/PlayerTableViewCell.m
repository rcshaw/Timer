//
//  PlayerTableViewCell.m
//  Timer
//
//  Created by Rose Shaw on 3/14/15.
//  Copyright (c) 2015 Rose Shaw. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize resetButton = _resetButton;



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
