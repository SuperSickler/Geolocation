//
//  SimpleTableCell.m
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/7/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell




@synthesize timeLabel = _timeLabel;
@synthesize courseLabel = _courseLabel;
@synthesize speedLabel = _speedLabel;
@synthesize latitudeLabel = _latitudeLabel;
@synthesize longitudeLabel = _longitudeLabel;
@synthesize accuracyLabel = _accuracyLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
