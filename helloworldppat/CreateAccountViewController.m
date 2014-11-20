//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   [self.username becomeFirstResponder];
    
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


- (IBAction)createAccount:(id)sender {
    NSLog(@"creating account");

    [[NSUserDefaults standardUserDefaults] setValue:_username.text forKey:@"Username"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}
 


@end
