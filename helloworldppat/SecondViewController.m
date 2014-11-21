//
//  SecondViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "SecondViewController.h"
#import "utils.h"
#import <Firebase/Firebase.h>
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize requestStatus = _requestStatus;
@synthesize username = _username;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"did load resident view");
    
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    
    NSLog(@"username: %@", self.username);
    
    // Create a reference to a Firebase location
    Firebase *userRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/processed"];
    [userRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);

        for (FDataSnapshot* childSnap in snapshot.children) {
            if([childSnap.name isEqual: self.username]) {
                [_requestStatus setText:@"Request processed"];
        
                _requestStatusIcon.image = [UIImage imageNamed:@"checkboxbw.png"];
            }
        }
        
    }];
    
    Firebase *userRefRequest = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/requests"];
    [userRefRequest observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        
        if ([snapshot.name  isEqual: self.username]){
            /*ThirdViewController *tc = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"ResidentView"];
            [self.navigationController pushViewController:tc animated:YES];
            [self performSegueWithIdentifier: @"backToRequest" sender: self];*/
            
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResidentView"];
            [self presentViewController:vc animated:YES completion:nil];

        }
        
    }];
    
    
}


- (IBAction)cancelRequestCall:(id)sender{
    Firebase *fb = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", self.username]];
    [fb removeValue];
    
    Firebase *fb2 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/processed/", self.username]];
    [fb2 removeValue];
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

@end
