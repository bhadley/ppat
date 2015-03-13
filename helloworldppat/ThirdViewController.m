//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "ThirdViewController.h"
#import <Firebase/Firebase.h>
#import "UrgentTableViewController.h"
#import "utils.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    // Do any additional setup after loading the view.

    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    
    NSLog(@"username: %@", self.username);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)emergency:(id)sender {
    [self requestForUserID:self.username withRequest:@"EMERGENCY!! Send help immediately!!!"];
    
    [self checkInternetConnectivity];

}





- (IBAction)bringWater:(id)sender {
    NSLog(@"bringWater PRESSED");
    [self requestForUserID:self.username withRequest:@"Bring water"];
    
    [self checkInternetConnectivity];

}

- (IBAction)needMedications:(id)sender {
    [self requestForUserID:self.username withRequest:@"Need Medications"];
    [self checkInternetConnectivity];

}

- (IBAction)getInOutBed:(id)sender {
    [self requestForUserID:self.username withRequest:@"Would like to get in/out of bed"];
    [self checkInternetConnectivity];

}

- (IBAction)sendAid:(id)sender {
      [self requestForUserID:self.username withRequest:@"Send Aid"];
    [self checkInternetConnectivity];

}

- (IBAction)logout:(id)sender {
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAccountView"];
    NSLog(@"logging out");
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)videoChat:(id)sender {
    NSURL *url = [NSURL URLWithString:@"facetime://ppat-teammargaret@mit.edu"];
    [[UIApplication sharedApplication] openURL:url];
    //[self requestForUserID:@"Margaret" withRequest:@"video"];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:firebaseURL_log];
    NSDictionary *post2 = @{@"user":self.username,@"text": @"Video Chat Initiated",@"timestamp":resultString};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
    
}

- (IBAction)sendNurse:(id)sender {
    [self requestForUserID:self.username withRequest:@"Send a nurse"];
    [self checkInternetConnectivity];
}

- (IBAction)sendMessage:(id)sender {
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        NSLog(@"Device is connected to the internet");
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SendTextView"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        NSLog(@"Device is not connected to the internet");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)checkInternetConnectivity {
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        NSLog(@"Device is connected to the internet");
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WaitingView"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        NSLog(@"Device is not connected to the internet");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
