//
//  CreateAccountViewController.m
//  helloworldppat
//
//  Created by ldaquila on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Allow users to create an account by entering their name/room number. Nurses
//  should just enter "Nurse" to be taken directly to the Nurse view. Account set-up
//  only occurs after installation.
//  ------------------------------------------------------------------------

#import "CreateAccountViewController.h"
#import <Firebase/Firebase.h>

@interface CreateAccountViewController ()
@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set initial cursor focus to text box
    [self.username becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)createAccount:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:_username.text forKey:@"Username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:FB_USERS];
    
    // Create a new user in firebase, instantiate with default room number xxx-x
    NSDictionary *post1 = @{
                            @"name":_username.text,
                            @"room":_roomNumber.text
                            };
    Firebase *post1Ref = [myRootRef childByAppendingPath: _username.text];
    [post1Ref setValue: post1];
    
    // if username is "Nurse" then go to nurse view, otherwise, go to resident view
    UIViewController *vc;
    if ([_username.text  isEqual: @"Nurse"]) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    } else {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResidentView"];
    }
    
    [self presentViewController:vc animated:NO completion:nil];
}
 


@end
