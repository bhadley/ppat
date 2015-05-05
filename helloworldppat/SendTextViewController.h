//
//  SendTextViewController.h
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendTextViewController : UIViewController  <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *requestTxtMsg;
- (IBAction)sendRequest:(id)sender;
- (IBAction)cancel:(id)sender;

@end
