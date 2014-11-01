//
//  ViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "utils.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (IBAction)urgentRequest:(id)sender {
    NSLog(@"urgentRequest");
    [self requestIsUrgent:@"y" forUserID:@"1" withRequest:@"video"];
}



@end
