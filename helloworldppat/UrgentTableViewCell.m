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
@synthesize cancelRequest = _cancelRequest;
@synthesize processedStatus = _processedStatus;

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)cancelRequest:(id)sender {
    NSLog(@"cancelling request");
    NSLog(@"Deleting this user id: %@", [self userIDHiddenLabel].text);
    NSString *value = [self nameLabel].text;
    //[super cancelRequestForUser: value];
    
    Firebase *fb = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", firebaseURL_requests, value]];
    [fb removeValue];
    
    Firebase *fb1 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", firebaseURL_processed, value]];
    [fb1 removeValue];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:firebaseURL_log];
    NSDictionary *post2 = @{@"user":value,@"text": @"Nurse cancelled Request",@"timestamp":resultString};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
    
}

- (IBAction)requestProcessed:(id)sender {
    NSLog(@"request processed");
    NSLog(@"Processed request from this user id: %@", [self userIDHiddenLabel].text);
    NSString *userID = [self nameLabel].text;
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:firebaseURL_processed];
    // Write data to Firebase
    Firebase *post1Ref = [myRootRef childByAppendingPath: userID];
    NSDictionary *post1 = @{
                            @"text": @"Request Processed",
                            };
    [post1Ref setValue: post1];
    //self.backgroundColor = [UIColor greenColor];
    //[//self processRequest].hidden=TRUE;
    
    //[self cancelRequest].hidden=FALSE;
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:firebaseURL_log];
    NSDictionary *post2 = @{@"user":userID,@"text": @"Nurse Processed Request",@"timestamp":resultString};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
