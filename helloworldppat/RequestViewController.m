//
//  RequestViewController.m
//
//  Created by bhadley on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//

#import "RequestViewController.h"
#import <Firebase/Firebase.h>
#import "ResidentViewController.h"

@interface RequestViewController ()

@end

@implementation RequestViewController

@synthesize requestStatus = _requestStatus;
@synthesize username = _username;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];

    // IF REQUEST PROCESSED UPDATE DISPLAY
    Firebase *FIREBASE_PROCESSED = [[Firebase alloc] initWithUrl:FB_PROCESSED];
    [FIREBASE_PROCESSED observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot* childSnap in snapshot.children) {
            if([childSnap.name isEqual: self.username]) {
                [_requestStatus setText:@"Request processed"];
                _requestStatusIcon.image = [UIImage imageNamed:@"checkboxbw.png"];
            }
        }
    }];
    
    // IF REQUEST REMOVED RETURN DISPLAY TO HOME PAGE
    Firebase *FIREBASE_REQUESTS = [[Firebase alloc] initWithUrl:FB_REQUESTS];
    [FIREBASE_REQUESTS observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot.name  isEqual: self.username]){
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResidentView"];
            
            [self presentViewController:vc animated:NO completion:nil];
        }
    }];
}

// IF RESIDENT PRESSES CANCEL REQUEST BUTTON RETURN DISPLAY TO HOME PAGE
- (IBAction)cancelRequestCall:(id)sender{
    // remove from firebase requests and processed requests
    Firebase *FIREBASE_REQUESTS = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", FB_REQUESTS, self.username]];
    [FIREBASE_REQUESTS removeValue];
    
    Firebase *FIREBASE_PROCESSED = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", FB_PROCESSED, self.username]];
    [FIREBASE_PROCESSED removeValue];
    
    // log event to firebase
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:FB_LOG];
    NSDictionary *post2 = @{@"user":self.username,@"text": @"User cancelled request",@"timestamp":[utils getTimeStamp]};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
}


@end
