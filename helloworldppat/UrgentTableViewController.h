//
//  UrgentTableViewController.h
//  helloworldppat
//
//  Created by amadeus on 10/25/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrgentTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *residentImages;
@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *textRequests;
@property (nonatomic, strong) NSMutableArray *isUrgent;

@property (nonatomic, strong) NSMutableArray *idsFB;
@property (nonatomic, strong) NSMutableArray *namesFB;
@property (nonatomic, strong) NSMutableArray *roomsFB;
@property (nonatomic, strong) NSMutableArray *picturesFB;
@end