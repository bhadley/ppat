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
@synthesize processRequest = _processRequest;



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
    
    Firebase *fb1 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/processed/", value]];
    [fb1 removeValue];
    
}

- (IBAction)requestProcessed:(id)sender {
    NSLog(@"request processed");
    NSLog(@"Processed request from this user id: %@", [self userIDHiddenLabel].text);
    NSString *userID = [self nameLabel].text;
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/processed"];
    // Write data to Firebase
    Firebase *post1Ref = [myRootRef childByAppendingPath: userID];
    NSDictionary *post1 = @{
                            @"text": @"Hello",
                            };
    [post1Ref setValue: post1];
    self.backgroundColor = [UIColor greenColor];
    NSLog(@"a");
    [self processRequest].hidden=TRUE;
    NSLog(@"b");

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
