//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "SendTextViewController.h"

#import "utils.h"
@interface SendTextViewController ()

@end

@implementation SendTextViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   [self.requestTxtMsg becomeFirstResponder];
    
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


- (IBAction)sendTextMsgRequest:(id)sender {
    NSLog(@"hi!!!");
    NSString *
    username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
  
    [self requestForUserID:username withRequest:  _requestTxtMsg.text];

}
 


@end
