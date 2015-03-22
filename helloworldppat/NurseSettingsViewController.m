//
//  NurseSettingsViewController.m
//
//  Created by bhadley on 3/6/15.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Allows nurse to adjust settings from nurse view by triple tapping. The tripple
//  tap was used as a way to "discretely hide" these settings so as to prevent
//  confusion while nurses are busy and trying to respond to requests. Alternatively,
//  a swipe feature was considered but deemed too easy to accidentally trigger.
//  ------------------------------------------------------------------------

#import "NurseSettingsViewController.h"

@interface NurseSettingsViewController ()

@end

@implementation NurseSettingsViewController

/*
 Users can triple tap to return to Nurse view (or press button, see below)
 */
- (IBAction)respondToTapGesture:(UISwipeGestureRecognizer *)recognizer {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    [self presentViewController:vc animated:NO completion:nil];
}

/*
 When pressed, set the global nurseFloorToggle variable to the desired
 floor value (see utils)
 */
- (IBAction)toggleAction:(id)sender {
    nurseFloorToggle = _floorToggle.selectedSegmentIndex;
}

/*
 Button that takes users back to Nurse view
 */
- (IBAction)backToNurseView: (id)sender {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    _floorToggle.selectedSegmentIndex = nurseFloorToggle;

    // Create and initialize a triple tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture:)];
    tapRecognizer.numberOfTapsRequired = 3;
    
    // Add the tap gesture recognizer to the view
    [self.view addGestureRecognizer:tapRecognizer];
    
}

@end
