//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <Firebase/Firebase.h>
#import "utils.h"
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
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:firebaseURL_users];
    
    NSString *photo = @"defaulticon.png";
    if([_username.text  isEqual: @"Margaret"]) {
        photo = @"margaret.png";
    }
    
    
    NSDictionary *post1 = @{
                            @"name":_username.text,
                            @"pic":photo,
                            @"room":@"x-xxx"
                            };
    Firebase *post1Ref = [myRootRef childByAppendingPath: _username.text];
    [post1Ref setValue: post1];
    
    UIViewController *vc;
    if ([_username.text  isEqual: @"Nurse"]) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseView"];
    } else {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResidentView"];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}
 


@end
