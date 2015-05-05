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


@interface SendTextViewController ()
@end

@implementation SendTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set cursor to text box automatically'
    self.requestTxtMsg.delegate = self;
    [self.requestTxtMsg becomeFirstResponder];
    _requestTxtMsg.returnKeyType = UIReturnKeySend;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
 When send button on keyboard pressed, create a post to firebase and show waiting view
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [self.requestTxtMsg resignFirstResponder];
         NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
        
        [utils sendRequestForUser:username withRequest:  _requestTxtMsg.text];
        [self checkWifiAndProceedTo: @"WaitingView"];
        return NO;
    }
    
    return YES;
}

/*
 Verify that the ipad is connected to the internet. If connected,
 proceed to the next screen (either WaitingView or sendTextView) If
 not connected, create an alert notifying user of no internet connectivity
 */
- (void)checkWifiAndProceedTo:(NSString*)nextScreenView {
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:nextScreenView];
        [self presentViewController:vc animated:NO completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"You must be connected to the internet to use this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

/*
 If user closes keyboard, they can still send the request
 */
- (IBAction)cancel:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResidentView"];
    
    [self presentViewController:vc animated:NO completion:nil];
}
/*
 If user closes keyboard, they can still send the request
 */
- (IBAction)sendRequest:(id)sender {
    [self.requestTxtMsg resignFirstResponder];
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    
    [utils sendRequestForUser:username withRequest:  _requestTxtMsg.text];
    [self checkWifiAndProceedTo: @"WaitingView"];
}
@end
