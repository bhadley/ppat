//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "NurseSettingsViewController.h"
#import "utils.h"
@interface NurseSettingsViewController ()

@end

@implementation NurseSettingsViewController


/*
- (IBAction)swipeAction:(UISwipeGestureRecognizer *)recognizer {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    [self presentViewController:vc animated:NO completion:nil];
}
*/

- (IBAction)respondToTapGesture:(UISwipeGestureRecognizer *)recognizer {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    [self presentViewController:vc animated:NO completion:nil];
}


- (IBAction)toggleAction:(id)sender {
    floorToggleMaster = _floorToggle.selectedSegmentIndex;
    /*NSLog([NSString stringWithFormat:@"%d", _floorToggle.selectedSegmentIndex] );*/
}

- (IBAction)backToNurseView: (id)sender {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    [self presentViewController:vc animated:NO completion:nil];
}




- (void)viewDidLoad
{

    [super viewDidLoad];
    _floorToggle.selectedSegmentIndex = floorToggleMaster;
    /*
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipe];
     */
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 3;
    
    // Add the tap gesture recognizer to the view
    [self.view addGestureRecognizer:tapRecognizer];
    
}



@end
