//
//  ResidentViewController.m
//
//  Created by bhadley on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Presents a number of buttons to the user to allow them to make requests.
//  The available buttons are: emergency, bringWater, sendAid, sendNurse, videoChat, and sendMessage
//  The first four of these send default text messages to firebase when pressed, and the view
//  proceeds to the request waiting view. The videoChat button initiaties a facetime with
//  the nurse's ipad. The sendMessage button takes the users to a screen where they can enter
//  custom text messages to be sent to firebase. If the ipad is not connected to
//  the internet, the user is notified with a pop-up message.
//  ------------------------------------------------------------------------

#import "ResidentViewController.h"
#import <Firebase/Firebase.h>
#import "NurseViewController.h"

@interface ResidentViewController ()

@end

@implementation ResidentViewController

@synthesize username = _username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// -----------------  Request buttons  -----------------

- (IBAction)emergency:(id)sender {
    [utils sendRequestForUser:self.username withRequest:@"EMERGENCY!! Send help immediately!!!"];
    [self checkWifiAndProceedTo: @"WaitingView"];
}

- (IBAction)bringWater:(id)sender {
    [utils sendRequestForUser:self.username withRequest:@"Bring water"];
    [self checkWifiAndProceedTo: @"WaitingView"];
}

- (IBAction)sendAid:(id)sender {
    [utils sendRequestForUser:self.username withRequest:@"Send Aid"];
    [self checkWifiAndProceedTo: @"WaitingView"];
}

- (IBAction)sendNurse:(id)sender {
    [utils sendRequestForUser:self.username withRequest:@"Send a nurse"];
    [self checkWifiAndProceedTo: @"WaitingView"];
}

- (IBAction)videoChat:(id)sender {
    // set up a facetime with the nurse's ipad, using appleid thebostonhome@mit.edu
    NSURL *url = [NSURL URLWithString:@"facetime://thebostonhome@mit.edu"];
    [[UIApplication sharedApplication] openURL:url];
    
    // log video chat instance
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:FB_LOG];
    NSDictionary *post2 = @{@"user":self.username,@"text": @"Video Chat Initiated",@"timestamp":[utils getTimeStamp]};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
    
}

- (IBAction)sendMessage:(id)sender {
    [self checkWifiAndProceedTo: @"SendTextView"];
}

/*
 Verify that the ipad is connected to the internet. If connected,
 proceed to the next screen (either WaitingView or sendTextView) If
 not connected, create an alert notifying user of no internet connectivity
 */
- (void)checkWifiAndProceedTo:(NSString*)nextScreenView {
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:nextScreenView];
        [self presentViewController:vc animated:NO completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"You must be connected to the internet to use this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


@end
