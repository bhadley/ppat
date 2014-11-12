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
    /*
     Firebase *fb1 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/processed/", @"Margaret"]];
    [fb1 removeValue];
    NSLog(@"here");
    Firebase *fb2 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", @"Margaret"]];
    [fb2 removeValue];
     */
    
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

- (IBAction)bringWater:(id)sender {
    NSLog(@"bringWater PRESSED");
    [self requestForUserID:@"Margaret" withRequest:@"Bring water"];
}

- (IBAction)needMedications:(id)sender {
    [self requestForUserID:@"Margaret" withRequest:@"Need Medications"];
}

- (IBAction)getInOutBed:(id)sender {
    [self requestForUserID:@"Margaret" withRequest:@"Would like to get in/out of bed"];
}

- (IBAction)sendAid:(id)sender {
      [self requestForUserID:@"Margaret" withRequest:@"Send Aid"];
}

- (IBAction)videoChat:(id)sender {
    [self requestForUserID:@"Margaret" withRequest:@"video"];
}

- (IBAction)sendNurse:(id)sender {
    [self requestForUserID:@"Margaret" withRequest:@"Send a nurse"];
}


@end
