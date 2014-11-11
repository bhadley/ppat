//
//  UrgentTableViewCell.m
//  helloworldppat
//
//  Created by amadeus on 10/25/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "UrgentTableViewCell.h"

#import "utils.h"
#import <Firebase/Firebase.h>
@implementation UrgentTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize textLabel = _textLabel;
@synthesize residentImage = _residentImage;
@synthesize userIDHiddenLabel = _userIDHiddenLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)cancelRequest:(id)sender {
    NSLog(@"cancelling request");
    NSLog(@"Deleting this user id: %@", [self userIDHiddenLabel].text);
    NSString *value = [self nameLabel].text;
    //[super cancelRequestForUser: value];
    
    Firebase *fb = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", value]];
    [fb removeValue];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
