//
//  CreateAccountViewController.h
//
//  Created by ldaquila on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController

-(IBAction)createAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *username;
@property (weak, nonatomic) IBOutlet UITextView *roomNumber;
@property (weak, nonatomic) IBOutlet UITextView *loginCode;
@end
