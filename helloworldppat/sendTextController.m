//
//  ThirdViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "sendTextController.h"
#import <Firebase/Firebase.h>
#import "utils.h"
@interface sendTextController ()

@end

@implementation sendTextController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     Firebase *fb1 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/processed/", @"Margaret"]];
    [fb1 removeValue];
    NSLog(@"here");
    Firebase *fb2 = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", @"Margaret"]];
    [fb2 removeValue];
     */
    
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
    [self requestForUserID:@"Margaret" withRequest:@"Bring water"];
}


@end
