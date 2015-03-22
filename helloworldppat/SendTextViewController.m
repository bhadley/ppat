//
//  SendTextViewController.m
//
//  Created by bhadley on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Handles the send text message view controller, which allows residents
//  to enter a custom text message to send as a request
//  ------------------------------------------------------------------------

#import "SendTextViewController.h"


@interface SendTextViewController()
@end

@implementation SendTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set cursor to text box automatically
    [self.requestTxtMsg becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 When the send text message button is pressed, the text the user entered
 in the text box will be sent to firebase
 */
- (IBAction)sendTextMsgRequest:(id)sender {
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
  
    [utils sendRequestForUser:username withRequest:  _requestTxtMsg.text];

}

@end
