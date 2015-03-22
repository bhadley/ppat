//
//  RequestViewController.h
//  helloworldppat
//
//  Created by amadeus on 10/6/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *requestStatus;
@property (weak, nonatomic) IBOutlet UIImageView *requestStatusIcon;

@property (nonatomic, strong) NSString *username;

@end
