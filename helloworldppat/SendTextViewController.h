//
//  ThirdViewController.h
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendTextViewController : UIViewController


-(IBAction)sendTextMsgRequest:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *requestTxtMsg;

@end
