//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "ThirdViewController.h"

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

- (IBAction)videoChat:(id)sender {
    NSLog(@"videoChat PRESSED");
    [self requestForUserID:@"Margaret" withRequest:@"video"];
}

- (IBAction)sendNurse:(id)sender {
    NSLog(@"sendNurse PRESSED");
    [self requestForUserID:@"Beth" withRequest:@"Send a nurse"];
}

- (IBAction)bringWater:(id)sender {
    NSLog(@"bringWater PRESSED");
    [self requestForUserID:@"Laura" withRequest:@"Bring water"];
}


@end
