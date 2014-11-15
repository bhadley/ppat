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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"did load resident view");
    
    // Create a reference to a Firebase location
    Firebase *userRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/processed"];
    [userRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);

        for (FDataSnapshot* childSnap in snapshot.children) {
            if([childSnap.name isEqual: @"Margaret"]) {
                [_requestStatus setText:@"Request processed"];
        
                _requestStatusIcon.image = [UIImage imageNamed:@"checkboxbw.png"];
            }
        }
        
    }];
    
//    Firebase *userRefRequest = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/requests"];
//    [userRefRequest observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        
        //NSString *userDeleted = snapshot.name;
//        if ([snapshot.name  isEqual: @"Margaret"]){
//            ThirdViewController *tc = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"ResidentView"];
//            [self.navigationController pushViewController:tc animated:YES];
            //[self performSegueWithIdentifier: @"backToRequest" sender: self];

 //       }
        
  //  }];
    
    
}


- (IBAction)cancelRequestCall:(id)sender{
    
    NSString *userID = @"Margaret";
    Firebase *fb = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", userID]];
    [fb removeValue];
    
    Firebase *fb2 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/processed/", userID]];
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
