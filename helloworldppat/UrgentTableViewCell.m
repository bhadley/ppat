//
//  UrgentTableViewCell.m
//  helloworldppat
//
//  Created by amadeus on 10/25/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "UrgentTableViewCell.h"


@implementation UrgentTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize textLabel = _textLabel;
@synthesize residentImage = _residentImage;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
