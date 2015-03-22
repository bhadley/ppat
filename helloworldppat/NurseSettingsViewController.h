//
//  ResidentViewController.h
//  helloworldppat
//
//  Created by bhadley on 10/6/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NurseSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *BackToNurseView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *floorToggle;

- (IBAction)toggleAction:(id)sender;
- (IBAction)backToNurseView:(id)sender;


@end
