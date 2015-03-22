//
//  NurseTableViewCell.m
//
//  Created by bhadley on 10/25/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  When a request comes in, the nurse may press the "Process Request" button
//  which indicates they have received the request and are taking care of the issue.
//  This changes the cell to the color green and the nurse can then press the "X" button
//  which deletes the request from the table. The methods here only handle updating the
//  firebase database. The NurseViewController interprets these changes and updates the
//  Nurse's table appropriately.
//  ------------------------------------------------------------------------

#import "NurseTableViewCell.h"

#import <Firebase/Firebase.h>
@implementation NurseTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize textLabel = _textLabel;
@synthesize roomLabel = _roomLabel;

@synthesize processRequest = _processRequest;
@synthesize cancelRequest = _cancelRequest;


- (void)awakeFromNib {
}



/*
 PROCESS REQUEST
 Triggered when nurse presses the "Process Request" button. Add the request to 
 the "processed" child under firebase, and log that the nurse processed the request
 in the firebase log.
 */
- (IBAction)requestProcessed:(id)sender {
    NSString *userID = [self nameLabel].text;
    Firebase *firebaseProcessed = [[Firebase alloc] initWithUrl:FB_PROCESSED];
    
    // Write data to Firebase
    Firebase *post1Ref = [firebaseProcessed childByAppendingPath: userID];
    NSDictionary *post1 = @{ @"text": @"Request Processed",};
    [post1Ref setValue: post1];
    
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:FB_LOG];
    NSDictionary *post = @{@"user":userID,
                           @"text": @"Nurse processed request",
                           @"timestamp":[utils getTimeStamp]};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post];

}

/*
 CANCEL REQUEST
 Triggered when nurse presses the X button in the cell of a request. This method
 removes the request from firebase and adds a log entry to firebase
 */
- (IBAction)cancelRequest:(id)sender {
    // remove the request from firebase requests and firebase processed requests
    NSString *value = [self nameLabel].text;
    Firebase *fbRequests = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", FB_REQUESTS, value]];
    [fbRequests removeValue];
    
    Firebase *fbProcessedRequests = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", FB_PROCESSED, value]];
    [fbProcessedRequests removeValue];
    
    // log that the request was cancelled by nurse
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:FB_LOG];
    NSDictionary *post = @{@"user":value,
                           @"text": @"Nurse cancelled request",
                           @"timestamp":[utils getTimeStamp]};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
