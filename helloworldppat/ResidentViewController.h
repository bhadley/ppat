//
//  ResidentViewController.h
//
//  Created by bhadley on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResidentViewController : UIViewController

- (IBAction)emergency:(id)sender;
- (IBAction)bringWater:(id)sender;
- (IBAction)sendNurse:(id)sender;
- (IBAction)videoChat:(id)sender;
- (IBAction)sendAid:(id)sender;

@property (nonatomic, strong) NSString *username;



@end
