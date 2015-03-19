//
//  ThirdViewController.h
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NurseSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *BackToNurseView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *floorToggle;

- (IBAction)toggleAction:(id)sender;

- (IBAction)backToNurseView:(id)sender;


@end
